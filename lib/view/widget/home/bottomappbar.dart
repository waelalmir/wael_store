import 'package:ecommerce/controller/home/homescreencontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/home/buttonbottomappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) => BottomAppBar(
          height: 75,
          color: AppColor.secondColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                controller.listPage.length + 1,
                (index) {
                  int i = index > 2 ? index - 1 : index;
                  return index == 2
                      ? Expanded(
                          child: SizedBox(
                            width: 30,
                          ),
                        )
                      : Expanded(
                          child: CustomButtonBottomAppbar(
                            text: controller.listNameOfPages[i],
                            onPressed: () => controller.changePage(i),
                            iconbottombutton: controller.listIconsOfPages[i],
                            active: controller.currentPage == i ? true : false,
                          ),
                        );
                },
              )
            ],
          )),
    );
  }
}
