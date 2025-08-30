import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/payments/mock_gateway.dart';
import '../../core/payments/payment_gateway.dart';

class POSPage extends StatefulWidget {
  const POSPage({super.key});
  @override
  State<POSPage> createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> {
  final _amount = TextEditingController(text: '500000');
  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pos'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'amount_rial'.tr()),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                final g = MockPaymentGateway();
                final r = await g.pay(
                  amountRials: int.tryParse(_amount.text) ?? 0,
                  orderId: 'ORDER-DEMO',
                );
                setState(() => result = r.success
                    ? '${'paid_success'.tr()}: ${r.trackingCode ?? ''}'
                    : '${'paid_failed'.tr()}: ${r.message ?? ''}');
              },
              child: Text('pay_mock'.tr()),
            ),
            const SizedBox(height: 16),
            if (result != null && result!.isNotEmpty) Text(result!),
          ],
        ),
      ),
    );
  }
}
