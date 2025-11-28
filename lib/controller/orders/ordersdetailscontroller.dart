import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/data/datasource/remote/orders/details.dart';
// تأكد أن هذا الموديل يحتوي على تفاصيل المنتج
import 'package:ecommerce/data/model/ordersdetailsmodel.dart';
import 'package:ecommerce/data/model/ordersmodel.dart';
import 'package:ecommerce/view/screen/orders/mapvieworders.dart';
import 'package:get/get.dart';

class OrdersDetailsController extends GetxController {
  // 1. تعريف مُجمَّع البيانات (القائمة) لتفاصيل المنتجات
  List<OrdersDetailsModel> orderItems = [];

  DetailsOrdersData ordersDetailsData = DetailsOrdersData(Get.find());

  late OrdersModel ordersModel;
  // تم إزالة تعريف orderDetailsModel الفردي

  // استخدام خاصية GetX Observable StatusRequest
  StatusRequest statusRequest = StatusRequest.none;

  // 💥 يتم تهيئة ordersModel هنا قبل استدعاء getData
  @override
  void onInit() {
    // التحقق من وجود المفتاح وتعيين القيمة
    if (Get.arguments != null && Get.arguments.containsKey('ordersmodel')) {
      ordersModel = Get.arguments['ordersmodel'];
      // بمجرد التأكد من أن ordersModel مُهيأ، قم باستدعاء getData
      getData();
    } else {
      // التعامل مع حالة عدم تمرير البيانات (ضروري لتجنب الأخطاء)
      print(
          "Error: ordersmodel argument is missing or null. Cannot fetch data.");
      // هنا يمكنك التوجيه إلى صفحة خطأ أو إنهاء المعالج
      statusRequest = StatusRequest.failure;
    }
    super.onInit();
  }

  String getPayMethodText(String payMethodValue) {
    // التحقق من القيمة المدخلة وتطبيق المنطق
    if (payMethodValue == "0") {
      return "Cash";
    } else if (payMethodValue == "1") {
      return "Card";
    } else {
      // قيمة افتراضية في حال كانت القيمة غير 0 أو 1
      return "Unknown";
    }
  }

  getData() async {
    // 2. تحديث StatusRequest باستخدام الخاصية المُعرَّفة في الكلاس
    statusRequest = StatusRequest.loading;
    update(); // تحديث الواجهة لإظهار حالة التحميل

    // التحقق من أن ordersModel قد تمت تهيئته وأن ordersId موجود
    if (ordersModel.ordersId == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await ordersDetailsData.getData(ordersModel.ordersId!);

    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // 3. فرض أن 'response' هو Map<String, dynamic> مُفكَّك بواسطة handlingData
      // إذا كانت دالة handlingData لا تفكك الـ JSON، قم بإضافة فك الترميز هنا
      // ولكن افتراضياً، معظم أدوات API في Flutter تُعيد استجابة مُفككة مباشرة.

      if (response['status'] == "success") {
        // الوصول مباشرة إلى قائمة البيانات
        List<dynamic> dataList = response['data'];

        // تحويل كل عنصر في القائمة إلى OrderDetailsModel
        orderItems.addAll(dataList.map((item) {
          // 4. لا حاجة لاستخدام .toString() إذا كان نوع item هو Map<String, dynamic>
          return OrdersDetailsModel.fromJson(item);
        }));
      } else {
        statusRequest = StatusRequest.failure;
      }
      print(orderItems);
    }

    // 5. استدعاء update مرة واحدة بعد اكتمال العملية (نجاح أو فشل)
    update();
  }

  goToViewMap() {
    if (ordersModel.addressLat!.isNaN ||
        ordersModel.addressLat!.isInfinite ||
        ordersModel.addressLong!.isNaN ||
        ordersModel.addressLong!.isInfinite) return;

    Get.to(
      () => const OrderMapView(),
      arguments: {
        'lat': ordersModel.addressLat!,
        'long': ordersModel.addressLong!,
        'name': ordersModel.addressName ?? 'Delivery Location',
        'ordersModel': ordersModel
      },
    );
  }
}
