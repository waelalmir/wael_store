import 'package:flutter/material.dart';

class CustomTextTitleAuth extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomTextTitleAuth({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          textAlign: TextAlign.center,
          //  style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 39),
          child: Text(
            text2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ],
    );
  }
}
