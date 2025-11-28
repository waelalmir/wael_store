import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/home/homepagecontroller.dart';
import 'package:ecommerce/core/class/functions/responsive.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/core/constant/imageasset.dart';
import 'package:ecommerce/core/shared/scroll_view.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItemsRow extends GetView<HomepagecontrollerImp> {
  const CustomItemsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: InfiniteHorizontalList(
          isAuto: false,
          itemCount: controller.topsellingList.length,
          itemBuilder: (context, index) {
            return ItemsHome(
              itemsModel: controller.topsellingList[index],
              index: index,
            );
          },
        ));
  }
}

class ItemsHome extends StatelessWidget {
  final ItemsModel itemsModel;
  final int index; // أضفنا المتغير
 
  const ItemsHome({
    super.key,
    required this.itemsModel,
    required this.index, // أضفناه
  });

  @override
  Widget build(BuildContext context) {  
    final Responsive r = Responsive(context);
    HomepagecontrollerImp controller = Get.put(HomepagecontrollerImp());
    return InkWell(
      onTap: () => controller.goToProductDetails(itemsModel),
      child: Container(
        height: 160,
        margin: const EdgeInsets.only(left: 0, top: 20, bottom: 20, right: 15),
        decoration: BoxDecoration(
            color: AppColor.primeColor,
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                      height: 140,
                      imageUrl:
                          "${AppLink.imagestItems}/${itemsModel.itemsImage}"),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: 40,
                  width: 200,
                  child: Stack(
                      clipBehavior: Clip.antiAlias,
                      alignment: const AlignmentGeometry.directional(0, 0),
                      children: [
                        Positioned(
                          child: Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: AppColor.secondColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                            ),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "${translateDataBase(itemsModel.itemsNameAr, itemsModel.itemsName)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: r.font(19),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                )
              ],
            ),
            // الرقم التلقائي
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(r.padding(4)),
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    Image.asset(AppImageAsset.crown,
                        height: r.height(40), width: r.width(40)),
                    Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(73, 255, 255, 255),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            "${index + 1}", // الرقم يبدأ من 1
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: r.font(16),
                                color: AppColor.primeColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
