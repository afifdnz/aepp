import 'package:get/get.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/repositories/product_repository.dart';

class ProductListViewmodel extends GetxController {
  final ProductRepository repository;
  ProductListViewmodel({required this.repository});

  var tabIndex = 0.obs;
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;
  var categoryName = ''.obs;
  var selectedSortIndex = 0.obs;

  final List<String> sortOptions = [
    'new',
    'Featured',
    'must see',
    'top selected',
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null && args.containsKey('category')) {
      categoryName.value = args['category'];
      fetchProductByCategory();
    } else {
      isLoading.value = false;
    }
  }

  void fetchProductByCategory() async {
    try {
      isLoading(true);
      var product = await repository.getProductsByCategory(categoryName.value);
      productList.assignAll(product);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product for this category.');
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void changeSortOption(int index) {
    selectedSortIndex.value = index;
  }
}
