import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPrefrences;

  // 🔹 مشروع Firebase الأساسي (المستخدم)
  late FirebaseApp mainFirebaseApp;

  // 🔹 مشروع Firebase للدليفري
  FirebaseApp? deliveryFirebaseApp;
  FirebaseFirestore? deliveryFirestore;

  Future<MyServices> init() async {
    // ✅ تهيئة Firebase الأساسي للمستخدم
    mainFirebaseApp = await Firebase.initializeApp();

    // ✅ تهيئة Firebase الثاني (مشروع الدليفري)
    await _initSecondaryFirebase();

    // ✅ تهيئة SharedPreferences
    sharedPrefrences = await SharedPreferences.getInstance();

    return this;
  }

  // 🔸 الدالة الخاصة بتهيئة مشروع الدليفري
  Future<void> _initSecondaryFirebase() async {
    try {
      deliveryFirebaseApp = await Firebase.initializeApp(
        name: 'deliveryApp',
        options: const FirebaseOptions(
          apiKey:
              "AIzaSyAdSvPEgHNHQY1xXueveoAh8bWbWZqop5Q", // 🔑 من Firebase مشروع الدليفري
          appId: "1:730413232073:android:1983d4a32f078d9c5e4218",
          messagingSenderId: "730413232073",
          projectId: "delivery-35930", // 🔹 من Firebase مشروع الدليفري
        ),
      );

      // استخدم Firestore مخصص لهذا المشروع
      deliveryFirestore =
          FirebaseFirestore.instanceFor(app: deliveryFirebaseApp!);

      print("✅ Secondary Firebase initialized successfully.");
    } catch (e) {
      print("⚠️ Failed to initialize secondary Firebase: $e");
    }
  }
}

// 🔸 دالة التهيئة العامة
Future<void> initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
