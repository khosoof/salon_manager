import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor openConnection() {
  // ignore: avoid_print
  print('DRIFT WEB => Using IndexedDB (WebDatabase)'); // برای اطمینان در کنسول
  return WebDatabase('salon_manager');
}
