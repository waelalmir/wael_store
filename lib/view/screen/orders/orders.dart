import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/responsive.dart';
import 'package:ecommerce/core/shared/slidefadeonline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/data/model/ordersmodel.dart';
import 'package:ecommerce/controller/orders/orderscontroller.dart';
import 'package:ecommerce/view/widget/orders/ratingdialog.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    Orderscontroller controller = Get.put(Orderscontroller());

    return Scaffold(
      appBar: AppBar(
        title: Text("orders".tr),
        actions: [
          InkWell(
            onTap: () => controller.goToArchiveOrders(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "archiveorders".tr,
                style: TextStyle(
                  color: AppColor.textcolor,
                ),
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<Orderscontroller>(builder: (controller) {
        return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              // physics: const BouncingScrollPhysics(),
              itemCount: controller.data.length,
              itemBuilder: (context, i) {
                OrdersModel model = controller.data[i];
                String method =
                    controller.getPayMethodText(model.ordersPaymentmethod!);

                return SlideFadeAnimation(
                  delay: i * 120, // كل عنصر يتأخر 120ms عن اللي قبله
                  animatedBefore: controller.animated[i],
                  onAnimated: () {
                    controller.animated[i] = true;
                  },
                  child: OrdersSingleItem(
                    ratingbuttontext: "Rating",
                    onPressRating: () {
                      showDialogRating(context, controller.data[i].ordersId!);
                    },
                    onPressDelete: () {
                      controller
                          .deleteOrders(controller.data[i].ordersId.toString());
                    },
                    onPressDetails: () {
                      Get.toNamed(AppRoutes.ordersDetails,
                          arguments: {"ordersmodel": controller.data[i]});
                    },
                    payMethodIcon: method == "Cash"
                        ? Icons.money_rounded
                        : Icons.payment_rounded,
                    deletebuttontext: "Delete",
                    buttontext: "Details",
                    id: "#${controller.data[i].ordersId}",
                    date: controller.data[i].ordersDatetime!,
                    payType: controller.getPayMethodText(
                      controller.data[i].ordersPaymentmethod!,
                    ),
                    listdata: controller.data[i],
                  ),
                );
              },
            ));
      }),
    );
  }
}

class OrdersSingleItem extends StatelessWidget {
  final String id;
  final String date;
  final String payType;
  final String buttontext;
  final String deletebuttontext;
  final String ratingbuttontext;
  final OrdersModel listdata;
  final IconData payMethodIcon;
  final void Function()? onPressDetails;
  final void Function()? onPressDelete;
  final void Function()? onPressRating;

  const OrdersSingleItem({
    super.key,
    required this.listdata,
    required this.id,
    required this.date,
    required this.payType,
    required this.buttontext,
    this.onPressDetails,
    required this.deletebuttontext,
    this.onPressDelete,
    required this.ratingbuttontext,
    this.onPressRating,
    required this.payMethodIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 500;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(r.padding(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row 1 — Order ID + Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(id,
                      style: TextStyle(
                        fontSize: r.font(18),
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: r.font(13),
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Divider(),

              /// Row 2 — Payment + Buttons
              const SizedBox(height: 6),

              Row(
                children: [
                  Icon(payMethodIcon, color: AppColor.primeColor),
                  const SizedBox(width: 8),
                  Text(
                    payType,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _mobileButtons(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _desktopButtons(),
                    )
            ],
          ),
        ),
      ),
    );
  }

  /// ========== BUTTON STYLES ==========

  List<Widget> _mobileButtons() {
    return [
      _mainButton(buttontext, onPressDetails),
      const SizedBox(height: 8),
      _dangerButton(deletebuttontext, onPressDelete),
      if (listdata.ordersRating == "0") ...[
        const SizedBox(height: 8),
        _mainButton(ratingbuttontext, onPressRating),
      ],
    ];
  }

  List<Widget> _desktopButtons() {
    return [
      _mainButton(buttontext, onPressDetails),
      _dangerButton(deletebuttontext, onPressDelete),
      if (listdata.ordersRating == "0")
        _mainButton(ratingbuttontext, onPressRating),
    ];
  }

  Widget _mainButton(String text, void Function()? onPress) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primeColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPress,
      child: Text(text, style: TextStyle(color: AppColor.textcolor)),
    );
  }

  Widget _dangerButton(String text, void Function()? onPress) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[400],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPress,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
