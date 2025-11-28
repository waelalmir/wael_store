import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Color? fillColor;
  final IconData? preicon;
  final Color? iconColor;
  // final Function()? favpress;
  final void Function(String)? onChanged;
  final TextEditingController? mycontroller;
  final void Function()? onPressedsearch;
  final Function(String)? onFieldSubmitted;
  final void Function()? notificationpress;
  const SearchField({
    super.key,
    this.fillColor,
    this.preicon,
    this.iconColor,
    // required this.favpress,
    this.mycontroller,
    this.onChanged,
    this.onPressedsearch,
    this.notificationpress,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            controller: mycontroller,
            onChanged: onChanged,
            style: TextStyle(
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              prefixIcon: IconButton(
                icon: Icon(preicon),
                onPressed: onPressedsearch,
                color: iconColor,
              ),
            ),
          )),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 56,
            decoration: BoxDecoration(
                color: fillColor, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: notificationpress,
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
