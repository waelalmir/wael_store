class AppLink {
  static const String server = "https://path";
//
  
  static const String imageststatic =
      "https://waelalmir.com/ecommerce/categories";
// ================================= Auth ========================== //

  static const String signUp = "$server/signup.php";
  static const String verifysignup = "$server/verifycode.php";
  static const String login = "$server/login.php";
  static const String checkemail = "$server/checkemail.php";
  static const String verifycode = "$server/verifycode.php";
  static const String resetpassword = "$server/resetpassword.php";
  static const String resend = "$server/resend.php";

// ================================= Home ========================== //

  static const String homePage = "$server/home.php";
  static const String imagestItems = "$imageststatic/items";
  static const String items = "$server/items.php";
  static const String itemsTopSelling = "$server/items/itemstopselling.php";
  static const String searchitems = "$server/items/search.php";

// ================================= Home ========================== //

  static const String addFavorite = "$server/favorite/add.php";
  static const String removeFavorite = "$server/favorite/remove.php";
  static const String viewMyFavorite = "$server/favorite/view.php";
  static const String removeFromMyFavorite =
      "$server/favorite/removefromfavorite.php";

  // ================================= cart ========================== //
  static const String cartView = "$server/cart/view.php";
  static const String cartAdd = "$server/cart/add.php";
  static const String cartremove = "$server/cart/remove.php";
  static const String countItems = "$server/cart/countitems.php";
  static const String checkCoupon = "$server/cart/checkcoupon.php";

  // ================================= adress ========================== //
  static const String adressview = "$server/address/view.php";
  static const String adressadd = "$server/address/add.php";
  static const String adressdelete = "$server/address/delete.php";
  static const String adressedit = "$server/address/edit.php";

  // ================================= orders ========================== //
  static const String checkout = "$server/orders/checkout.php";
  static const String pendingOrders = "$server/orders/pending.php";
  static const String detailsOrders = "$server/orders/details.php";
  static const String deleteOrders = "$server/orders/delete.php";
  static const String archiveOrders = "$server/orders/archive.php";
////////////////////
  static const offers = "$server/offers.php";
  static const rating = "$server/rating.php";
}
