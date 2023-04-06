import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';

abstract class ApiInterface {
  // Get categories
  Future<List<Categories>> requestGetCategories();

  // Get news
  Future<NewsData?> requestGetNews();

  // Get news
  Future<RelatedNews?> requestGetRelatedNews(int? newsId);

  // Get list product
  Future<List<ProductsModel>> requestGetProduct(int? id);

  // Login
  Future<UserModel?> login(LoginModel? loginModel);
}