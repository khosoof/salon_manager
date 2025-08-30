import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('dashboard'.tr())),
      drawer: const _MainDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('dashboard'.tr(), style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text('appointments'.tr()),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12, runSpacing: 12,
            children: const [
              _Tile(labelKey: 'appointments', route: '/appointments'),
              _Tile(labelKey: 'pos',          route: '/pos'),
              _Tile(labelKey: 'settings',     route: '/settings'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String labelKey;
  final String route;
  const _Tile({required this.labelKey, required this.route});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220, height: 100,
      child: Card(
        child: InkWell(
          onTap: () => context.go(route),
          child: Center(child: Text(labelKey.tr())),
        ),
      ),
    );
  }
}

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    final items = [
      ['dashboard','/'],
      ['appointments','/appointments'],
      ['customers','/customers'],
      ['services','/services'],
      ['staff','/staff'],
      ['pos','/pos'],
      ['inventory','/inventory'],
      ['branches','/branches'],
      ['notifications','/notifications'],
      ['reports','/reports'],
      ['settings','/settings'],
      ['scan_qr','/scan'],
    ];
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('dashboard'.tr())),
          for (final i in items)
            ListTile(
              title: Text(i[0]!.tr()),
              onTap: () {
                Navigator.pop(context);
                context.go(i[1]!);
              },
            ),
        ],
      ),
    );
  }
}
