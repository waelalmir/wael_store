class OrdersModel {
  String? ordersId;
  String? ordersUsersid;
  String? ordersPaymentmethod;
  String? ordersAddress;
  String? ordersPricedelivery;
  String? ordersPrice;
  String? ordersCoupon;
  String? ordersDatetime;
  String? ordersTotalprice;
  String? ordersStatus;
  String? addressId;
  String? addressUsersid;
  String? addressCity;
  String? addressStreet;
  double? addressLat;
  double? addressLong;
  String? addressName;
  String? ordersNoterating;
  String? ordersRating;

  OrdersModel(
      {this.ordersId,
      this.ordersUsersid,
      this.ordersPaymentmethod,
      this.ordersAddress,
      this.ordersPricedelivery,
      this.ordersPrice,
      this.ordersCoupon,
      this.ordersDatetime,
      this.ordersTotalprice,
      this.ordersStatus,
      this.addressId,
      this.addressUsersid,
      this.addressCity,
      this.addressStreet,
      this.addressLat,
      this.addressLong,
      this.addressName,
      this.ordersRating,
      this.ordersNoterating});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'].toString();
    ordersUsersid = json['orders_usersid'].toString();
    ordersPaymentmethod = json['orders_paymentmethod'].toString();
    ordersAddress = json['orders_address'].toString();
    ordersPricedelivery = json['orders_pricedelivery'].toString();
    ordersPrice = json['orders_price'].toString();
    ordersCoupon = json['orders_coupon'].toString();
    ordersDatetime = json['orders_datetime'].toString();
    ordersTotalprice = json['orders_totalprice'].toString();
    ordersStatus = json['orders_status'].toString();
    addressId = json['address_id'].toString();
    addressUsersid = json['address_usersid'].toString();
    addressCity = json['address_city'].toString();
    addressStreet = json['address_street'].toString();
    addressLat = json['address_lat'];
    addressLong = json['address_long'];
    addressName = json['address_name'].toString();
    ordersNoterating = json['orders_noterating'].toString();
    ordersRating = json['orders_rating'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_id'] = this.ordersId;
    data['orders_usersid'] = this.ordersUsersid;
    data['orders_paymentmethod'] = this.ordersPaymentmethod;
    data['orders_address'] = this.ordersAddress;
    data['orders_pricedelivery'] = this.ordersPricedelivery;
    data['orders_price'] = this.ordersPrice;
    data['orders_coupon'] = this.ordersCoupon;
    data['orders_datetime'] = this.ordersDatetime;
    data['orders_totalprice'] = this.ordersTotalprice;
    data['orders_status'] = this.ordersStatus;
    data['address_id'] = this.addressId;
    data['address_usersid'] = this.addressUsersid;
    data['address_city'] = this.addressCity;
    data['address_street'] = this.addressStreet;
    data['address_lat'] = this.addressLat;
    data['address_long'] = this.addressLong;
    data['address_name'] = this.addressName;
    data['orders_noterating'] = this.ordersNoterating;
    data['orders_rating'] = this.ordersRating;
    return data;
  }
}
