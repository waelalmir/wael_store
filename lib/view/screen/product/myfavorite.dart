import 'package:ecommerce/controller/myfavoritecontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/class/functions/responsive.dart';
import 'package:ecommerce/view/widget/favorite/favoritesingleitems.dart';
import 'package:ecommerce/view/widget/home/customtitle.dart';
import 'package:ecommerce/view/widget/home/searchfield.dart';
import 'package:ecommerce/view/widget/primery%20widget/ListItemsSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFavorite extends StatelessWidget {
  const MyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive(context);
    Get.put(MyfavoritecontrollerImp());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: GetBuilder<MyfavoritecontrollerImp>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search Field
              SearchField(
                onFieldSubmitted: (val) {
                  controller.onSearchItems();
                },
                mycontroller: controller.search,
                onChanged: (val) {
                  controller.checkSearch(val);
                },
                onPressedsearch: () {
                  controller.onSearchItems();
                },
                fillColor: AppColor.primeColor,
                preicon: Icons.search,
                iconColor: Colors.white,
              ),

              Expanded(
                child: controller.issearch
                    ? HandlingDataRequest(
                        statusRequest: controller.statusRequest,
                        widget: ListItemsSearch(
                          listData: controller.listdata,
                          goToDetails: () {},
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          CustomTitleHome(title: "My Favorite Products :".tr),
                          const SizedBox(height: 15),

                          /// هون GridView داخل Expanded
                          Expanded(
                            child: GetBuilder<MyfavoritecontrollerImp>(
                              builder: (controller) {
                                return HandlingDataRequest(
                                  statusRequest: controller.statusRequest,
                                  isSliver: false,
                                  widget: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio:
                                          r.width(0.7) / r.height(1.1),
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemCount: controller.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return CustomFavoriteSingleItem(
                                        myfavoriteModel: controller.data[index],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              )
            ],
          );
        }),
      ),
    );
  }
}
