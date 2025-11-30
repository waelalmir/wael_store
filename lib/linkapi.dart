class AppLink {
  static const String server = "https://example.com/api";

  // Auth
  static const String signUp = "$server/signup";
  static const String login = "$server/login";
  static const String verify = "$server/verify";

  // Products
  static const String items = "$server/items";
  static const String itemSearch = "$server/items/search";
  static const String topSelling = "$server/items/top";

  // Favorites
  static const String addFavorite = "$server/favorite/add";
  static const String removeFavorite = "$server/favorite/remove";

  // Cart
  static const String cartAdd = "$server/cart/add";
  static const String cartView = "$server/cart/view";

  // Orders
  static const String checkout = "$server/orders/checkout";
  static const String pendingOrders = "$server/orders/pending";
}
