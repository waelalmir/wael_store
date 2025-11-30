import 'dart:async';
import 'package:ecommerce/core/localization/changelocal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteScrollController extends GetxController {
  bool autoScrollEnabled = true;
  String? lang;
  late ScrollController scroll;
  Timer? timer;

  double speed = 0.5; 
  bool userDragging = false;
  bool userUsedArrow = false;

  int itemCount = 0;

  @override
  void onInit() {
    selectLang();
    super.onInit();
  }

  void setup(int count) {
//
  }

  void startAutoScroll() {
//
  }

  void stopAutoScroll() {
    timer?.cancel();
    timer = null;
  }

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

  void scrollLeft() {
//
  }

  void scrollRight() {
//
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
