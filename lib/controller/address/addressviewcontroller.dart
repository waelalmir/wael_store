import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/address.dart';
import 'package:ecommerce/data/model/addressmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addressviewcontroller extends GetxController {
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  AddressData addressData = AddressData(Get.find());

  late String usersid = myServices.sharedPrefrences.getString("id")!;

  List<AddressModel> data = [];

  // في ملف Addressviewcontroller.dart

  viewAddress() async {
    statusRequest = StatusRequest.loading;
    update(); // <--- تحديث الواجهة لحالة التحميل

    var response = await addressData.viewAddress(usersid);
    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        List responseData = response['data'];
        data.addAll(responseData.map((e) => AddressModel.fromJson(e)).toList());
      } else {
        // ✅ إذا كان الرد ناجحاً لكن قائمة البيانات فارغة
        print(
            "Response data is null or empty, setting status to failure if needed.");
        // إذا كانت القائمة فارغة لكن الـ status هو "success" من الخادم، اترك الـ statusRequest = StatusRequest.success
        if (data.isEmpty) {
          // يمكن إبقاؤها ناجحة لعرض واجهة "لا يوجد بيانات"
          // أو تعيينها كـ failure إذا كان لا يُتوقع أن تكون فارغة
          statusRequest = StatusRequest.success;
        }
      }
    }

    update(); // <--- تحديث الواجهة لحالة الانتهاء (سواء نجاح أو فشل)
  }

  deleteAddress(String addressid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await addressData.deleteAdress(addressid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      data.removeWhere(
          (element) => element.addressId.toString() == addressid.toString());

      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        title: "Address",
        messageText: Text(
          "Address deleted successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primeColor,
      );
    } else {
      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        messageText: Text(
          "Failed to delete address",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }

    update();
  }

  goToaddAdress() {
    Get.toNamed(AppRoutes.addressAdd);
  }

  @override
  void onInit() {
    viewAddress();
    super.onInit();
  }
}
