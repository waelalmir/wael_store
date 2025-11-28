import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class DetailsOrdersData {
  Crud crud;
  DetailsOrdersData(this.crud);
  getData(String ordersid) async {
    var response =
        await crud.postData(AppLink.detailsOrders, {"ordersid": ordersid});
    return response.fold((l) => l, (r) => r);
  }
}
