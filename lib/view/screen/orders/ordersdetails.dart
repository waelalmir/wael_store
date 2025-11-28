import 'package:ecommerce/controller/orders/ordersdetailscontroller.dart';
import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/ordersdetails/Paymentandshipping.dart';
import 'package:ecommerce/view/widget/ordersdetails/addressandmap.dart';
import 'package:ecommerce/view/widget/ordersdetails/ordersummary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersDetailsController());

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Order Details", style: TextStyle(color: Colors.black)),
        backgroundColor: AppColor.primeColor,
        elevation: 0.5,
      ),
      body: GetBuilder<OrdersDetailsController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.ordersModel.ordersId == null) {
            return const Center(
                child: Text("Order details not available or missing ID."));
          }
          if (controller.statusRequest == StatusRequest.failure &&
              controller.orderItems.isEmpty) {
            return const Center(child: Text("No items found for this order."));
          }

          final model = controller.ordersModel;

          return ListView(
            padding: const EdgeInsets.all(15),
            children: [
              // -------------------- Order Summary --------------------

              Ordersummary(
                  orderID: "#${model.ordersId ?? 'N/A'}",
                  orderDate: model.ordersDatetime ?? 'N/A',
                  totalPrice: "\$ ${model.ordersPrice ?? '0.0'}"),
              const SizedBox(height: 15),

              // -------------------- Payment & Shipping --------------------

              Paymentandshipping(
                payMethod: controller
                    .getPayMethodText(model.ordersPaymentmethod ?? '0'),
                shippingCost: "\$ ${model.ordersPricedelivery ?? '0.0'}",
                couponUsed: model.ordersCoupon != '0'
                    ? (model.ordersCoupon ?? 'No')
                    : 'No',
              ),
              const SizedBox(height: 15),

              // -------------------- Address --------------------

              Addressandmap(
                onPressMap: () {
                  controller.goToViewMap();
                },
                addressName: model.addressName ?? 'N/A',
                addressDetails:
                    "${model.addressStreet ?? ''}, ${model.addressCity ?? 'N/A'}",
                addressLat: model.addressLat!,
                addressLong: model.addressLong!,
              ),

              const SizedBox(height: 15),

              // -------------------- Order Items --------------------
              Text("Order Items (${controller.orderItems.length})",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Divider(height: 15, thickness: 1),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.orderItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.orderItems[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.shade200, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_bag_outlined,
                              color: AppColor.primeColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    item.itemsName ??
                                        item.itemsNameAr ??
                                        'Item Name',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Text("Qty: ${item.countitems ?? 1}",
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                          Text("\$ ${item.cartItemsprice?.toString() ?? '0.0'}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
