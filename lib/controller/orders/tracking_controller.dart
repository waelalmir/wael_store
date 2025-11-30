import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class TrackingController extends GetxController {
  StreamSubscription<Position>? positionStream;
  LatLng currentDeliveryLocation = const LatLng(0, 0);
  Future<void> _handlePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
    }
  }

  getCurrentLocation() async {
    // logic
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
