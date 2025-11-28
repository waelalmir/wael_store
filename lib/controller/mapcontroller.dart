import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart'; // للبحث عن الأماكن
import 'package:geolocator/geolocator.dart'; // لتحديد موقع المستخدم
import 'dart:async'; // نحتاجها للتعامل مع الـ Future

/// وحدة التحكم في حالة الخريطة باستخدام GetX.
class MapPickerController extends GetxController {
  static const LatLng defaultLocation =
      LatLng(33.51333696277142, 36.276201243761776); // damascus

  // المتغيرات التفاعلية الأساسية
  final Rx<LatLng?> selectedLatLong = Rx<LatLng?>(null);
  final RxList<Marker> markers = <Marker>[].obs;

  // وحدة التحكم الخاصة بـ flutter_map للتحكم في عرض الخريطة
  final MapController mapController = MapController();

  // متغير حالة لمعرفة إذا كنا نقوم بتحميل البيانات (مثلاً أثناء البحث أو تحديد الموقع)
  final RxBool isLoading = false.obs;

  // ------------------------------------
  // Methods for Map Tapping
  // ------------------------------------

  /// الدالة التي يتم استدعاؤها عند النقر على أي مكان في الخريطة.
  void handleMapTap(LatLng newLatLong) {
    _updateMapAndMarker(newLatLong);
    debugPrint(
        'New point selected: Lat=${newLatLong.latitude}, Lng=${newLatLong.longitude}');
  }

  // ------------------------------------
  // Methods for Geocoding (البحث عن الأماكن)
  // ------------------------------------

  /// البحث عن مكان معين والانتقال إليه على الخريطة.
  Future<void> searchAndMoveToPlace(String query) async {
    if (query.trim().isEmpty) return;

    isLoading.value = true;
    try {
      // 1. تحويل الاسم (العنوان) إلى إحداثيات (Placemark)
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final LatLng target = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );

        // 2. تحديث الخريطة والعلامة
        _updateMapAndMarker(target);

        // 3. تحريك الخريطة إلى الموقع الجديد
        mapController.move(target, 14.0); // مستوى تكبير 14 مناسب للعناوين

        Get.snackbar('تم العثور على الموقع', 'تم الانتقال إلى: ${query}',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('خطأ في البحث', 'لم يتم العثور على نتائج لـ: $query',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء البحث: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------------------------
  // Methods for Geolocation (تحديد الموقع التلقائي)
  // ------------------------------------

  /// طلب إذن الموقع وتحديد الموقع الحالي للمستخدم.
  Future<void> determineUserPosition() async {
    isLoading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    // 1. فحص تفعيل خدمة الموقع (GPS)
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('تحذير', 'خدمة الموقع (GPS) معطلة. يرجى تفعيلها.',
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
      return;
    }

    // 2. طلب الإذن
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('تحذير', 'تم رفض إذن الموقع.',
            snackPosition: SnackPosition.BOTTOM);
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          'خطأ', 'تم رفض إذن الموقع بشكل دائم. يرجى تفعيله من الإعدادات.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
      isLoading.value = false;
      return;
    }

    // 3. الحصول على الموقع الحالي
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final LatLng userLocation = LatLng(position.latitude, position.longitude);

      // 4. تحديث الخريطة والعلامة
      _updateMapAndMarker(userLocation);
      mapController.move(userLocation, 16.0); // مستوى تكبير أعلى

      Get.snackbar('نجاح', 'تم تحديد موقعك الحالي.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('خطأ', 'تعذر الحصول على الموقع: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------------------------
  // Helper Method (وحدة مساعدة داخلية)
  // ------------------------------------
  void _updateMapAndMarker(LatLng newLatLong) {
    selectedLatLong.value = newLatLong;

    final newMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: newLatLong,
      child: const Icon(
        Icons.location_pin,
        color: Colors.red,
        size: 40.0,
      ),
    );

    markers.clear();
    markers.add(newMarker);
  }
}
