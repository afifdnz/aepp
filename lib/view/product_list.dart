import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/repositories/product_repository.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:shop/viewmodel/product_list_viewmodel.dart';
import 'package:shop/widgets/product_card.dart';

class ProductList extends GetView<ProductListViewmodel> {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSortTabs(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.productList.isEmpty) {
                return const Center(
                  child: Text('No product found in this category.'),
                );
              }
              return _buildProductGrid();
            }),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Obx(
        () => Text(
          controller.categoryName.value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }

  Widget _buildSortTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.sortOptions.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final isSelected = controller.selectedSortIndex.value == index;
              final option = controller.sortOptions[index];
              return GestureDetector(
                onTap: () => controller.changeSortOption(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: isSelected
                        ? const Border(
                            bottom: BorderSide(color: Colors.black, width: 2),
                          )
                        : null,
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final product = controller.productList[index];
        return ProductCard(
          product: product,
          onTap: () {
            Get.toNamed(Routes.ABOUT, arguments: {'id': product.id});
          },
        );
      },
    );
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
