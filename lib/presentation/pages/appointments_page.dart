import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/repos/appointments_repo.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});
  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  late final AppointmentsRepo _repo;
  bool _loading = true;
  List<AppointmentEntity> _items = [];

  @override
  void initState() {
    super.initState();
    _repo = makeAppointmentsRepo();
    _load();
  }

  Future<void> _load() async {
    final rows = await _repo.list();
    if (!mounted) return;
    setState(() {
      _items = rows;
      _loading = false;
    });
  }

  Future<void> _quick() async {
    try {
      final id = await _repo.quickCreate();
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${'booking_created'.tr()} (#$id)')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('appointments'.tr())),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _quick,
        label: Text('quick_book'.tr()),
        icon: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (_items.isEmpty
              ? Center(child: Text('no_appointments'.tr()))
              : ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final a = _items[i];
                    return ListTile(
                      leading: const Icon(Icons.event),
                      title: Text('وضعیت: ${a.status} | شعبه: ${a.branch}'),
                      subtitle: Text('${a.start}  →  ${a.end}'),
                      trailing: Text('#${a.id}'),
                    );
                  },
                )),
    );
  }
}
