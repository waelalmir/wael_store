import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButtonLang extends StatelessWidget {
  final String texybutton;
  final void Function()? onPressed;
  const CustomButtonLang({super.key, required this.texybutton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 100),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.primeColor,
      ),
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            texybutton,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.textcolor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
