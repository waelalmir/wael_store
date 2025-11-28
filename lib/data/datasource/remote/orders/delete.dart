import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/linkapi.dart';

class DeleteOrdersData {
  Crud crud;
  DeleteOrdersData(this.crud);
  deleteData(String ordersid) async {
    var response = await crud.postData(AppLink.deleteOrders, {"id": ordersid});
    return response.fold((l) => l, (r) => r);
  }
}
