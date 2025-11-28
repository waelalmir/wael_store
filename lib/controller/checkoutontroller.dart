import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/address.dart';
import 'package:ecommerce/data/datasource/remote/checkout_data.dart';
import 'package:ecommerce/data/model/addressmodel.dart';
import 'package:get/get.dart';

class Checkoutontroller extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  AddressData addressData = Get.put(AddressData(Get.find()));
  CheckoutData checkoutData = Get.put(CheckoutData(Get.find()));
  String? payMethod;
  String? addressid;
  String? ordersDiscount;

  late String priceorders;
  late String itemprice;
  late String couponid;

  List categories = [];
  List<AddressModel> data = [];
  choosePaymentMethod(String val) {
    payMethod = val;
    update();
  }

  chooseShippingAddress(String val) {
    addressid = val;
    update();
  }

  getShippingAddress() async {
    statusRequest = StatusRequest.loading;
    update(); // <--- تحديث الواجهة لحالة التحميل

    var response = await addressData
        .viewAddress(myServices.sharedPrefrences.getString("id")!);
    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        List responseData = response['data'];
        data.addAll(responseData.map((e) => AddressModel.fromJson(e)).toList());
        addressid = data[0].addressId.toString();
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

    update();
  }

  checkOut() async {
    if (payMethod == null) {
      return Get.snackbar("Alert", 'please Choose Paymethod !!');
    }
    if (addressid == null) {
      return Get.snackbar("Alert", 'please Choose an Address !!');
    }
    statusRequest = StatusRequest.loading;
    update(); // <--- تحديث الواجهة لحالة التحميل
    Map data = {
      "usersid": myServices.sharedPrefrences.getString("id"),
      "addressid": addressid.toString(),
      //  "orderstype": deliveryType.toString(),
      "pricedelivery": "10",
      "ordersprice": priceorders,
      "couponid": couponid,
      // "coupondiscount": coupondiscount.toString(),
      "paymentmethod": payMethod.toString(),
      "orderitemprice": itemprice.toString(),
    };
    var response = await checkoutData.getData(data);
    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // List responseData = response['data'];
      // data.addAll(responseData.map((e) => AddressModel.fromJson(e)).toList());
      Get.offAllNamed(AppRoutes.homePage);
      print("success");
    } else {
      statusRequest = StatusRequest.none;
      Get.snackbar("Alert", "Your cart is Empty");
    }

    update();
  }

  paymentMethod(val) {
    payMethod = val;
    update();
  }

  address(val) {
    addressid = val.toString();
    update();
  }

  @override
  void onInit() {
    priceorders = Get.arguments['priceorders'];
    couponid = Get.arguments['couponid'];
    ordersDiscount = Get.arguments['coupondiscount'].toString();
    itemprice = Get.arguments['orderitemprice'].toString();
    getShippingAddress();
    super.onInit();
  }
}
