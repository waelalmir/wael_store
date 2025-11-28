import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/productdetailscontroller.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/productdetails/priceandcount.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final ItemsModel? itemsModel;
  const ProductDetails({super.key, this.itemsModel});

  @override
  Widget build(BuildContext context) {
    // استخدم Get.put() خارج الـ build() أو تأكد من تهيئة الـ Controller بشكل صحيح.
    // لكن بما أنه لا يوجد سياق خارجي، سنبقيه هنا لغرض التصحيح.
    ProductDetailsControllerImp controller =
        Get.put(ProductDetailsControllerImp());

    return Scaffold(
        appBar:
            Customappbar(title: "Product Details".tr), // 💡 يفضل إضافة AppBar
        body: GetBuilder<ProductDetailsControllerImp>(builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Padding(
              // استبدال Container بالـ Padding مباشرة
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  // 1. 🟢 التعديل الرئيسي: استخدام Expanded بدلاً من SizedBox ذو الارتفاع الثابت
                  Expanded(
                    child: ListView(
                      // 💡 ملاحظة: يمكن إزالة الـ ListView إذا لم يكن المحتوى يتجاوز الشاشة
                      // ولكن للإبقاء على إمكانية السكرول، نبقيه.
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CachedNetworkImage(
                                // 💡 الصورة تأخذ 300 بكسل، وهو حجم معقول
                                height: 300,
                                imageUrl:
                                    "${AppLink.imagestItems}/${controller.itemsModel.itemsImage!}",
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                                height: 10), // مسافة ثابتة بسيطة بعد الصورة

                            Text(
                              "${translateDataBase(controller.itemsModel.itemsNameAr, controller.itemsModel.itemsName)}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 15),
                            controller.itemsModel.itemsCount == "0"
                                ? Text("Sold out".tr)
                                : PriceAndCount(
                                    onPressadd: () {
                                      controller.add();
                                    },
                                    onPressremove: () {
                                      controller.remove();
                                    },
                                  ),

                            const SizedBox(height: 15),

                            Text(
                              "Product Details : ".tr,
                              style: TextStyle(
                                  color: AppColor.primeColor, fontSize: 17),
                            ),
                            const SizedBox(height: 12),

                            Text(
                              // 💡 يجب استخدام itemsModel.itemsDesc فقط أو التأكد من طوله.
                              "${controller.itemsModel.itemsDesc} ${controller.itemsModel.itemsDesc} ${controller.itemsModel.itemsDesc} v ${controller.itemsModel.itemsDesc}${controller.itemsModel.itemsDesc}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),

                            // 💡 إزالة SizedBox(height: 60) الذي لا لزوم له
                          ],
                        )
                      ],
                    ),
                  ),
                  // 2. 🟢 الـ Container الخاص بالزر (يتمسك بالارتفاع الثابت 50 بكسل)
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: CustomButtonAuth(
            text: "Go to cart",
            onPressed: () {
              controller.goToCart();
            },
          ),
        ));
  }
}
