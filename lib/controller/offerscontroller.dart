import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/datasource/remote/offers_data.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:get/get.dart';

class OffersController extends GetxController {
  OffersData offersData = OffersData(Get.find());

  List<ItemsModel> data = [];

  String? offersPrice;

  StatusRequest statusRequest = StatusRequest.none;

  getData() async {
    statusRequest = StatusRequest.loading;

    var response = await offersData.getData();

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // Start backend
      if (response['status'] == "success") {
        List responseData = response['data'];
        data.addAll(
          responseData.map((e) => ItemsModel.fromJson(e)).toList(),
        );
      } else {
        statusRequest = StatusRequest.failure;
      }
      // End
    }
    update();
  }

  goToProductDetails(itemsModel) {
    Get.toNamed(AppRoutes.productDetails,
        arguments: {"itemsModel": itemsModel});
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
