import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:shop/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/services/auth_service.dart';

import 'package:shop/services/cart_services.dart';
import 'package:shop/services/wishlist_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(CartService(), permanent: true);
  Get.put(WishlistService(), permanent: true);
  Get.put(AuthService(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF222222);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shop UI",

      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          background: Colors.white,
          onPrimary: Colors.white,
          onBackground: Colors.black,
          brightness: Brightness.light,
        ),

        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
            .copyWith(
              headlineLarge: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),

              bodyMedium: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 55),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF0F0F0),
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIconColor: Colors.grey[600],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),

      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
      // initialBinding: HomeBinding(),
      // home: Home(),
    );
  }
}
