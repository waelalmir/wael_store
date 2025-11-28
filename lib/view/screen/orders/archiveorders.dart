import 'package:ecommerce/controller/orders/archiveorders.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/core/shared/slidefadeonline.dart';

import 'package:ecommerce/data/model/ordersmodel.dart';
import 'package:ecommerce/view/widget/orders/ratingdialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Archiveorders extends StatelessWidget {
  const Archiveorders({super.key});

  @override
  Widget build(BuildContext context) {
    // Orderscontroller controller =
    Get.put(ArchiveordersController());
    return Scaffold(
      appBar: Customappbar(title: "archiveorders".tr),
      body: GetBuilder<ArchiveordersController>(builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            child: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, i) => SlideFadeAnimation(
                      delay: i * 300,
                      animatedBefore: controller.animated[i],
                      onAnimated: () {
                        controller.animated[i] = true;
                      },
                      child: OrdersSingleItem(
                        ratingbuttontext: "Rating",
                        onPressRating: () {
                          showDialogRating(
                              context, controller.data[i].ordersId!);
                        },

                        onPressDetails: () {
                          Get.toNamed(AppRoutes.ordersDetails,
                              arguments: {"ordersmodel": controller.data[i]});
                        },

                        buttontext: "Details",
                        id: "#${controller.data[i].ordersId.toString()}",
                        date: controller.data[i].ordersDatetime!,
                        //  address: controller.data[i].addressName,
                        payType: controller.getPayMethodText(
                            controller.data[i].ordersPaymentmethod!),
                        listdata: controller.data[i],
                      ),
                    )),
          ),
        );
      }),
    );
  }
}

class OrdersSingleItem extends StatelessWidget {
  final String id;
  final String date;
  final String payType;
  final String buttontext;
  final String ratingbuttontext;
  final OrdersModel listdata;
  final void Function()? onPressDetails;
  final void Function()? onPressRating;
  const OrdersSingleItem({
    super.key,
    required this.listdata,
    required this.id,
    required this.date,
    required this.payType,
    required this.buttontext,
    this.onPressDetails,
    required this.ratingbuttontext,
    this.onPressRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(id, style: TextStyle(fontSize: 19)),
                        Text(date),
                      ],
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(payType, style: TextStyle(fontSize: 15)),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColor.primeColor)),
                        onPressed: onPressDetails,
                        child: Text(buttontext,
                            style: TextStyle(color: AppColor.textcolor))),
                    if (listdata.ordersRating == "0")
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColor.primeColor)),
                          onPressed: onPressRating,
                          child: Text(ratingbuttontext,
                              style: TextStyle(color: AppColor.textcolor)))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
