import 'package:ecommerce/controller/settingscontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/imageasset.dart';
import 'package:ecommerce/core/shared/slidefade.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    Settingscontroller controller = Get.put(Settingscontroller());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(height: 20),

          // ========== PROFILE ==========
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.grey.shade300, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      AppImageAsset.personprofile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Welcome Back 👋".tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ========== SETTINGS ==========
          ...List.generate(
            controller.settingsections.length,
            (index) {
              return SlideFadeAnimationOffline(
                delay: index * 400,
                child: Container( 
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColor.primeColor.withOpacity(0.15),
                      child: Icon(
                        controller.settingsections[index]["icon"],
                        color: AppColor.primeColor,
                      ),
                    ),
                    title: Text(
                      controller.settingsections[index]["title"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "cairo",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      if (index == 4) controller.logOut();
                      if (index == 3) controller.openLang();
                      if (index == 1) controller.goToaddress();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
