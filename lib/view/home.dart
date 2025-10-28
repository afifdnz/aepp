import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/viewmodel/home_viewmodel.dart';
import 'package:shop/widgets/product_card.dart';
import 'package:shop/widgets/category_card.dart';
import 'package:shop/view/about.dart';
import 'package:shop/routes/app_pages.dart';
import 'package:shop/routes/app_routes.dart';

class Home extends GetView<HomeViewmodel> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildHeader(),
                const SizedBox(height: 15),
                // _buildTitle(),
                // const SizedBox(height: 25),
                _buildSearchBar(),
                const SizedBox(height: 25),
                _buildHeroButtons(),
                const SizedBox(height: 25),
                _buildCategories(context),
                const SizedBox(height: 25),
                const Text(
                  'Product',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 25),
                _buildProductGrid(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(
              'Aepp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.grey[800],
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Hey, buy the best\nElectronic Gadget',
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.2),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search any product',
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
        filled: true,
        fillColor: const Color(0xFF222222),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(38),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
      style: const TextStyle(color: Colors.white),
      onSubmitted: (value) {},
    );
  }

  Widget _buildHeroButtons() {
    return Row(
      children: [
        Expanded(
          child: _heroButton(
            text: 'Top Deals',
            onTap: () {
              // Aksi untuk Top Deals
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _heroButton(
            text: 'Best Seller',
            onTap: () {
              // Aksi untuk Best Seller
            },
          ),
        ),
      ],
    );
  }

  Widget _heroButton({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140, // Sesuaikan tinggi
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0), // Warna netral
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Widget _buildCategories() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Categories',
  //         style: TextStyle(
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black,
  //         ),
  //       ),
  //       const SizedBox(height: 15),
  //       SizedBox(
  //         height: 90,
  //         child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: controller.categories.length,
  //           itemBuilder: (context, index) {
  //             var category = controller.categories[index];
  //             return Obx(() {
  //               bool isSelected =
  //                   controller.selectedCategoryIndex.value == index;
  //               return CategoryCard(
  //                 icon: controller.categories[index]['icon'],
  //                 name: controller.categories[index]['name'],
  //                 isSelected: isSelected,
  //                 onTap: () => controller.changeCategory(index),
  //               );
  //             });
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              var category = controller.categories[index];
              // Tidak perlu Obx lagi karena 'isSelected' tidak relevan
              return CategoryCard(
                icon: category['icon'],
                name: category['name'],
                isSelected: false, // Selalu false, karena klik akan navigasi
                onTap: () => controller.changeCategory(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      }

      return GridView.builder(
        itemCount: controller.productList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          var product = controller.productList[index];
          print("Product: ${product.id}");
          return ProductCard(
            product: product,
            onTap: () {
              // Get.to(() => About());
              Get.toNamed(Routes.ABOUT, arguments: {"id": product.id});
            },
          );
        },
      );
    });
  }

  Widget _buildBottomNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),

      child: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          backgroundColor: const Color(0xFF222222),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[600],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Icon(Icons.favorite),
              label: 'WishList',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
