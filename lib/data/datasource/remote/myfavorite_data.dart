import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class MyfavoriteData {
  Crud crud;
  MyfavoriteData(this.crud);
  getData(String id) async {
    var response = await crud.postData(AppLink.viewMyFavorite, {"id": id});
    return response.fold((l) => l, (r) => r);
  }

  removeData(String id) async {
    var response =
        await crud.postData(AppLink.removeFromMyFavorite, {"id": id});
    return response.fold((l) => l, (r) => r);
  }
}
