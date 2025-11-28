import 'package:ecommerce/controller/address/adressaddcontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addressadd extends StatelessWidget {
  const Addressadd({super.key});

  @override
  Widget build(BuildContext context) {
    Adressaddcontroller controller = Get.put(Adressaddcontroller());
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.toNamed(AppRoutes.addressMap);
      }),
      appBar: AppBar(
        title: Text("AddAdress"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              children: [
                CustomTextFormAuth(
                    suffixIcon: Icons.location_city_rounded,
                    hintText: "city",
                    labelText: "city",
                    myController: controller.city,
                    // ignore: body_might_complete_normally_nullable
                    valid: (val) {},
                    isNumber: false),
                CustomTextFormAuth(
                    suffixIcon: Icons.location_city_rounded,
                    hintText: "street",
                    labelText: "street",
                    myController: controller.street,
                    // ignore: body_might_complete_normally_nullable
                    valid: (val) {},
                    isNumber: false),
                CustomTextFormAuth(
                    suffixIcon: Icons.location_city_rounded,
                    hintText: "name",
                    labelText: "name",
                    myController: controller.name,
                    // ignore: body_might_complete_normally_nullable
                    valid: (val) {},
                    isNumber: false),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            WidgetStatePropertyAll(Size(double.infinity, 50)),
                        backgroundColor:
                            WidgetStatePropertyAll(AppColor.primeColor)),
                    onPressed: () {
                      controller.addAddress();
                    },
                    child: Text(
                      "Add Address",
                      style: TextStyle(
                          color: AppColor.textcolor,
                          fontFamily: "cairo",
                          fontSize: 17),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
