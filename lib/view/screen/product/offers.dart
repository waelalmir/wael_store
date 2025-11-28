import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/offerscontroller.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/localization/changelocal.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.locale?.languageCode == "en";

    Get.put(OffersController());

    return Scaffold(
      appBar: const Customappbar(title: "Offers"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<OffersController>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,

            // عرض القائمة عند النجاح
            widget: ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) => CustomListOffers(
                itemsModel: controller.data[index],
                onTap: () =>
                    controller.goToProductDetails(controller.data[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListOffers extends StatelessWidget {
  final ItemsModel itemsModel;
  final void Function()? onTap;
  const CustomListOffers({super.key, required this.itemsModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LocaleController>().language!.languageCode;
    String discountedPrice =
        itemsModel.itemsdiscprice ?? itemsModel.itemsPrice ?? "0";
    String originalPrice = itemsModel.itemsPrice ?? "0";
    String itemName =
        "${translateDataBase(itemsModel.itemsNameAr, itemsModel.itemsName)}";
    String discountPercentage = itemsModel.itemsDiscount ?? "0";

    String heroTag = itemsModel.itemsId ?? "offer_tag_${itemsModel.hashCode}";

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          "${AppLink.imagestItems}/${itemsModel.itemsImage!}",
                      height: 120,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => const Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$originalPrice \$",
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$discountedPrice \$",
                      style: const TextStyle(
                        color: AppColor.primeColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.primeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: lang == "ar"
                        ? const Radius.circular(0)
                        : Radius.circular(15),
                    topRight: lang == "ar"
                        ? const Radius.circular(0)
                        : Radius.circular(15),
                    bottomRight: lang == "ar"
                        ? const Radius.circular(15)
                        : Radius.circular(0),
                    topLeft: lang == "ar"
                        ? const Radius.circular(15)
                        : Radius.circular(0),
                  ),
                ),
                child: Text(
                  "$discountPercentage% OFF",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
