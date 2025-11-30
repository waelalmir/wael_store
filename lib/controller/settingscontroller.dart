import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/localization/changelocal.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settingscontroller extends LocaleController {
  MyServices myServices = Get.find();
  logOut() {
    String id = myServices.sharedPrefrences.getString("id")!;
    FirebaseMessaging.instance.unsubscribeFromTopic("users");
    FirebaseMessaging.instance.unsubscribeFromTopic("users$id");
    myServices.sharedPrefrences.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  goToaddress() {
    Get.toNamed(AppRoutes.address);
  }

  openLang() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.textcolor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -3),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Change Language",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            InkWell(
              onTap: () {
                changeLang("ar");
                Get.offAllNamed(AppRoutes.homePage);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColor.primeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "العربية",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textcolor),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            InkWell(
              onTap: () {
                changeLang("en");
                Get.offAllNamed(AppRoutes.homePage);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColor.primeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "English",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textcolor),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  List settingsections = [
    {"title": "Contact us".tr, "icon": Icons.person},
    {"title": "Address".tr, "icon": Icons.location_on},
    {"title": "AboutUs".tr, "icon": Icons.info},
    {"title": "Language".tr, "icon": Icons.language},
    {"title": "LogOut".tr, "icon": Icons.logout},
  ];
}
