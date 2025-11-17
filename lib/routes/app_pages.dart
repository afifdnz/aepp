import 'package:shop/bindings/about_binding.dart';
import 'package:shop/bindings/cart_binding.dart';
import 'package:shop/bindings/login_binding.dart';
import 'package:shop/bindings/product_list_binding.dart';
import 'package:shop/bindings/profile_binding.dart';

import 'package:shop/view/product_list.dart';
import 'package:shop/view/profile.dart';
import 'package:shop/view/register_2.dart';
import 'package:shop/view/register_3.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
import '../view/about.dart';
import '../view/home.dart';
import '../view/dashboard.dart';
import '../view/wishlist.dart';
import '../view/register_1.dart';
import '../view/login.dart';
import '../view/dummy.dart';
import '../viewmodel/about_viewmodel.dart';
import '../viewmodel/home_viewmodel.dart';
import '../bindings/home_binding.dart';
import '../bindings/wishlist_binding.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/register_binding.dart';
import '../view/cart.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;
  static final pages = [
    // GetPage(
    //   name: Routes.HOME,
    //   page: () => const Home(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const Login(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: Routes.ABOUT,
      page: () => const About(),
      binding: AboutBinding(),
    ),

    // GetPage(
    //   name: Routes.PRODUCT_LIST,
    //   page: () => const ProductList(),
    //   binding: ProductListBinding(),
    // ),
    GetPage(
      name: Routes.REGISTER_STEP_1,
      page: () => const RegisterStep1Screen(),
      binding: RegisterBinding(), // Gunakan binding bersama
    ),
    GetPage(
      name: Routes.REGISTER_STEP_2,
      page: () => const RegisterStep2Screen(), // Ganti dengan UI Anda
      binding: RegisterBinding(), // Gunakan binding bersama
    ),
    GetPage(
      name: Routes.REGISTER_STEP_3,
      page: () => const RegisterStep3Screen(), // Ganti dengan UI Anda
      binding: RegisterBinding(), // Gunakan binding bersama
    ),

    GetPage(
      name: Routes.CART,
      page: () => const Cart(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),

      // Ini adalah anak-anak (tab) yang akan
      // dirender di dalam GetRouterOutlet
      children: [
        // --- TAB 1: HOME (dan anak-anaknya) ---
        GetPage(
          name: Routes.HOME,
          page: () => const Home(),
          binding: HomeBinding(),
          children: [
            // Halaman ProductList adalah anak dari Home,
            // jadi saat rute ini aktif, tab Home tetap terpilih.
          ],
        ),
        GetPage(
          name: Routes.PRODUCT_LIST,
          page: () => const ProductList(),
          binding: ProductListBinding(),
        ),
        // --- TAB 2: WISHLIST ---
        GetPage(
          name: Routes.WISHLIST,
          page: () => const Wishlist(),
          binding: WishlistBinding(),
        ),

        // --- TAB 3: PROFILE ---
        GetPage(
          name: Routes.PROFILE,
          page: () => Profile(),
          binding: ProfileBinding(),
          // binding: ProfileBinding(), // Anda bisa tambahkan ini nanti
        ),
      ],
    ),
  ];
}
