import 'package:ecommerce/controller/cartcontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomcartBottomAppBar extends StatelessWidget {
  final String price;
  final String shipping;
  final String coupon;
  final String totalprice;
  final String order;
  final void Function()? onapplycoupon;
  final void Function()? onorder;
  final TextEditingController? couponcontroller;
  const CustomcartBottomAppBar(
      {super.key,
      required this.price,
      required this.shipping,
      required this.totalprice,
      this.couponcontroller,
      this.onapplycoupon,
      required this.coupon,
      this.onorder,
      required this.order});

  @override
  Widget build(BuildContext context) {
    final locale = Get.locale?.languageCode ?? 'en';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              right: locale == 'ar' ? 10 : 0,
              left: locale == 'en' ? 10 : 0,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.primeColor, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: GetBuilder<Cartcontroller>(builder: (controller) {
                    return TextFormField(
                      style: TextStyle(
                          color: controller.couponName == null
                              ? Colors.black
                              : const Color.fromARGB(255, 72, 163, 119),
                          //  fontFamily: "sans",
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              // fontFamily: "sans",
                              fontWeight: FontWeight.w400),
                          hintStyle: TextStyle(
                              //  fontFamily: "sans",
                              fontWeight: FontWeight.w400),
                          hintText: "Have a coupon code?".tr,
                          //  labelText: "Coupon code",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      controller: couponcontroller,
                    );
                  }),
                ),

                // controller.couponName == null ?  :  Text("Your coupon is activated"),

                MaterialButton(
                  height: 50,
                  color: AppColor.primeColor,
                  onPressed: onapplycoupon,
                  child: Text(
                    "Apply".tr,
                    style: TextStyle(color: AppColor.textcolor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Items Price".tr,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                "$price \$",
                style: TextStyle(
                  fontSize: 17,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "shipping".tr,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                "$shipping \$",
                style: TextStyle(
                  fontSize: 17,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Coupon discount".tr,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                "$coupon",
                style: TextStyle(
                  fontSize: 17,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price".tr,
                style: const TextStyle(
                    fontSize: 19,
                    color: AppColor.primeColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "$totalprice \$",
                style: TextStyle(
                    fontSize: 17,
                    color: AppColor.primeColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: AppColor.primeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: onorder,
              child: Center(
                child: Text(
                  order,
                  style: TextStyle(
                      color: AppColor.textcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
