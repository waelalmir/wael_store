import 'package:ecommerce/controller/productdetailscontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PriceAndCount extends GetView<ProductDetailsControllerImp> {
  final void Function()? onPressadd;
  final void Function()? onPressremove;
  final ItemsModel? itemsModel;

  const PriceAndCount(
      {super.key, this.itemsModel, this.onPressadd, this.onPressremove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: onPressadd, icon: Icon(Icons.add)),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: AppColor.primeColor)),
                child: Text(
                  "${controller.countItems}",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "sans",
                      color: Colors.grey[700]),
                ),
              ),
              IconButton(onPressed: onPressremove, icon: Icon(Icons.remove))
            ],
          ),
          controller.itemsModel.itemsDiscount == "0"
              ? Text(
                  "${controller.itemsModel.itemsdiscprice}\$",
                  style: const TextStyle(
                      fontFamily: "sans",
                      fontSize: 25,
                      color: AppColor.primeColor),
                )
              : Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.baseline, // محاذاة النص على خط الأساس
                  textBaseline: TextBaseline.alphabetic, // تحديد خط الأساس
                  children: [
                    const SizedBox(width: 15),
                    if (controller.itemsModel.itemsDiscount != "0")
                      Text(
                        "${controller.itemsModel.itemsPrice}\$",
                        style: const TextStyle(
                          fontSize: 18, // حجم أصغر للسعر الملغي
                          color: Colors.grey,
                          decoration: TextDecoration
                              .lineThrough, // ⬅️ إضافة الخط في المنتصف
                        ),
                      ),
                    const SizedBox(width: 15),
                    Text(
                      "${controller.itemsModel.itemsdiscprice ?? controller.itemsModel.itemsPrice ?? "0"}\$",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primeColor),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
