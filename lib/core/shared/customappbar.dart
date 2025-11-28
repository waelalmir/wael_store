import 'package:flutter/material.dart';
import 'package:ecommerce/core/constant/color.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Customappbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.secondColor,
      centerTitle: true,
      title: Text(title,
          style: const TextStyle(
              color: AppColor.textcolor, fontWeight: FontWeight.w600)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
