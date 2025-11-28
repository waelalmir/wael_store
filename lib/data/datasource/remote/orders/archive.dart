import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class ArchiveOrdersData {
  Crud crud;
  ArchiveOrdersData(this.crud);
  getData(String usersid) async {
    var response =
        await crud.postData(AppLink.archiveOrders, {"usersid": usersid});
    return response.fold((l) => l, (r) => r);
  }

  ratingOrdersData(String ordersid, String rating, String comment) async {
    var response = await crud.postData(
        AppLink.rating, {"id": ordersid, "rating": rating, "comment": comment});
    return response.fold((l) => l, (r) => r);
  }
}
