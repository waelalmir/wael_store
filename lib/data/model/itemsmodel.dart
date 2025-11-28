class ItemsModel {
  // خصائص المنتج الأساسية
  String? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemsImage;
  String? itemsCount;
  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;
  String? itemsDate;
  String? itemsCat;

  // خصائص الفئة (Category)
  String? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImage;
  String? categoriesDatetime;

  // خصائص إضافية (الخصم والمفضلة)
  String? itemsdiscprice; // ⬅️ السعر بعد الخصم (القيمة المحسوبة)
  String? favorite;

  // 1. المُنشئ (Constructor)
  ItemsModel(
      {this.itemsId,
      this.itemsName,
      this.itemsNameAr,
      this.itemsDesc,
      this.itemsDescAr,
      this.itemsImage,
      this.itemsCount,
      this.itemsActive,
      this.itemsPrice,
      this.itemsDiscount,
      this.itemsDate,
      this.itemsCat,
      this.categoriesId,
      this.categoriesName,
      this.categoriesNameAr,
      this.categoriesImage,
      this.categoriesDatetime,
      this.itemsdiscprice,
      this.favorite});

  // 2. مُنشئ .fromJson لتحويل الـ JSON إلى كائن (Object)
  // هذا هو المُنشئ الذي تم إصلاحه ومعالجته ليتوافق مع بيانات الـ Backend
  ItemsModel.fromJson(Map<String, dynamic> json) {
    // 📝 ملاحظة هامة: نستخدم .toString() لضمان تحويل جميع القيم (التي قد تكون String, int, أو double)
    // إلى نص (String) لتجنب أخطاء النوع (TypeError) عند التعيين في الخصائص المُعرّفة كـ String?.

    itemsId = json['items_id']?.toString();
    itemsName = json['items_name']?.toString();
    itemsNameAr = json['items_name_ar']?.toString();
    itemsDesc = json['items_desc']?.toString();
    itemsDescAr = json['items_desc_ar']?.toString();
    itemsImage = json['items_image']?.toString();
    itemsCount = json['items_count']?.toString();
    itemsActive = json['items_active']?.toString();
    itemsPrice = json['items_price']?.toString();
    itemsDiscount = json['items_discount']?.toString();
    itemsDate = json['items_date']?.toString();
    itemsCat = json['items_cat']?.toString();

    categoriesId = json['categories_id']?.toString();
    categoriesName = json['categories_name']?.toString();
    categoriesNameAr =
        json['categories_name_ar']?.toString(); // تم تصحيح الاسم هنا
    categoriesImage = json['categories_image']?.toString();
    categoriesDatetime = json['categories_datetime']?.toString();

    // الحقل الذي يحتوي على السعر بعد الخصم
    itemsdiscprice = json['itemsdiscprice']?.toString();

    favorite = json['favorite']?.toString();
  }

  // 3. دالة toJson لتحويل الكائن إلى خريطة (Map) جاهزة للإرسال إلى الـ Backend (إن لزم الأمر)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items_id'] = itemsId;
    data['items_name'] = itemsName;
    data['items_name_ar'] = itemsNameAr;
    data['items_desc'] = itemsDesc;
    data['items_desc_ar'] = itemsDescAr;
    data['items_image'] = itemsImage;
    data['items_count'] = itemsCount;
    data['items_active'] = itemsActive;
    data['items_price'] = itemsPrice;
    data['items_discount'] = itemsDiscount;
    data['items_date'] = itemsDate;
    data['items_cat'] = itemsCat;
    data['categories_id'] = categoriesId;
    data['categories_name'] = categoriesName;
    data['categories_name_ar'] = categoriesNameAr; // تم تصحيح الاسم هنا
    data['categories_image'] = categoriesImage;
    data['categories_datetime'] = categoriesDatetime;
    data['itemsdiscprice'] = itemsdiscprice; // إضافة الحقل إلى الـ JSON
    data['favorite'] = favorite;
    return data;
  }
}
