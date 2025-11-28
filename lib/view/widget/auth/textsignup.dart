import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextSignUpOrIn extends StatelessWidget {
  final String text;
  final String texttwo;
  final Function() onTap;

  const CustomTextSignUpOrIn(
      {super.key,
      required this.text,
      required this.texttwo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        SizedBox(width: 7),
        InkWell(
            onTap: onTap,
            child: Text(texttwo,
                style: const TextStyle(
                    color: AppColor.primeColor, fontWeight: FontWeight.bold)))
      ],
    );
  }
}
