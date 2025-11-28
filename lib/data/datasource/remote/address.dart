import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class AddressData {
  Crud crud;
  AddressData(this.crud);
  addAdress(String city, String name, String street, String lat, String long,
      String usersid) async {
    var response = await crud.postData(AppLink.adressadd, {
      "usersid": usersid,
      "city": city,
      "street": street,
      "name": name,
      "lat": lat,
      "long": long
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteAdress(String adressid) async {
    var response =
        await crud.postData(AppLink.adressdelete, {"address id": adressid});
    return response.fold((l) => l, (r) => r);
  }

  viewAddress(String usersid) async {
    var response =
        await crud.postData(AppLink.adressview, {"usersid": usersid});
    return response.fold((l) => l, (r) => r);
  }
}
