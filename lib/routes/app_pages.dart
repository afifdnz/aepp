import 'package:shop/bindings/about_binding.dart';
import 'package:shop/bindings/product_list_binding.dart';

import 'package:shop/view/product_list.dart';
import 'app_routes.dart';
import 'package:get/get.dart';
import '../view/about.dart';
import '../view/home.dart';
import '../viewmodel/about_viewmodel.dart';
import '../viewmodel/home_viewmodel.dart';
import '../bindings/home_binding.dart';

class AppPages {
  static const INITIAL = Routes.HOME;
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ABOUT,
      page: () => const About(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_LIST,
      page: () => const ProductList(),
      binding: ProductListBinding(),
    ),
  ];
}
