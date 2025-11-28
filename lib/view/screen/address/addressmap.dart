import 'package:ecommerce/controller/orders/fluttermap_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
    final FluttermapController mapController = Get.put(FluttermapController());

    return Scaffold(
      appBar: AppBar(title: const Text('خريطة Flutter_Map (تحديد مسار)')),

      body: GetBuilder<FluttermapController>(
        builder: (controller) {
          return Stack(
            // استخدام Stack لوضع صندوق المعلومات فوق الخريطة
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
                  // طبقة الشرائح (Tiles) - تم التغيير إلى 'osm_bright' للتفاصيل
                  TileLayer(
                    urlTemplate:
                        'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png?api_key=${controller.stadiaApiKey}',
                    userAgentPackageName: 'com.example.app',
                    maxZoom: 18,
                  ),

                  // طبقة رسم المسارات (التصحيح لتجنب الخطأ LatLngBounds)
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

      // ✅ 3. الأزرار العائمة (تم إرجاعها إلى Scaffold)
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // زر تحديث المركز (للتجربة)
          FloatingActionButton(
            heroTag: "refreshCenter",
            onPressed: () {
              mapController.updateMapCenter(const LatLng(21.5433, 39.1728));
              Get.snackbar("تحديث", "تم تغيير مركز الخريطة إلى جدة");
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),

          // زر تحديد الموقع الحالي (عاد للظهور)
          FloatingActionButton(
            heroTag: "currentLocation",
            onPressed:
                mapController.getCurrentLocation, // استدعاء دالة جلب الموقع
            backgroundColor: Colors.blue,
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
