// في ملف FlutterMapPage.dart

import 'package:ecommerce/controller/orders/fluttermap_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// بما أننا نستخدم AppColor، سنضيفه هنا
// import 'package:ecommerce/core/constant/color.dart'; 

// ملاحظة: لكي يعمل هذا الكود، يجب أن يكون لديك ملف 'color.dart' يحتوي على AppColor.primeColor و AppColor.textcolor.


class FlutterMapPage extends StatelessWidget {
  const FlutterMapPage({super.key});

  // دالة مساعدة لإنشاء ويدجت المعلومات
  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ وضع الكنترولر في مكان واضح
    final FluttermapController mapController = Get.put(FluttermapController());

    return Scaffold(
      
      // 1. ✅ شريط التذييل (Bottom Navigation Bar) لزر المتابعة
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColor.primeColor),
            minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
          ),
          onPressed: () {
            // ✅ استدعاء الدالة للانتقال وإرسال الإحداثيات
            mapController.goToAddAddressDetails();
          },
          child: const Text(
            "Continue",
            style: TextStyle(color: AppColor.textcolor, fontSize: 18),
          ),
        ),
      ),
      
      appBar: AppBar(title: const Text('خريطة تحديد الموقع والمسار')),

      body: GetBuilder<FluttermapController>(
        builder: (controller) {
          return Stack(
            children: [
              // 1. الخريطة نفسها
              FlutterMap(
                mapController: controller.mapWidgetController,
                options: MapOptions(
                  initialCenter: controller.mapCenter,
                  initialZoom: controller.currentZoom,
                  onTap: (tapPosition, latlng) {
                    controller.handleMapTap(latlng);
                  },
                ),
                children: [
                  // طبقة الشرائح (Tiles) - Stadia Maps
                  TileLayer(
                    urlTemplate:
                        'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png?api_key=${controller.stadiaApiKey}',
                    userAgentPackageName: 'com.example.app',
                    maxZoom: 18,
                  ),

                  // طبقة رسم المسارات 
                  PolylineLayer<Object>(
                    polylines: controller.routePoints.isNotEmpty
                        ? [
                            Polyline<Object>(
                              points: controller.routePoints,
                              strokeWidth: 5.0,
                              color: Colors.deepOrange,
                            ),
                          ]
                        : const [],
                  ),

                  // طبقة علامات المتجر ونقطة التسليم
                  MarkerLayer(
                    markers: [
                      ...controller.markers,
                      ...controller.tappedMarker
                    ],
                  ),
                ],
              ),

              // 2. ويدجت عرض المسافة والوقت (في أعلى الخريطة)
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoItem(
                          'المسافة', controller.distance, Icons.alt_route),
                      _buildInfoItem('الوقت', controller.duration, Icons.timer),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // 3. ✅ الأزرار العائمة (تحتاج Obx لتظهر حالة التحميل)
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // زر تحديث المركز (للتجربة)
          FloatingActionButton(
            heroTag: "refreshCenter",
            mini: true, // تصغير حجم الزر
            onPressed: () {
              mapController.updateMapCenter(const LatLng(21.5433, 39.1728));
              Get.snackbar("تحديث", "تم تغيير مركز الخريطة إلى جدة", duration: const Duration(seconds: 2));
            },
            child: const Icon(Icons.refresh, size: 20),
          ),
          const SizedBox(height: 10),

          // زر تحديد الموقع الحالي (يجب أن يعرض حالة التحميل)
          Obx( // ✅ استخدام Obx لتحديث حالة زر GPS
            () => FloatingActionButton(
              heroTag: "currentLocation",
              onPressed: mapController.isLoading.value 
                  ? null // تعطيل الزر أثناء التحميل
                  : mapController.getCurrentLocation, 
              backgroundColor: mapController.isLoading.value 
                  ? Colors.grey 
                  : Colors.blue,
              child: mapController.isLoading.value
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ),
                    )
                  : const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}