import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fa';
  await EasyLocalization.ensureInitialized();
  await testMain();
}