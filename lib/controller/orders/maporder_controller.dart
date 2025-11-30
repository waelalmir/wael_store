import 'dart:convert';
import 'dart:async';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/model/ordersmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class OrderMapUserController extends GetxController {
  MyServices myServices = Get.find();
  OrdersModel? ordersModel;
  Timer? timer;

  var actualRoutePoints = <LatLng>[].obs;

  late String addressName;
  late LatLng customerPoint; 
  LatLng? deliveryPoint; 

  FirebaseApp? deliveryApp; 
  FirebaseFirestore? deliveryFirestore;

  List<LatLng> get routePoints {
    if (deliveryPoint == null) return [customerPoint];
    return [deliveryPoint!, customerPoint];
  }

  Future<void> initDeliveryFirebase() async {
    try {
      if (Firebase.apps.any((app) => app.name == 'deliveryApp')) {
        print("deliveryApp already initialized, using existing instance.");
        deliveryApp = Firebase.app('deliveryApp');
      } else {
        deliveryApp = await Firebase.initializeApp(
          name: 'deliveryApp',
          options: const FirebaseOptions(
            apiKey: "apiKey",
            appId: "appId",
            messagingSenderId: "messagingSenderId",
            projectId: "projectId",
            storageBucket: "storageBucket",
          ),
        );
        print("deliveryApp initialized successfully.");
      }

      deliveryFirestore = FirebaseFirestore.instanceFor(app: deliveryApp!);
    } catch (e) {
      print("Error initializing delivery Firebase: $e");
    }
  }

  void startTrackingDelivery() {
    if (ordersModel == null) {
      print("OrderMapUserController: ordersModel is null");
      return;
    }

    deliveryFirestore!
        .collection('delivery')
        .doc(ordersModel!.ordersId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        double? lat = snapshot.data()?['lat'];
        double? long = snapshot.data()?['long'];

        if (lat != null && long != null) {
          deliveryPoint = LatLng(lat, long);
          fetchRoute(); 
          update();
        }
      }
    });
  }

  Future<void> fetchRoute() async {
    if (deliveryPoint == null) return;

    final start = deliveryPoint!;
    final end = customerPoint;

    final url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final coordinates =
            data['routes'][0]['geometry']['coordinates'] as List;
        final route =
            coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
        actualRoutePoints.value = route;
      } else {
        print("❌ Failed to fetch route: ${response.statusCode}");
        actualRoutePoints.value = [start, end];
      }
    } catch (e) {
      print("⚠️ Error fetching route: $e");
      actualRoutePoints.value = [start, end];
    }

    update();
  }

  void _initializeData() {
    if (Get.arguments != null &&
        Get.arguments['lat'] is double &&
        Get.arguments['long'] is double) {
      double lat = Get.arguments['lat'];
      double long = Get.arguments['long'];
      addressName = Get.arguments['name'] ?? 'My Location';
      customerPoint = LatLng(lat, long);
      ordersModel = Get.arguments['ordersModel'] as OrdersModel;
    } else {
      addressName = 'Error: No Location Data';
      customerPoint = const LatLng(0, 0);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    _initializeData();
    await initDeliveryFirebase(); 
    startTrackingDelivery(); 
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
