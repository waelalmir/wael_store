import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class Addressdelivery extends StatelessWidget {
  final String title;

  final bool isactive;
  const Addressdelivery(
      {super.key, required this.title, required this.isactive});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isactive ? AppColor.primeColor : null,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: isactive ? AppColor.textcolor : AppColor.grey,
              fontFamily: "sans"),
        ),
      ),
    );
  }
}
