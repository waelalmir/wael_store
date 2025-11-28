import 'dart:async';
import 'package:ecommerce/core/localization/changelocal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteScrollController extends GetxController {
  bool autoScrollEnabled = true;
  String? lang;
  late ScrollController scroll;
  Timer? timer;

  double speed = 0.5; // 🟢 سرعة أبطأ كما طلبت
  bool userDragging = false;
  bool userUsedArrow = false;

  int itemCount = 0;

  @override
  void onInit() {
    selectLang();
    super.onInit();
  }

  void setup(int count) {
    itemCount = count;
    scroll = ScrollController(initialScrollOffset: 5000);
    startAutoScroll();

    scroll.addListener(() {
      if (!scroll.hasClients) return;

      // إعادة التمركز
      if (scroll.offset > scroll.position.maxScrollExtent - 200) {
        scroll.jumpTo(3000);
      }
    });
  }

  /// Auto Scroll
  void startAutoScroll() {
    if (!autoScrollEnabled) return; // 🆕 إيقاف كامل إذا غير مفعل

    timer ??= Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (!scroll.hasClients) return;

      if (userDragging || userUsedArrow) return;

      // تغيير الاتجاه حسب اللغة
      double direction = lang == "ar" ? -1 : 1; // 🆕 العربي يمين→يسار

      scroll.jumpTo(scroll.offset + speed * direction);
    });
  }

  void stopAutoScroll() {
    timer?.cancel();
    timer = null;
  }

  /// عند سحب المستخدم
  void onUserDragStart() {
    userDragging = true;
    stopAutoScroll();
  }

  void onUserDragEnd() {
    userDragging = false;

    Future.delayed(const Duration(seconds: 3), () {
      if (!userDragging && !userUsedArrow) {
        startAutoScroll();
      }
    });
  }

  /// الأسهم
  void scrollLeft() {
    userUsedArrow = true;
    stopAutoScroll();

    double direction = lang == "ar" ? 1 : -1; // 🆕 عكس الاتجاه بالعربي

    scroll.animateTo(
      scroll.offset + (200 * direction),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    Future.delayed(Duration(seconds: 2), () {
      userUsedArrow = false;
      if (!userDragging && autoScrollEnabled) startAutoScroll();
    });
  }

  void scrollRight() {
    userUsedArrow = true;
    stopAutoScroll();

    double direction = lang == "ar" ? -1 : 1; // 🆕 عكس الاتجاه بالعربي

    scroll.animateTo(
      scroll.offset + (200 * direction),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    Future.delayed(Duration(seconds: 2), () {
      userUsedArrow = false;
      if (!userDragging && autoScrollEnabled) startAutoScroll();
    });
  }

  void setAutoScroll(bool enabled) {
    autoScrollEnabled = enabled;
    if (enabled) {
      startAutoScroll();
    } else {
      stopAutoScroll();
    }
  }

  selectLang() {
    lang = Get.find<LocaleController>().language!.languageCode;
  }

  @override
  void onClose() {
    scroll.dispose();
    stopAutoScroll();
    super.onClose();
  }
}
