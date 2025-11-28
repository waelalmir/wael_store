import 'package:ecommerce/controller/orders/maporder_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

// ✅ يجب تغيير اسم الكلاس إلى (View)
class OrderMapView extends StatelessWidget {
  const OrderMapView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderMapUserController());
    // 1. استخدام GetBuilder لاستدعاء وتهيئة المتحكم
    return GetBuilder<OrderMapUserController>(
      builder: (controller) {
        // 2. استخدام البيانات المهيأة
        //  final deliveryPoint = controller.deliveryPoint;
        // ✅ استخدام نقطة العميل الثابتة
        final customerPoint = controller.customerPoint;

        return Scaffold(
          appBar: AppBar(
            // استخدام اسم العنوان من المتحكم
            title: Text(controller.addressName),
            backgroundColor: Colors.teal,
          ),

          // 3. الخريطة التفاعلية بكامل الشاشة
          body: FlutterMap(
            options: MapOptions(
              initialCenter: customerPoint,
              initialZoom: 16.0, // الآن يمكن للمستخدم التفاعل (التكبير/التصغير)
              // لا نضع InteractiveFlag.none هنا للسماح بالتفاعل
            ),
            children: [
              // طبقة الشرائح (Tiles)
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.delivery',
              ),
              // 🆕 طبقة الخطوط المتعددة (PolylineLayer) لرسم المسار
              if (controller.deliveryPoint != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: controller.actualRoutePoints.isEmpty
                          ? [
                              controller.deliveryPoint!,
                              controller.customerPoint
                            ]
                          : controller.actualRoutePoints,
                      strokeWidth: 5.0,
                      color: AppColor.primeColor,
                    ),
                  ],
                ),
              // طبقة علامة الموقع (Marker)
              MarkerLayer(
                markers: [
                  // 🔹 Marker المستخدم (الموقع الثابت)
                  Marker(
                    point: controller.customerPoint,
                    width: 80,
                    height: 80,
                    child: const Column(
                      children: [
                        Icon(Icons.home, color: Colors.green, size: 45),
                        Text("You"),
                      ],
                    ),
                  ),

                  // 🔹 Marker عامل التوصيل (فقط إذا تم جلبه)
                  if (controller.deliveryPoint != null)
                    Marker(
                      point: controller.deliveryPoint!,
                      width: 80,
                      height: 80,
                      child: const Column(
                        children: [
                          Icon(Icons.two_wheeler, color: Colors.blue, size: 45),
                          Text("Delivery"),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
