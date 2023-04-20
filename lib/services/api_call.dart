import 'package:webviewtest/constant/api_constant.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';
import 'package:webviewtest/services/api_interfaces.dart';
import 'package:webviewtest/services/dio_client.dart';

class ApiCall implements ApiInterface {
  @override
  Future<List<Categories>> requestGetCategories() async {
    var response = await DioClient().get(ApiConstant.categories);
    if (response == null) return [];
    Iterable list = response['categories'];
    return list.map((e) => Categories.fromJson(e)).toList();
  }

  @override
  Future<NewsData?> requestGetNews() async {
    var response = await DioClient().get(ApiConstant.news);
    if (response == null) return null;
    final data = response['Data'];
    return NewsData.fromJson(data);
  }

  @override
  Future<RelatedNews?> requestGetRelatedNews(int? newsId) async {
    var response = await DioClient().get('${ApiConstant.relatedNews}/$newsId');
    if (response == null) return null;
    final data = response['Data'];
    return RelatedNews.fromJson(data);
  }

  @override
  Future<List<ProductsModel>> requestGetProduct(int? id) async {
    var response = await DioClient().get(ApiConstant.products + id.toString());
    if (response == null) return [];
    Iterable list = response;
    return list.map((e) => ProductsModel.fromJson(e)).toList();
  }

  @override
  Future<CatalogProductsModel?> requestGetSearchProduct(
    int? pageNumber,
    String? keyValue,
  ) async {
    var value = keyValue?.replaceAll(RegExp(r"\s+"), " ");
    final key = value?.replaceAll(" ", "%20");
    print(key);
    var response = await DioClient()
        .get('${ApiConstant.searchProducts}?pagenumber=$pageNumber&q=$key');
    if (response == null) return null;
    final searchResult =
        CatalogProductsModel.fromJson(response["CatalogProductsModel"]);
    return searchResult;
  }

  @override
  Future<NewsCommentResponseModel?> requestPostNewsComment(
    int? id,
    NewsCommentModel newsCommentModel,
  ) async {
    var response = await DioClient().post(
      '${ApiConstant.newsComments}?newsItemId=$id',
      newsCommentModel,
    );
    if (response == null) return null;
    final commentResponse = NewsCommentResponseModel.fromJson(response);
    return commentResponse;
  }

  @override
  Future<UserModel?> login(LoginModel? loginModel) async {
    var response = await DioClient().post(ApiConstant.token, loginModel);
    if (response == null) return null;
    final user = UserModel.fromJson(response);
    DioClient.setToken(user.accessToken ?? '');
    return user;
  }
}
