import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomButtonBottomAppbar extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? iconbottombutton;
  final String text;
  final bool? active;
  const CustomButtonBottomAppbar(
      {super.key,
      this.onPressed,
      this.iconbottombutton,
      required this.text,
      this.active});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColor.primeColor,
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Icon(
              iconbottombutton,
              color: active == true ? Colors.white : AppColor.grey,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  color: active == true ? Colors.white : AppColor.thirdColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
