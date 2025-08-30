import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/dashboard_page.dart';
import '../../presentation/pages/appointments_page.dart';
import '../../presentation/pages/pos_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/customers_page.dart';
import '../../presentation/pages/services_page.dart';
import '../../presentation/pages/staff_page.dart';
import '../../presentation/pages/inventory_page.dart';
import '../../presentation/pages/branches_page.dart';
import '../../presentation/pages/notifications_page.dart';
import '../../presentation/pages/reports_page.dart';
import '../../presentation/pages/scanner_page.dart';

GoRouter buildRouter(WidgetRef ref, Object _env) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
      GoRoute(path: '/appointments', builder: (context, state) => const AppointmentsPage()),
      GoRoute(path: '/customers', builder: (context, state) => const CustomersPage()),
      GoRoute(path: '/services', builder: (context, state) => const ServicesPage()),
      GoRoute(path: '/staff', builder: (context, state) => const StaffPage()),
      GoRoute(path: '/pos', builder: (context, state) => const POSPage()),
      GoRoute(path: '/inventory', builder: (context, state) => const InventoryPage()),
      GoRoute(path: '/branches', builder: (context, state) => const BranchesPage()),
      GoRoute(path: '/notifications', builder: (context, state) => const NotificationsPage()),
      GoRoute(path: '/reports', builder: (context, state) => const ReportsPage()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
      GoRoute(path: '/scan', builder: (context, state) => const ScannerPage()),
    ],
  );
}
