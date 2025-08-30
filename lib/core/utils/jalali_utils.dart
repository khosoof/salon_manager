import 'package:shamsi_date/shamsi_date.dart';
String formatJalali(DateTime dt){final j=Jalali.fromDateTime(dt);return '${j.year}/${j.month.toString().padLeft(2,'0')}/${j.day.toString().padLeft(2,'0')}';}
