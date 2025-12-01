import 'package:get/get.dart';
import 'package:shop/models/product_model.dart';
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
    if (args != null &&
        args.containsKey('category_id') &&
        args.containsKey('category_name')) {
      int categoryId = args['category_id'];
      categoryName.value = args['category_name'];
      fetchProductByCategory(categoryId);
    } else {
      isLoading.value = false;
      Get.snackbar('Error', 'Category ID not found.');
    }
  }

  void fetchProductByCategory(int category_id) async {
    try {
      isLoading(true);
      var product = await repository.getProductsByCategoryId(category_id);
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
