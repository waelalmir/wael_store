import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/orders/delete.dart';
import 'package:ecommerce/data/datasource/remote/orders/pending.dart';
import 'package:ecommerce/data/model/ordersmodel.dart';
import 'package:get/get.dart';

class Orderscontroller extends GetxController {
  MyServices myServices = Get.find();
  PendingOrdersData ordersPendingData = Get.put(PendingOrdersData(Get.find()));
  DeleteOrdersData deleteOrdersData = Get.put(DeleteOrdersData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;

  late String usersid = myServices.sharedPrefrences.getString("id")!;

  List<OrdersModel> data = [];

  List<bool> animated = [];

  String? payMethod;
  late String addressid;

  viewOrders() async {}

  deleteOrders(String orderid) async {}

  ratingOrder(String ordersid, double rating, String comment) async {}

  String getPayMethodText(String payMethodValue) {
    if (payMethodValue == "0") {
      return "Cash";
    } else if (payMethodValue == "1") {
      return "Card";
    } else {
      return "Unknown";
    }
  }

  refrehOrder() {
    viewOrders();
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

  goToArchiveOrders() {
    Get.toNamed(AppRoutes.archiveDetails);
  }

  @override
  void onInit() {
    viewOrders();
    super.onInit();
  }
}
