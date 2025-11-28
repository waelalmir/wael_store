// routes.dart
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/middleware/middleware.dart';
import 'package:ecommerce/view/screen/address/addressadd.dart';
import 'package:ecommerce/view/screen/address/adressview.dart';
import 'package:ecommerce/view/screen/auth/forgotpassword/forgotpassword.dart';
import 'package:ecommerce/view/screen/auth/forgotpassword/successresetpassword.dart';
import 'package:ecommerce/view/screen/auth/successsignup.dart';
import 'package:ecommerce/view/screen/auth/login.dart';
import 'package:ecommerce/view/screen/auth/forgotpassword/resetpassword.dart';
import 'package:ecommerce/view/screen/auth/signup.dart';
import 'package:ecommerce/view/screen/auth/forgotpassword/verifyode.dart';
import 'package:ecommerce/view/screen/auth/verifysignup.dart';
import 'package:ecommerce/view/screen/cart.dart';
import 'package:ecommerce/view/screen/checkout.dart';
import 'package:ecommerce/view/screen/home/homescreen.dart';
import 'package:ecommerce/view/screen/product/items.dart';
import 'package:ecommerce/view/screen/global/langauge.dart';
import 'package:ecommerce/view/screen/product/myfavorite.dart';
import 'package:ecommerce/view/screen/product/offers.dart';
import 'package:ecommerce/view/screen/global/onboarding.dart';
import 'package:ecommerce/view/screen/orders/archiveorders.dart';
import 'package:ecommerce/view/screen/orders/orders.dart';
import 'package:ecommerce/view/screen/orders/ordersdetails.dart';
import 'package:ecommerce/view/screen/product/productdetails.dart';
import 'package:ecommerce/view/screen/global/settings.dart';
import 'package:get/get.dart';

// تم تحويلها من Map إلى List<GetPage>
List<GetPage<dynamic>> routes = [
  // Auth
  GetPage(
      name: "/", page: () => const Langauge(), middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoutes.homePage, page: () => const HomeScreen()),
  GetPage(name: AppRoutes.itemsPage, page: () => const ItemsPage()),
  GetPage(name: AppRoutes.login, page: () => const Login()),
  GetPage(name: AppRoutes.signup, page: () => const Signup()),
  GetPage(name: AppRoutes.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoutes.resetPassowrd, page: () => const ResetPassword()),
  GetPage(name: AppRoutes.verifyCode, page: () => const VerifyCode()),
  GetPage(name: AppRoutes.successsignup, page: () => const SuccessSignUp()),
  GetPage(name: AppRoutes.settings, page: () => const Settings()),
  GetPage(name: AppRoutes.cart, page: () => const Cart()),
  GetPage(
      name: AppRoutes.successresetpassword,
      page: () => const SuccessResetPassword()),
  GetPage(name: AppRoutes.verifysignup, page: () => const Verifysignup()),

  GetPage(name: AppRoutes.onBoarding, page: () => const OnBoarding()),
  GetPage(name: AppRoutes.productDetails, page: () => const ProductDetails()),
  GetPage(name: AppRoutes.myfavorite, page: () => const MyFavorite()),
  /////////////////////////////address
  GetPage(name: AppRoutes.address, page: () => const Adress()),
  GetPage(name: AppRoutes.addressAdd, page: () => const Addressadd()),
  // GetPage(name: AppRoutes.addressMap, page: () => const AdressMap()),
  GetPage(name: AppRoutes.checkout, page: () => const CheckOut()),
  GetPage(name: AppRoutes.orders, page: () => const Orders()),
  GetPage(name: AppRoutes.ordersDetails, page: () => const OrdersDetails()),
  GetPage(name: AppRoutes.archiveDetails, page: () => const Archiveorders()),
  GetPage(name: AppRoutes.offers, page: () => const OffersPage()),
];
