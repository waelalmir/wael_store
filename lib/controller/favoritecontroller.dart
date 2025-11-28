import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/favorite_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Favoritecontroller extends GetxController {
  Map isFavorite = {};
  List data = [];

  MyServices myServices = Get.find();
  late StatusRequest statusRequest;
  FavoriteData favoriteData = FavoriteData(Get.find());

  setFavorite(id, val) {
    isFavorite[id] = val.toString();
    update();
  }

  addFav(String itemsid) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update(); // تحديث الواجهة لإظهار مؤشر التحميل
    var response = await favoriteData.addFavorite(
        myServices.sharedPrefrences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // =================   بداية التعديل   =================
      // التحقق من أن response يحتوي على بيانات قبل استخدامه
      if (response != null && response['data'] != null) {
        Get.rawSnackbar(
            title: "notification",
            icon: Icon(Icons.notifications_active),
            messageText: Text("product add it to favorite"));
        //  data.addAll(response['data']);
      } else {
        // إذا كانت البيانات فارغة، اعتبرها كفشل لمنع الخطأ
        print("Response data is null, setting status to failure.");
        statusRequest = StatusRequest.failure;
      }
      // =================   نهاية التعديل   =================
    }
    update(); // تحديث الواجهة لعرض البيانات أو رسالة الخطأ
  }

  removeFav(String itemsid) async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update(); // تحديث الواجهة لإظهار مؤشر التحميل
    var response = await favoriteData.removeFavorite(
        myServices.sharedPrefrences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // =================   بداية التعديل   =================
      // التحقق من أن response يحتوي على بيانات قبل استخدامه
      if (response != null && response['data'] != null) {
        Get.rawSnackbar(
            title: "notification",
            icon: Icon(Icons.notifications_off_rounded),
            messageText: Text("product remove it to favorite"));

        //  data.addAll(response['data']);
      } else {
        // إذا كانت البيانات فارغة، اعتبرها كفشل لمنع الخطأ
        print("Response data is null, setting status to failure.");
        statusRequest = StatusRequest.failure;
      }
      // =================   نهاية التعديل   =================
    }
    update(); // تحديث الواجهة لعرض البيانات أو رسالة الخطأ
  }
}
