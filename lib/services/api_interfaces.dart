import 'package:webviewtest/model/category_model.dart';

abstract class ApiInterface {
  // Get categories
  Future<List<Categories>> requestGetCategories();
}