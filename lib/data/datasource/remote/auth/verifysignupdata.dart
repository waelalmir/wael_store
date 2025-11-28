import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/linkapi.dart';

// data source
class VerfiyCodeSignUpData {
  Crud crud;
  VerfiyCodeSignUpData(this.crud);

  Future<Either<StatusRequest, Map>> postdata(
      String email, String verifycode) async {
    return await crud.postData(
      AppLink.verifysignup,
      {"email": email, "verifycode": verifycode},
    );
  }

  resendData(String email) async {
    var response = await crud.postData(AppLink.resend, {"email": email});
    return response.fold((l) => l, (r) => r);
  }
}
