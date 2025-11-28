import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FluttermapController extends GetxController {
  // ✅ متحكم الخريطة (خاص بمكتبة flutter_map) لتحريك الكاميرا لاحقاً
  final MapController mapWidgetController = MapController();
  // =======================================================
  // 1. مفاتيح API والحالة (State)
  // =======================================================

  // 📍 موقع المتجر الثابت (نقطة البداية الدائمة)
  final LatLng storeLocation = const LatLng(33.5138, 36.2765);

  final String stadiaApiKey = '0a51e892-7c40-44f6-a6a3-ebe7994f3c9a';
  // 💡 يجب استبدال هذا المفتاح بمفتاحك من OpenRouteService
  final String openRouteServiceApiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6ImY1NjMzYTJhZTA2MDQ2MjI5M2MwMDRlOWM5YWI0NGQyIiwiaCI6Im11cm11cjY0In0=';

  // إحداثيات مركز الخريطة الابتدائية
  LatLng mapCenter = const LatLng(33.5138, 36.2765);
  double currentZoom = 13.0;
  var isLoading = false.obs;
  List<Marker> markers = []; // علامات المتجر
  List<Marker> tappedMarker = []; // علامة موقع التسليم

  // 🧭 متغيرات المسار (Routing)
  List<LatLng> routePoints = []; // لتخزين نقاط خط المسار
  LatLng? deliveryLocation; // نقطة النهاية (موقع التسليم يحدده المستخدم)

  // متغيرات لتخزين نتيجة المسار
  String distance = '0.0 km';
  String duration = '0 min';

  // =======================================================
  // 2. التهيئة (Initialization)
  // =======================================================
  @override
  void onInit() {
    super.onInit();
    _initializeMarkers();
    // ضبط مركز الخريطة الأولي على موقع المتجر
    mapCenter = storeLocation;
  }

  // =======================================================
  // 3. المنطق (Logic)
  // =======================================================

  // دالة النقر: تحديد موقع التسليم (نقطة النهاية)
  void handleMapTap(LatLng latLng) {
    // 1. تحديد نقطة النهاية
    deliveryLocation = latLng;
    routePoints = []; // مسح المسار القديم

    // 2. تحديث علامة موقع التسليم
    tappedMarker = [
      Marker(
        width: 80.0,
        height: 80.0,
        point: latLng,
        child: const Icon(
          Icons.pin_drop,
          color: Colors.redAccent, // علامة التسليم باللون الأزرق
          size: 40.0,
        ),
      ),
    ];

    Get.snackbar("موقع تسليم مُحدَّد", "جارٍ حساب المسار...");

    // 3. جلب المسار وحساب المسافة والوقت
    getRoute();
    update();
  }

  // دالة جلب المسار من OpenRouteService وحساب النتائج
  Future<void> getRoute() async {
    final startPoint = storeLocation; // نقطة البداية ثابتة (المتجر)

    if (deliveryLocation == null) return;

    // تنسيق الطلب: خط طول، خط عرض (ORS)
    String startLngLat = "${startPoint.longitude},${startPoint.latitude}";
    String endLngLat =
        "${deliveryLocation!.longitude},${deliveryLocation!.latitude}";

    // بناء URL طلب المسار
    // السطر الأصلي (للسيارة):
// String url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$openRouteServiceApiKey&start=$startLngLat&end=$endLngLat';

// ✅ السطر الجديد (للدراجة الهوائية):
    String url =
        'https://api.openrouteservice.org/v2/directions/cycling-regular?api_key=$openRouteServiceApiKey&start=$startLngLat&end=$endLngLat';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // استخراج نقاط المسار
        List<dynamic> coordinates =
            data['features'][0]['geometry']['coordinates'];
        routePoints = coordinates.map((coord) {
          return LatLng(coord[1], coord[0]); // عكس الإحداثيات
        }).toList();

        // استخراج المسافة والوقت
        final summary = data['features'][0]['properties']['summary'];

        double distInKm = summary['distance'] / 1000.0;
        int timeInMinutes = (summary['duration'] / 60.0).ceil();

        distance = '${distInKm.toStringAsFixed(2)} km';
        duration = '$timeInMinutes min';

        Get.snackbar(
            "نجاح المسار", "المسافة: $distance، الوقت المتوقع: $duration",
            duration: const Duration(seconds: 5));
        update();
      } else {
        distance = 'N/A';
        duration = 'N/A';
        Get.snackbar(
            "خطأ المسار", "فشل جلب المسار. رمز الخطأ: ${response.statusCode}.");
        update();
      }
    } catch (e) {
      distance = 'N/A';
      duration = 'N/A';
      Get.snackbar("خطأ الشبكة", "حدث خطأ أثناء الاتصال: $e");
      update();
    }
  }

  // تهيئة علامة المتجر الثابتة (نقطة البداية)
  void _initializeMarkers() {
    markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: storeLocation,
        child: const Icon(
          Icons.store,
          color: AppColor.primeColor,
          size: 40.0,
        ),
      ),
    );
  }

  // =======================================================
  // ✅ الدالة المفقودة: تحديث مركز الخريطة يدوياً (مطلوبة من الـ View)
  // =======================================================

  void updateMapCenter(LatLng newCenter) {
    mapCenter = newCenter;
    currentZoom = 13.0;
    // تحريك الخريطة عبر المتحكم
    mapWidgetController.move(newCenter, currentZoom);
    update();
  }

  // =======================================================
  // ✅ الدالة المفقودة: جلب الموقع الحالي (مطلوبة من الـ View)
  // =======================================================

  // ... في ملف fluttermap_controller.dart

// دالة جلب الموقع الحالي وتوجيه الخريطة إليه
  Future<void> getCurrentLocation() async {
    // 1. تفعيل حالة التحميل
    isLoading.value = true;
    update();

    try {
      // 2. فحص ما إذا كانت خدمة الموقع مفعّلة
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("خطأ الإذن", "خدمة الموقع غير مفعّلة على جهازك.");
        isLoading.value = false;
        update();
        return;
      }

      // 3. فحص إذن الموقع الممنوح
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // طلب الإذن إذا لم يُمنح بعد
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("خطأ الإذن", "تم رفض إذن الموقع.");
          isLoading.value = false;
          update();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("خطأ الإذن",
            "تم رفض إذن الموقع نهائياً. يرجى تفعيله من الإعدادات.");
        isLoading.value = false;
        update();
        return;
      }

      // 4. جلب الموقع (إذا كانت الخدمات والأذونات سليمة)
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      LatLng newLocation = LatLng(position.latitude, position.longitude);

      // 5. تحديث المركز وتحريك الخريطة
      mapCenter = newLocation;
      currentZoom = 15.0;
      mapWidgetController.move(newLocation, currentZoom);

      // 6. استدعاء دالة النقر لرسم المسار
      handleMapTap(newLocation);

      Get.snackbar("نجاح", "تم تحديد موقعك الحالي ورسم المسار!");
    } catch (e) {
      Get.snackbar("خطأ", "لم نتمكن من جلب الموقع: $e");
      // في حال حدوث خطأ، سنسجل الخطأ في الكونسول لتتبع المشكلة
      debugPrint("Geolocator Error: $e");
    } finally {
      // 7. إيقاف حالة التحميل
      isLoading.value = false;
      update();
    }
  }

  goToAddAddressDetails() {
    // 1. التحقق من أن المستخدم قد اختار موقعاً فعلاً
    if (deliveryLocation == null) {
      Get.snackbar(
          "تنبيه", "الرجاء اختيار موقع التسليم أولاً بالنقر على الخريطة.");
      return; // إيقاف العملية إذا لم يتم اختيار موقع
    }

    // 2. إرسال إحداثيات الموقع المُختار (deliveryLocation)
    Get.toNamed(AppRoutes.addressAdd, arguments: {
      // ✅ نستخدم deliveryLocation.latitude و deliveryLocation.longitude
      "lat": deliveryLocation!.latitude.toString(),
      "long": deliveryLocation!.longitude.toString()
    });
  }
}
