import 'package:ecommerce/controller/home/homepagecontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDiscountCard extends GetView<HomepagecontrollerImp> {
  const CustomDiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 140,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          alignment: AlignmentDirectional.topStart,
          decoration: BoxDecoration(
              color: AppColor.primeColor,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New sales!".tr,
                // "${controller.settings[0]['settings_discounttitlehome']}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "50% Discount".tr,
                //  "${controller.settings[0]['settings_discountbodyhome']}",
                style: TextStyle(color: Colors.white, fontSize: 30),
              )
            ],
          ),
        ),
        Positioned(
          top: -13,
          right: controller.lang == "en" ? -20 : null,
          left: controller.lang == "ar" ? -17 : null,
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.offers);
            },
            child: Container(
              alignment: AlignmentGeometry.center,
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.secondColor),
              child: Text(
                "offers".tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textcolor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
