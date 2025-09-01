import 'package:flutter_test/flutter_test.dart';
import 'package:salon_manager/core/utils/formatters.dart';

void main() {
  test('formatCurrency IRR', () {
    final out = formatCurrency(1234567, currency: 'IRR');

    // نرمال‌سازی ساده: حذف LRM/RLM و فاصله
    final normalized = out.replaceAll('\u200f', '').replaceAll('\u200e', '').replaceAll(' ', '');

    // پذیرش هر دو حالت قبل/بعد از عدد و هم ارقام فارسی و هم لاتین
    final ok = normalized == '﷼۱٬۲۳۴٬۵۶۷'
            || normalized == '۱٬۲۳۴٬۵۶۷﷼'
            || normalized == '﷼1,234,567'
            || normalized == '1,234,567﷼';

    expect(ok, true, reason: 'Unexpected IRR format: $out');
  });
}