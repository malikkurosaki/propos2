import 'package:get/route_manager.dart';
import './pages/business_detail_page.dart';
import './pages/checkout_page.dart';
import './pages/forgot_password_page.dart';
import './pages/home_page.dart';
import './pages/login_page.dart';
import './pages/payment_success_page.dart';
import './pages/register_page.dart';
import './pages/registration_detail_page.dart';
import './pages/root_page.dart';
import './pages/test_page.dart';

import './pages/business_detail_page.dart';
import './pages/checkout_page.dart';
import './pages/forgot_password_page.dart';
import './pages/home_page.dart';
import './pages/login_page.dart';
import './pages/payment_success_page.dart';
import './pages/register_page.dart';
import './pages/registration_detail_page.dart';
import './pages/root_page.dart';
import './pages/test_page.dart';
class Pages {
  late String route;

  Pages.businessDetailPage(): route = "/business_detail_page";
  Pages.checkoutPage(): route = "/checkout_page";
  Pages.forgotPasswordPage(): route = "/forgot_password_page";
  Pages.homePage(): route = "/home_page";
  Pages.loginPage(): route = "/login_page";
  Pages.paymentSuccessPage(): route = "/payment_success_page";
  Pages.registerPage(): route = "/register_page";
  Pages.registrationDetailPage(): route = "/registration_detail_page";
  Pages.rootPage(): route = "/";
  Pages.testPage(): route = "/test_page";

  static final listPage = < GetPage > [
    GetPage(
      name: "/business_detail_page",
      page: () => BusinessDetailPage(),
    ),
    GetPage(
      name: "/checkout_page",
      page: () => CheckoutPage(),
    ),
    GetPage(
      name: "/forgot_password_page",
      page: () => ForgotPasswordPage(),
    ),
    GetPage(
      name: "/home_page",
      page: () => HomePage(),
    ),
    GetPage(
      name: "/login_page",
      page: () => LoginPage(),
    ),
    GetPage(
      name: "/payment_success_page",
      page: () => PaymentSuccessPage(),
    ),
    GetPage(
      name: "/register_page",
      page: () => RegisterPage(),
    ),
    GetPage(
      name: "/registration_detail_page",
      page: () => RegistrationDetailPage(),
    ),
    GetPage(
      name: "/",
      page: () => RootPage(),
    ),
    GetPage(
      name: "/test_page",
      page: () => TestPage(),
    )
  ];

}