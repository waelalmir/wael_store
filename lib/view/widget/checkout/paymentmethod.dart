import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class Paymentmethod extends StatelessWidget {
  final String title;
  final String imagesrc;
  final bool isactive;

  const Paymentmethod(
      {super.key,
      required this.title,
      required this.imagesrc,
      required this.isactive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isactive == true ? AppColor.primeColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.grey)),
      child: Row(
        children: [
          Image.asset(
            imagesrc,
            height: 30,
            width: 30,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
                color: isactive == true ? Colors.white : AppColor.primeColor,
                fontFamily: "sans"),
          )
        ],
      ),
    );
  }
}
