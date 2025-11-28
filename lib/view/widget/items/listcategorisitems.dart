import 'package:ecommerce/controller/itemscontroller.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/data/model/categoriesmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/utils.dart';

class Listcategorisitems extends GetView<ItemscontrollerImp> {
  const Listcategorisitems({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemscontrollerImp());
    return SizedBox(
        height: 50,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Categories(
                i: index,
                categoriesModel:
                    CategoriesModel.fromJson(controller.categories[index]));
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 50,
          ),
          itemCount: controller.categories.length,
        ));
  }
}

class Categories extends GetView<ItemscontrollerImp> {
  final CategoriesModel categoriesModel;
  final int? i;
  const Categories({super.key, required this.categoriesModel, this.i});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //controller.goToItems(controller.categories, i);
        controller.changeCat(i!, categoriesModel.categoriesId.toString());
        // controller.updateItems(categoriesModel.categoriesId.toString());

        print(i);
      },
      child: GetBuilder<ItemscontrollerImp>(builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: controller.selectedcat == i
              ? BoxDecoration(
                  color: AppColor.secondColor,
                  borderRadius: BorderRadius.circular(15))
              : BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(15)),
          child: Column(children: [
            Text(
              "${translateDataBase(categoriesModel.categoriesNameAr, categoriesModel.categoriesName)}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Image.network(
            //     width: 140,
            //     "${AppLink.imageststatic}/${categoriesModel.categoriesImage}")
          ]),
        );
      }),
    );
  }
}
