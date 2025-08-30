import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'appointments_repo_interface.dart';

const _kKey = 'web_appointments_v1';

class _MemAppt implements AppointmentEntity {
  _MemAppt(this.id, this.start, this.end, this.status, this.branch);
  @override final int id;
  @override final DateTime start;
  @override final DateTime end;
  @override final String status;
  @override final String branch;

  Map<String, dynamic> toMap() => {
    'id': id,
    'start': start.toIso8601String(),
    'end': end.toIso8601String(),
    'status': status,
    'branch': branch,
  };

  factory _MemAppt.fromMap(Map<String, dynamic> m) => _MemAppt(
    m['id'] as int,
    DateTime.parse(m['start'] as String),
    DateTime.parse(m['end'] as String),
    m['status'] as String,
    m['branch'] as String,
  );
}

class AppointmentsRepoImpl implements AppointmentsRepo {
  static int _counter = 0;
  static List<_MemAppt> _items = [];
  static bool _loaded = false;

  Future<void> _loadOnce() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kKey);
    if (raw != null && raw.isNotEmpty) {
      final List list = jsonDecode(raw) as List;
      _items = list.map((e) => _MemAppt.fromMap(Map<String, dynamic>.from(e))).toList();
      if (_items.isNotEmpty) {
        _counter = _items.map((e) => e.id).reduce((a, b) => a > b ? a : b);
      }
    }
    _loaded = true;
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _items.map((e) => e.toMap()).toList();
    await prefs.setString(_kKey, jsonEncode(list));
  }

  @override
  Future<List<AppointmentEntity>> list() async {
    await _loadOnce();
    return List<_MemAppt>.from(_items);
  }

  @override
  Future<int> quickCreate() async {
    await _loadOnce();
    final now = DateTime.now();
    final start = now.add(const Duration(minutes: 5));
    final end = start.add(const Duration(minutes: 30));
    final id = ++_counter;
    _items.add(_MemAppt(id, start, end, 'confirmed', 'main'));
    await _save();
    return id;
  }
}
