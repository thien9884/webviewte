import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/category_model/category_group_model.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/model/customer/product_rating_model.dart';
import 'package:webviewtest/model/customer/rating_model.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/model/my_system/my_system_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/news_category/news_category_model.dart';
import 'package:webviewtest/model/order/order_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/model/register/register_model.dart';
import 'package:webviewtest/model/register/register_response.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';
import 'package:webviewtest/model/state/state_model.dart';
import 'package:webviewtest/model/subcategory/subcategory_model.dart';

abstract class ApiInterface {
  // Get categories
  Future<List<Categories>> requestGetCategories();

  // Get news
  Future<NewsData?> requestGetNews();

  // Get news
  Future<RelatedNews?> requestGetRelatedNews(int? newsId);

  // Get news group
  Future<NewsCategoryModel?> requestGetNewsGroup(int? groupId, int? page);

  // Get products group
  Future<CategoryGroupModel?> requestGetProductsGroup(int? groupId, int? page);

  // get top banner
  Future<BannerModel?> requestGetTopBanner();

  // get home banner
  Future<BannerModel?> requestGetHomeBanner();

  // get home banner
  Future<BannerModel?> requestGetFooterBanner();

  // get category banner
  Future<BannerModel?> requestGetCategoryBanner(int? id);

  // get order
  Future<OrderModel?> requestGetOrder(int? id);

  // get customer address
  Future<CustomerModel?> requestGetCustomerAddress(int? id);

  // get customer address
  Future<MySystemModel?> requestGetMySystem(int? id);

  // get customer address
  Future<List<RatingHistoryModel>?> requestGetRatingHistory(int? id);

  // post customer address
  Future<Addresses?> requestPostAddAddress(
      int? id, Addresses? addAddressModel);

  // put address
  Future<String?> requestPutAddress(PutAddress? putAddress);

  // get info
  Future<InfoModel?> requestGetInfo();

  // get state
  Future<List<StateModel>?> requestGetState();

  // get category banner
  Future<List<SubCategories>?> requestGetSubCategories(int? id);

  // Get list product
  Future<List<ProductsModel>> requestGetListProduct(int? id);

  // Delete list product
  Future<String> requestDeleteAddress(
    int? customerId,
    int? addressId,
  );

  // update info
  Future<String> requestUpdateInfo(InfoModel? infoModel);

  // Get product
  Future<List<ProductHistory>> requestGetProduct(int? id);

  // Get list product
  Future<CatalogProductsModel?> requestGetSearchProduct(
    int? pageNumber,
    String? keyValue,
  );

  // Post news comment
  Future<NewsCommentResponseModel?> requestPostNewsComment(
    int? id,
    NewsCommentModel newsCommentModel,
  );

  // Login
  Future<UserModel?> login(LoginModel? loginModel);

  // register
  Future<RegisterResponse?> register(RegisterModel? registerModel);
}
