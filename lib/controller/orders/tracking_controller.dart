import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TrackingController extends GetxController {
  StreamSubscription<Position>? positionStream;
  LatLng currentDeliveryLocation = const LatLng(0, 0);
  // 🆕 2. دالة لطلب الأذونات قبل بدء التتبع
  Future<void> _handlePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // يمكنك عرض رسالة خطأ أو طلب فتح إعدادات الموقع
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // يمكنك عرض رسالة خطأ بأن الأذونات مرفوضة
        return;
      }
    }
  }

  getCurrentLocation() async {
    await _handlePermission();

    positionStream = Geolocator.getPositionStream().listen(
      (Position? position) {
        if (position != null) {
          // 🆕 تحديث الموقع الحي للدليفري
          currentDeliveryLocation =
              LatLng(position.latitude, position.longitude);
          print(
              "Delivery Location Updated: ${currentDeliveryLocation.latitude} , ${currentDeliveryLocation.longitude}");
          update(); // 🆕 إرسال إشعار تحديث لكل GetBuilder يستمع إلى هذا المتحكم
        }
      },
    );
  }

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    positionStream!.cancel();
    super.onClose();
  }
}
