import 'package:intl/intl.dart';
String formatCurrency(num amount,{String currency='IRR'}){final f=NumberFormat.currency(locale:'fa',symbol:currency=='IRR'?'﷼':currency);return f.format(amount);}