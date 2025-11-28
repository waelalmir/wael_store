import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/localization/changelocal.dart';
import 'package:ecommerce/view/widget/language/custombuttonlang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Langauge extends StatefulWidget {
  const Langauge({super.key});

  @override
  State<Langauge> createState() => _LangaugeState();
}

class _LangaugeState extends State<Langauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    _slide = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.find();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Text(
                      "1".tr,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              // زر اللغة العربية
              FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: CustomButtonLang(
                    texybutton: "ar",
                    onPressed: () {
                      controller.changeLang("ar");
                      Get.toNamed(AppRoutes.onBoarding);
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              // زر اللغة الإنكليزية
              FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: CustomButtonLang(
                    texybutton: "en",
                    onPressed: () {
                      controller.changeLang("en");
                      Get.toNamed(AppRoutes.onBoarding);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
