import 'package:ecommerce/controller/favoritecontroller.dart';
import 'package:ecommerce/controller/searchmixcontroller.dart';
import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/items_data.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ItemsController extends SearchMixController {
  initialData() {}
  changeCat(val, String catval) {}
  getItems(String catId) {}
  updateItems(String catId) {}

  // goToProductDetails(ItemsModel itemsModel) {}
}

class ItemscontrollerImp extends ItemsController {
  List categories = [];
  int? selectedcat;
  ItemsData itemsData = ItemsData(Get.find());
  ItemsModel? itemsModel;

  List data = [];
  String? catId;
  MyServices myServices = Get.find();
  // من الأفضل إعطاء قيمة ابتدائية للحالة
  late StatusRequest statusRequest;

  @override
  getItems(catId) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update(); // تحديث الواجهة لإظهار مؤشر التحميل

    // تأكد من أن myServices.sharedPrefrences.getString("id") لا تُرجع null
    // إذا كان يمكن أن تكون null، يجب توفير قيمة افتراضية أو معالجة الحالة
    String? userId = myServices.sharedPrefrences.getString("id");
    if (userId == null) {
      // يمكنك هنا إظهار خطأ أو التعامل مع حالة عدم تسجيل الدخول
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await itemsData.getData(catId, userId);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        data.addAll(response['data']);

        Favoritecontroller favController = Get.find();

        for (var item in data) {
          favController.setFavorite(
              item['items_id'].toString(), item['favorite'].toString());
        }
      } else {
        print("Response data is null, setting status to failure.");
        statusRequest = StatusRequest.failure;
      }
    }
    update(); // تحديث الواجهة لعرض البيانات أو رسالة الخطأ
  }

  @override
  void onInit() {
    initialData();
    search = TextEditingController();
    super.onInit();
  }

  @override
  initialData() {
    categories = Get.arguments['categories'];
    selectedcat = Get.arguments['selectedcat'];
    catId = Get.arguments['catId'];
    getItems(catId!);
  }

  @override
  changeCat(val, String catval) {
    selectedcat = val;
    getItems(catval);

    update();
  }

  goToProductDetails(itemsModel) {
    Get.toNamed(AppRoutes.productDetails,
        arguments: {"itemsModel": itemsModel});
  }
}
