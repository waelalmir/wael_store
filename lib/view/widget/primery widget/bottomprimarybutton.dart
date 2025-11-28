import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBottomNavigationButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomBottomNavigationButton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.primeColor, borderRadius: BorderRadius.circular(8)),
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10), // إضافة هامش علوي بسيط للفصل
        child: Center(
          child: InkWell(
              onTap: onPressed,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              )),
        ),
      ),
    );
  }
}
