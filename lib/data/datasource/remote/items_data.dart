import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud);
  getData(String catId, String userid) async {
    var response = await crud
        .postData(AppLink.items, {"id": catId.toString(), "usersid": userid});
    return response.fold((l) => l, (r) => r);
  }

  getTopSelling() async {
    var response = await crud.postData(AppLink.itemsTopSelling, {});
    return response.fold((l) => l, (r) => r);
  }
}
