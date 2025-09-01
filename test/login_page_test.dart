import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:salon_manager/presentation/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  testWidgets('Login page renders', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('fa'), Locale('en')],
          path: 'assets/i18n',
          fallbackLocale: const Locale('fa'),
          child: const MaterialApp(home: LoginPage()),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });
}