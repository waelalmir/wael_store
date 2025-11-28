import 'package:ecommerce/controller/searchmixcontroller.dart';
import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/myfavorite_data.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:ecommerce/data/model/myfavoritemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Myfavoritecontroller extends SearchMixController {
  getFavItems() {}
}

class MyfavoritecontrollerImp extends Myfavoritecontroller {
  List categories = [];
  MyfavoriteData myfavoriteData = MyfavoriteData(Get.find());
  ItemsModel? itemsModel;

  List<MyfavoriteModel> data = [];
  MyServices myServices = Get.find();

  // ===== التعديل الأول: إزالة late وإعطاء قيمة ابتدائية =====
  StatusRequest statusRequest = StatusRequest.loading; // أو .none إذا أضفتها

  @override
  getFavItems() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    // لا داعي لـ update() هنا لأن onInit سيقوم بتشغيلها والواجهة ستكون في حالة loading بالفعل

    String? userId = myServices.sharedPrefrences.getString("id");
    if (userId == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await myfavoriteData.getData(userId);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        List responseData = response['data'];
        // تحويل كل عنصر في القائمة إلى ItemsModel وإضافته
        data.addAll(
            responseData.map((e) => MyfavoriteModel.fromJson(e)).toList());
      } else {
        print("Response data is null, setting status to failure.");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  removeFromMyfavorite(String favoriteItemId) {
    // ignore: unused_local_variable
    var response = myfavoriteData.removeData(favoriteItemId);
    data.removeWhere((element) =>
        element.favoriteId.toString() == favoriteItemId.toString());
    Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        title: "favorite",
        messageText: Text(
          "item removed from favorite",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primeColor);
    update();
  }

  @override
  void onInit() {
    search = TextEditingController();

    // ===== التعديل الثاني: استدعاء الدالة تلقائياً =====
    getFavItems();
    super.onInit();
  }

  // لا حاجة لدالة initialData الآن، يمكن حذفها
  // initialData() {
  //   getFavItems();
  // }

  goToProductDetails(itemsModel) {
    Get.toNamed(AppRoutes.productDetails,
        arguments: {"itemsModel": itemsModel});
  }
}
