import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/orders/archive.dart';
import 'package:ecommerce/data/model/ordersmodel.dart';
import 'package:get/get.dart';

class ArchiveordersController extends GetxController {
  MyServices myServices = Get.find();
  ArchiveOrdersData archiveOrdersData = Get.put(ArchiveOrdersData(Get.find()));

  StatusRequest statusRequest = StatusRequest.none;
  late String usersid = myServices.sharedPrefrences.getString("id")!;
  List<OrdersModel> data = [];
  List<bool> animated = [];

  late String payMethod;
  late String addressid;

  viewOrders() async {
    statusRequest = StatusRequest.loading;

    update();
    var response = await archiveOrdersData
        .getData(myServices.sharedPrefrences.getString("id")!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        data.clear();

        List dataresponse = response['data'];
        data.addAll(dataresponse.map((e) => OrdersModel.fromJson(e)));
        animated = List<bool>.filled(data.length, false);
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "There was no archive orders yet");
    }
    update();
  }

  ratingOrder(String ordersid, double rating, String comment) async {
    statusRequest = StatusRequest.loading;

    update();
    var response = await archiveOrdersData.ratingOrdersData(
        ordersid, rating.toString(), comment);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      refrehOrder();
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "rating order failed");
    }
    update();
  }

  refrehOrder() {
    viewOrders();
  }

  String getPayMethodText(String payMethodValue) {
    if (payMethodValue == "0") {
      return "Cash";
    } else if (payMethodValue == "1") {
      return "Card";
    } else {
      return "Unknown";
    }
  }

  String printOrderStatus(String val) {
    if (val == "0") {
      return "Pending Approval";
    } else if (val == "1") {
      return "The Order is being Prepared ";
    } else if (val == "2") {
      return "Ready To Picked up by Delivery man";
    } else if (val == "3") {
      return "On The Way";
    } else {
      return "Archive";
    }
  }

  @override
  void onInit() {
    viewOrders();
    super.onInit();
  }
}
