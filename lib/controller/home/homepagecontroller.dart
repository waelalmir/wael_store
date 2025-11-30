import 'package:ecommerce/controller/searchmixcontroller.dart';
import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/home_data.dart';
import 'package:ecommerce/data/datasource/remote/items_data.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

abstract class Homepagecontroller extends SearchMixController {
  initialData();
  getdata();
  goToItems(categories, selectedcat, String catId) {}
}

class HomepagecontrollerImp extends Homepagecontroller {
  MyServices myServices = Get.find();
  String? username;
  HomeData homeData = HomeData(Get.find());
  ItemsData itemsData = ItemsData(Get.find());
  List<ItemsModel> data = [];
  List<ItemsModel> topsellingList = [];
  List settings = [];

  List categories = [];
  List items = [];
  String? catId;
  String? lang;


  @override
  StatusRequest statusRequest = StatusRequest.none;

  @override
  initialData() {
    getdata();
    getTopselling();
    username = myServices.sharedPrefrences.getString("username");
    lang = myServices.sharedPrefrences.getString("lang");
  }

  @override
  getdata() async {
    statusRequest = StatusRequest.loading;
    var response = await homeData.getData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        categories.addAll(response['categories']['data']);
        items.addAll(response['items']['data']);
        settings.addAll(response['settings']['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getTopselling() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await itemsData.getTopSelling();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        topsellingList.clear();
        List dataresponse = response['data'];
        topsellingList.addAll(dataresponse.map((e) => ItemsModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "no topSells found");
    }
    update();
  }

  @override
  goToItems(categories, selectedcat, String catId) {
    Get.toNamed(AppRoutes.itemsPage, arguments: {
      "categories": categories,
      "selectedcat": selectedcat,
      "catId": catId,
    });
  }

 

  goToMyFavorite() {
    Get.toNamed(AppRoutes.myfavorite);
  }

  @override
  void onInit() {
    search = TextEditingController();

    initialData();
    super.onInit();
  }
}
