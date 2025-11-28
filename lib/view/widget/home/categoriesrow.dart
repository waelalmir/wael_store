import 'package:ecommerce/controller/home/homepagecontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/data/model/categoriesmodel.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class CustomCategoriesRow extends GetView<HomepagecontrollerImp> {
  const CustomCategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
          height: 100,
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
              width: 0,
            ),
            itemCount: controller.categories.length,
          )),
    );
  }
}

class Categories extends GetView<HomepagecontrollerImp> {
  final CategoriesModel categoriesModel;
  final int? i;
  const Categories({super.key, required this.categoriesModel, this.i});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToItems(
            controller.categories, i, categoriesModel.categoriesId.toString());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 70,
        width: 90,
        decoration: BoxDecoration(
            color: AppColor.primeColor, borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Text(
            "${translateDataBase(categoriesModel.categoriesNameAr, categoriesModel.categoriesName)}",
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Image.network(
                width: 140,
                "${AppLink.imageststatic}/${categoriesModel.categoriesImage}"),
          )
        ]),
      ),
    );
  }
}
