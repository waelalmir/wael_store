import 'package:ecommerce/controller/cartcontroller.dart';
import 'package:ecommerce/core/class/functions/responsive.dart';
import 'package:ecommerce/core/class/functions/translatedatabase.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/linkapi.dart';
import 'package:ecommerce/view/widget/cart/cartitems.dart';
import 'package:ecommerce/view/widget/cart/customcartbottomappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    Cartcontroller cartcontroller = Get.put(Cartcontroller());
    return Scaffold(
      bottomNavigationBar: GetBuilder<Cartcontroller>(builder: (controller) {
        return CustomcartBottomAppBar(
          onapplycoupon: () {
            controller.checkCoupon();
          },
          couponcontroller: controller.controllercoupon,
          price: "${cartcontroller.priceorders}",
          shipping: "10",
          coupon: "${cartcontroller.coupondiscount}",
          totalprice: "${cartcontroller.getTotalPrice()}",
          order: "order".tr,
          onorder: () {
            cartcontroller.goToCheckout();
          },
        );
      }),
      appBar: Customappbar(title: "My Cart".tr),
      body: GetBuilder<Cartcontroller>(
        builder: (controller) {
          Responsive r = Responsive(context);

          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView(
              children: [
                ...List.generate(controller.data.length, (index) {
                  final model = controller.data[index];

                  return CartItem(
                    model: controller.data[index],
                    r: r,
                    count: "${model.countitems}",
                    name:
                        "${translateDataBase(model.itemsNameAr, model.itemsName)}",
                    price: "${model.itemsPrice}",
                    imagename: "${AppLink.imagestItems}/${model.itemsImage}",
                    onAdd: () async {
                      await cartcontroller.addToCart(model.itemsId);
                      cartcontroller.refreshPage();
                    },
                    onRemove: () async {
                      await cartcontroller.removeFromCart(model.itemsId);
                      cartcontroller.refreshPage();
                    },
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
