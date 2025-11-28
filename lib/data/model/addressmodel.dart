class AddressModel {
  int? addressId;
  int? addressUsersid;
  String? addressCity;
  String? addressStreet;

  // ✅ التعديل: تغيير النوع إلى double?
  double? addressLat;
  double? addressLong;

  String? addressName;

  AddressModel(
      {this.addressId,
      this.addressUsersid,
      this.addressCity,
      this.addressStreet,
      this.addressLat,
      this.addressLong,
      this.addressName});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressUsersid = json['address_usersid'];
    addressCity = json['address_city'];
    addressStreet = json['address_street'];

    // ✅ يجب أن تكون الدالة قادرة على قراءة الـ double
    // بما أننا غيرنا النوع في التعريف، ستعمل قراءة الـ JSON تلقائيًا إذا كانت القيمة double
    addressLat = double.tryParse(json['address_lat']?.toString() ?? '0');
    addressLong = double.tryParse(json['address_long']?.toString() ?? '0');

    addressName = json['address_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_usersid'] = this.addressUsersid;
    data['address_city'] = this.addressCity;
    data['address_street'] = this.addressStreet;
    data['address_lat'] = this.addressLat;
    data['address_long'] = this.addressLong;
    data['address_name'] = this.addressName;
    return data;
  }
}
