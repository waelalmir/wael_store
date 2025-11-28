import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/data/datasource/remote/home_data.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchMixController extends GetxController {
  bool issearch = false;
  TextEditingController search = TextEditingController();
  HomeData homeData = HomeData(Get.find());
  List<ItemsModel> listdata = [];
  late StatusRequest statusRequest;

  checkSearch(val) {
    if (val == "") {
      issearch = false;
    }
    update();
  }

  onSearchItems() {
    issearch = true;
    searchData();
    update();
  }

  searchData() async {
    listdata.clear();
    statusRequest = StatusRequest.loading;
    var response = await homeData.searchData(search.text);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List responsedata = response['data'];
        listdata.addAll(responsedata.map((e) => ItemsModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  goToProductDetails(itemsModel) {
    Get.toNamed(AppRoutes.productDetails,
        arguments: {"itemsModel": itemsModel});
  }
}
