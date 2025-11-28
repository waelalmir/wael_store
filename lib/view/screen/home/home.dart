import 'package:ecommerce/controller/home/homepagecontroller.dart';
import 'package:ecommerce/controller/home/homescreencontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/class/functions/responsive.dart';
import 'package:ecommerce/core/shared/scroll_view.dart';
import 'package:ecommerce/data/model/categoriesmodel.dart';

import 'package:ecommerce/view/widget/home/categoriesrow.dart';
import 'package:ecommerce/view/widget/home/custom_discount_card.dart';
import 'package:ecommerce/view/widget/home/customtitle.dart';
import 'package:ecommerce/view/widget/home/itemsrow.dart';
import 'package:ecommerce/view/widget/home/searchfield.dart';
import 'package:ecommerce/view/widget/primery%20widget/ListItemsSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive(context);

    Get.put(HomepagecontrollerImp());
    Get.put(HomeScreenControllerImp());
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 1,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 184, 142, 150),
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: GetBuilder<HomepagecontrollerImp>(
            builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding: EdgeInsets.only(
                  right: r.padding(10),
                  left: r.padding(10),
                  top: r.padding(10),
                ),
                child: ListView(
                  children: [
                    //search
                    Row(
                      children: [
                        Expanded(
                            child: SearchField(
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
                          fillColor: AppColor.secondColor,
                          preicon: Icons.search,
                          iconColor: Colors.white,
                        )),
                      ],
                    ),
                    controller.issearch
                        ? ListItemsSearch(
                            listData: controller.listdata,
                            goToDetails: () {
                              controller
                                  .goToProductDetails(controller.listdata[0]);
                            },
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                if (controller.settings.isNotEmpty)
                                  const CustomDiscountCard(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: CustomTitleHome(
                                        title: "categories".tr)),
                                SizedBox(
                                    height: 110,
                                    child: InfiniteHorizontalList(
                                      itemCount: controller.categories.length,
                                      itemBuilder: (context, index) {
                                        return Categories(
                                          categoriesModel:
                                              CategoriesModel.fromJson(
                                                  controller.categories[index]),
                                          i: index,
                                        );
                                      },
                                    )),

                                Center(
                                    child: CustomTitleHome(
                                        title: "topselling".tr)),

                                const CustomItemsRow(),

                                ///
                              ])
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
