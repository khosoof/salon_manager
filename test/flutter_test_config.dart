import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Locale پیش‌فرض برای عدد/تاریخ
  Intl.defaultLocale = 'fa';

  // Mock in-memory برای shared_preferences (بدون علامت ?)
  SharedPreferences.setMockInitialValues(<String, Object>{});

  // init برای EasyLocalization
  await EasyLocalization.ensureInitialized();

  await testMain();
}