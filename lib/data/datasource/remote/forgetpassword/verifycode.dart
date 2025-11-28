import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class VerifyCodeData {
  Crud crud;
  VerifyCodeData(this.crud);
  postData(String email, String verifycode) async {
    var response = await crud.postData(AppLink.verifycode, {
      "email": email,
      "verifycode": verifycode,
    });
    return response.fold((l) => l, (r) => r);
  }
}
