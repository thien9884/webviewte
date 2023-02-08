import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/product/products_model.dart';

abstract class ApiInterface {
  // Get categories
  Future<List<Categories>> requestGetCategories();

  // Get list product
  Future<List<ProductsModel>> requestGetProduct(int? id);
}