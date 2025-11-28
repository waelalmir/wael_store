import 'package:ecommerce/controller/home/homescreencontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/home/bottomappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) => Scaffold(
        floatingActionButton: IconButton(
            style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                backgroundColor: WidgetStatePropertyAll(AppColor.secondColor)),
            color: Colors.white,
            onPressed: () {
              controller.goToCart();
            },
            icon: Icon(Icons.shopping_basket_outlined)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomAppBar(),
        body: controller.listPage.elementAt(controller.currentPage),
      ),
    );
  }
}
