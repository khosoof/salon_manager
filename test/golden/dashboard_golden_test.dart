import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:salon_manager/presentation/pages/dashboard_page.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts(); // از golden_toolkit
  });

  testGoldens('Dashboard golden', (tester) async {
    await tester.pumpWidgetBuilder(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('fa'), Locale('en')],
          path: 'assets/i18n',
          fallbackLocale: const Locale('fa'),
          child: const MaterialApp(home: DashboardPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'dashboard_golden');
  });
}