import 'package:ecommerce/view/screen/auth/login.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // SuccessResetPasswordImp controller = Get.put(SuccessResetPasswordImp());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Text(
                "gooood",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Center(
              child: Icon(
                Icons.check_circle_outline_sharp,
                size: 200,
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: CustomButtonAuth(
                  text: "login",
                  onPressed: () {
                    Get.offAll(() => Login());
                  }),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
