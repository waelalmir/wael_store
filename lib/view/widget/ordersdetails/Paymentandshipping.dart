import 'package:flutter/material.dart';

class Paymentandshipping extends StatelessWidget {
  final String payMethod;
  final String shippingCost;
  final String couponUsed;
  const Paymentandshipping(
      {super.key,
      required this.payMethod,
      required this.shippingCost,
      required this.couponUsed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment & Shipping",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 15, thickness: 1),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Payment Method:",
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(payMethod),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Shipping Cost:",
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(shippingCost),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Coupon Used:",
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(couponUsed),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
