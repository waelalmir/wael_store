import 'package:ecommerce/controller/favoritecontroller.dart';
import 'package:ecommerce/controller/itemscontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:ecommerce/view/widget/home/customtitle.dart';
import 'package:ecommerce/view/widget/home/searchfield.dart';
import 'package:ecommerce/view/widget/items/listitems.dart';
import 'package:ecommerce/view/widget/items/listcategorisitems.dart';
import 'package:ecommerce/view/widget/primery%20widget/ListItemsSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemscontrollerImp());
    Favoritecontroller controllerFav = Get.put(Favoritecontroller());
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(15),
        child: GetBuilder<ItemscontrollerImp>(
          builder: (controller) => CustomScrollView(
            slivers: [
              // 1. العناصر غير القابلة للتمرير (البحث والتصنيفات والعنوان)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchField(
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
                    SizedBox(height: 15),
                    Container(height: 58, child: Listcategorisitems()),
                    SizedBox(height: 15),
                    CustomTitleHome(title: "Items"),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              controller.issearch
                  ? SliverToBoxAdapter(
                      child: ListItemsSearch(
                        listData: controller.listdata,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: HandlingDataRequest(
                        statusRequest: controller.statusRequest,
                        widget: GridView.builder(
                          // نستخدم GridView.builder العادي هنا
                          shrinkWrap:
                              true, // مهم: لجعل GridView يعمل داخل SliverToBoxAdapter/CustomScrollView
                          physics:
                              const NeverScrollableScrollPhysics(), // مهم: لجعل الـ CustomScrollView هي المسؤولة عن التمرير
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: controller.data.length,
                          itemBuilder: (BuildContext context, index) {
                            controllerFav.isFavorite[controller.data[index]
                                    ['items_id']] =
                                controller.data[index]['favorite'];
                            return CustomItemsGrid(
                              itemsModel:
                                  ItemsModel.fromJson(controller.data[index]),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
