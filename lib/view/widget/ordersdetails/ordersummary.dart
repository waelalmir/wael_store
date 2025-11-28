import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ordersummary extends StatelessWidget {
  final String orderID;
  final String orderDate;
  final String totalPrice;
  const Ordersummary(
      {super.key,
      required this.orderID,
      required this.orderDate,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Summary",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.primeColor)),
            const Divider(height: 15, thickness: 1),

            // Order ID
            Row(
              children: [
                const Icon(Icons.receipt_long,
                    color: AppColor.primeColor, size: 20),
                const SizedBox(width: 10),
                const Expanded(
                    child: Text("Order ID", style: TextStyle(fontSize: 15))),
                Text(orderID),
              ],
            ),
            const SizedBox(height: 8),

            // Order Date
            Row(
              children: [
                const Icon(Icons.calendar_month,
                    color: AppColor.primeColor, size: 20),
                const SizedBox(width: 10),
                const Expanded(
                    child: Text("Order Date", style: TextStyle(fontSize: 15))),
                Text(orderDate),
              ],
            ),
            const SizedBox(height: 8),

            // Total
            Row(
              children: [
                const Icon(Icons.payments, color: Colors.redAccent, size: 20),
                const SizedBox(width: 10),
                const Expanded(
                    child: Text("Total Price",
                        style: TextStyle(fontSize: 15, color: Colors.black))),
                Text(totalPrice,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
