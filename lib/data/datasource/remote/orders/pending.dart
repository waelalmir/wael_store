import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class PendingOrdersData {
  Crud crud;
  PendingOrdersData(this.crud);
  getData(String usersid) async {
    var response =
        await crud.postData(AppLink.pendingOrders, {"usersid": usersid});
    return response.fold((l) => l, (r) => r);
  }

  ratingOrdersData(String ordersid, String rating, String comment) async {
    var response = await crud.postData(
        AppLink.rating, {"id": ordersid, "rating": rating, "comment": comment});
    return response.fold((l) => l, (r) => r);
  }
}
