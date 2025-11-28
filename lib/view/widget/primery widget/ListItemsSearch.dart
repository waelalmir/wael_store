import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/searchmixcontroller.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItemsSearch extends StatelessWidget {
  final List<ItemsModel> listData;
  final void Function()? goToDetails;

  const ListItemsSearch({super.key, required this.listData, this.goToDetails});

  @override
  Widget build(BuildContext context) {
    SearchMixController controller = Get.put(SearchMixController());
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        bool isLarge = width > 600; // Tablet or large screens
        String cat = "Category".tr;

        return ListView.builder(
          itemCount: listData.length,
          padding: const EdgeInsets.all(12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = listData[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    controller.goToProductDetails(item);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${AppLink.imagestItems}/${item.itemsImage}",
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            height: isLarge ? 170 : 120,
                            width: isLarge ? 170 : 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${translateDataBase(item.itemsNameAr, item.itemsName)}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: isLarge ? 22 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primeColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "$cat: ${translateDataBase(item.categoriesNameAr, item.categoriesName)}",
                                style: TextStyle(
                                    fontSize: isLarge ? 18 : 14,
                                    color: Colors.grey[700],
                                    fontFamily: "sans"),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item.itemsPrice} \$",
                                    style: TextStyle(
                                      fontSize: isLarge ? 20 : 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primeColor,
                                    ),
                                  ),
                                  Icon(
                                    Icons.favorite_border,
                                    size: isLarge ? 30 : 24,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
