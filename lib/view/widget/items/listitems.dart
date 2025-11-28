import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/favoritecontroller.dart';
import 'package:ecommerce/controller/itemscontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/imageasset.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItemsGrid extends GetView<ItemscontrollerImp> {
  final ItemsModel itemsModel;
  const CustomItemsGrid({
    super.key,
    required this.itemsModel,
  });

  @override
  Widget build(BuildContext context) {
    Favoritecontroller controllerFav = Get.find();

    return InkWell(
      onTap: () {
        controller.goToProductDetails(itemsModel);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    height: 90,
                    imageUrl:
                        "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Text(
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    translateDataBase(
                        itemsModel.itemsNameAr, itemsModel.itemsName),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      textAlign: TextAlign.center,
                      "${itemsModel.itemsDesc}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (itemsModel.itemsDiscount != "0")
                                Text(
                                  "${itemsModel.itemsdiscprice ?? itemsModel.itemsPrice ?? "0"}\$ ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "cairo",
                                      color: AppColor.primeColor,
                                      fontSize: 17),
                                ),
                              Text(
                                itemsModel.itemsDiscount != "0"
                                    ? "${itemsModel.itemsPrice}"
                                    : "${itemsModel.itemsPrice}\$",
                                style: TextStyle(
                                  fontWeight: itemsModel.itemsDiscount == "0"
                                      ? FontWeight.bold
                                      : null,
                                  fontFamily: "cairo",
                                  // 1. الشرط هنا يعمل بشكل صحيح:
                                  decoration: itemsModel.itemsDiscount != "0"
                                      ? TextDecoration
                                          .lineThrough // إذا كان الشرط صحيحاً
                                      : TextDecoration
                                          .none, // إذا كان الشرط خاطئاً
                                  // 2. يمكنك إضافة خصائص أخرى بعد الشرط
                                  color: itemsModel.itemsDiscount != "0"
                                      ? Colors.grey
                                      : AppColor.primeColor, // مثال
                                  fontSize: itemsModel.itemsDiscount != "0"
                                      ? 14
                                      : 17, // مثال
                                ),
                              ),
                            ],
                          ),
                          GetBuilder<Favoritecontroller>(builder: (controller) {
                            return IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  // ثالثاً، اطبع الـ Map للتأكد من أنه امتلأ بالبيانات
                                  print(
                                      "================ My Favorite Map Content ================");
                                  print(controllerFav.isFavorite);
                                  if (controller
                                          .isFavorite[itemsModel.itemsId] ==
                                      "1") {
                                    controller.setFavorite(
                                        itemsModel.itemsId, "0");
                                    controllerFav
                                        .removeFav(itemsModel.itemsId!);
                                  } else {
                                    controller.setFavorite(
                                        itemsModel.itemsId, "1");
                                    controllerFav.addFav(itemsModel.itemsId!);
                                  }
                                },
                                icon: Icon(
                                    controller.isFavorite[itemsModel.itemsId] ==
                                            "1"
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined));
                          })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (itemsModel.itemsDiscount != "0" && itemsModel.itemsCount != "0")
              Image.asset(
                "${AppImageAsset.offer}",
                height: 50,
              ),
            if (itemsModel.itemsCount == "0")
              Image.asset(
                "${AppImageAsset.sold}",
                height: 50,
              )
          ],
        ),
      ),
    );
  }
}
