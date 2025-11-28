import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/favoritecontroller.dart';
import 'package:ecommerce/controller/myfavoritecontroller.dart';
import 'package:ecommerce/core/constant/imageasset.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/data/model/myfavoritemodel.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFavoriteSingleItem extends GetView<MyfavoritecontrollerImp> {
  final MyfavoriteModel myfavoriteModel;

  const CustomFavoriteSingleItem({
    super.key,
    required this.myfavoriteModel,
  });

  @override
  Widget build(BuildContext context) {
    Favoritecontroller controllerFav = Get.put(Favoritecontroller());

    return InkWell(
      onTap: () {
        controller.goToProductDetails(myfavoriteModel.toItemsModel());
      },
      child: Card(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl:
                          "${AppLink.imagestItems}/${myfavoriteModel.itemsImage!}",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,
                      translateDataBase(
                        myfavoriteModel.itemsNameAr ?? "",
                        myfavoriteModel.itemsName ?? "",
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,
                      "${myfavoriteModel.itemsDesc}",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 11,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${myfavoriteModel.itemsPrice} \$",
                          style: TextStyle(fontFamily: "cairo"),
                        ),
                        GetBuilder<MyfavoritecontrollerImp>(
                            builder: (controller) {
                          return IconButton(
                              onPressed: () {
                                // ثالثاً، اطبع الـ Map للتأكد من أنه امتلأ بالبيانات
                                print(
                                    "================ My Favorite Map Content ================");
                                print(controllerFav.isFavorite);
                                controller.removeFromMyfavorite(
                                    myfavoriteModel.favoriteId!.toString());
                              },
                              icon: const Icon(Icons.delete_outlined));
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (myfavoriteModel.itemsDiscount != "0" &&
                myfavoriteModel.itemsCount != "0")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Image.asset(
                      "${AppImageAsset.offer}",
                      height: 50,
                    ),
                  ],
                ),
              ),
            if (myfavoriteModel.itemsCount == "0")
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
