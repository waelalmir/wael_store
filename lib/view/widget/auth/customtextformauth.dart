import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData? suffixIcon;
  final TextEditingController? myController;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? ontapIcon;

  const CustomTextFormAuth({
    super.key,
    required this.hintText,
    required this.labelText,
    this.suffixIcon,
    required this.myController,
    required this.valid,
    required this.isNumber,
    this.obscureText,
    this.ontapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 15),
      child: TextFormField(
        cursorErrorColor: AppColor.secondColor,
        obscureText: obscureText ?? false,
        keyboardType: isNumber
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: myController,
        cursorColor: AppColor.primeColor,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.secondColor.withValues(alpha: .07),

          labelText: labelText,
          labelStyle: TextStyle(color: AppColor.primeColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hintText,

          hintStyle: TextStyle(
            color: AppColor.thirdColor.withOpacity(.7),
            fontSize: 14,
          ),

          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: ontapIcon,
                  child: Icon(
                    suffixIcon,
                    color: AppColor.thirdColor,
                    size: 22,
                  ),
                )
              : null,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 18,
          ),

          // 🔥 شكل الـ border (مودرن)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColor.thirdColor.withOpacity(.4),
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColor.primeColor,
              width: 1.8,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1.4,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.red.shade600,
              width: 1.6,
            ),
          ),
        ),
      ),
    );
  }
}
