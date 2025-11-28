import 'package:ecommerce/controller/checkoutontroller.dart';
import 'package:ecommerce/core/class/functions/responsive.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/imageasset.dart';
import 'package:ecommerce/core/shared/customappbar.dart';

import 'package:ecommerce/view/widget/primery%20widget/bottomprimarybutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    Checkoutontroller controller = Get.put(Checkoutontroller());
    final Responsive r = Responsive(context);

    return Scaffold(
      appBar: Customappbar(title: "Checkout".tr),

      // زر إتمام الطلب
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            horizontal: r.padding(15), vertical: r.padding(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, -3),
            )
          ],
        ),
        child: CustomBottomNavigationButton(
          onPressed: () => controller.checkOut(),
          title: "Checkout".tr,
        ),
      ),

      body: GetBuilder<Checkoutontroller>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView(
              padding: EdgeInsets.all(r.padding(18)),
              children: [
                // ******** Payment Section ********
                Center(
                  child: Text(
                    "Payment Method".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: r.height(15)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _paymentCard(
                      title: "PayPal".tr,
                      image: AppImageAsset.paypal,
                      active: controller.payMethod == "0",
                      onTap: () => controller.paymentMethod("0"),
                    ),
                    _paymentCard(
                      title: "Cash".tr,
                      image: AppImageAsset.money,
                      active: controller.payMethod == "1",
                      onTap: () => controller.paymentMethod("1"),
                    ),
                  ],
                ),

                SizedBox(height: r.height(30)),

                // ******** Shipping Section ********
                Center(
                  child: Text(
                    "Shipping Address".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: r.height(25)),

                ...List.generate(
                  controller.data.length,
                  (i) {
                    final item = controller.data[i];

                    return Padding(
                      padding: EdgeInsets.only(bottom: r.padding(15)),
                      child: _addressCard(
                        title: "${item.addressName}, ${item.addressCity}",
                        active:
                            controller.addressid == item.addressId.toString(),
                        onTap: () => controller.address(item.addressId),
                      ),
                    );
                  },
                ),

                SizedBox(height: r.height(15)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _paymentCard({
    required String title,
    required String image,
    required bool active,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 140,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: active
              ? AppColor.secondColor.withValues(alpha: .2)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: active ? AppColor.primeColor : Colors.grey.shade300,
            width: active ? 3 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black12,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            Image.asset(image, width: 45),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addressCard({
    required String title,
    required bool active,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: active
              ? AppColor.secondColor
              // .withValues(alpha: .12)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active ? AppColor.primeColor : Colors.grey.shade300,
            width: active ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: Colors.black12,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: active ? AppColor.primeColor : AppColor.thirdColor,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: active ? AppColor.textcolor : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
