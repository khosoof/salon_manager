import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // لازم برای هر تست ویجت
  TestWidgetsFlutterBinding.ensureInitialized();

  // زبان پیش‌فرض برای intl (فرمت پول و …)
  Intl.defaultLocale = 'fa';

  // آماده‌سازی easy_localization (برای tr())
  await EasyLocalization.ensureInitialized();

  // فونت‌ها برای تست‌های گلدن
  await loadAppFonts();

  // حالا تست‌ها را اجرا کن
  await testMain();
}