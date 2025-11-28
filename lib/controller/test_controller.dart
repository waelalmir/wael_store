import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/data/datasource/remote/test_data.dart';

import 'package:get/get.dart';

class TestController extends GetxController {
  TestData testData = TestData(Get.find());

  List data = [];

  // من الأفضل إعطاء قيمة ابتدائية للحالة
  late StatusRequest statusRequest;

  getData() async {
    statusRequest = StatusRequest.loading;
    update(); // تحديث الواجهة لإظهار مؤشر التحميل
    var response = await testData.getData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // =================   بداية التعديل   =================
      // التحقق من أن response يحتوي على بيانات قبل استخدامه
      if (response != null && response['data'] != null) {
        data.addAll(response['data']);
      } else {
        // إذا كانت البيانات فارغة، اعتبرها كفشل لمنع الخطأ
        print("Response data is null, setting status to failure.");
        statusRequest = StatusRequest.failure;
      }
      // =================   نهاية التعديل   =================
    }
    update(); // تحديث الواجهة لعرض البيانات أو رسالة الخطأ
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
