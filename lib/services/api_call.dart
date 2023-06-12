import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:webviewtest/constant/api_constant.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/category_model/category_group_model.dart';
import 'package:webviewtest/model/coupon/coupon_model.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/model/customer/product_rating_model.dart';
import 'package:webviewtest/model/customer/rating_model.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/model/my_rank/my_rank_model.dart';
import 'package:webviewtest/model/my_system/my_system_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/news_category/news_category_model.dart';
import 'package:webviewtest/model/notification/noti_model.dart';
import 'package:webviewtest/model/order/order_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/model/register/register_model.dart';
import 'package:webviewtest/model/register/register_response.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';
import 'package:webviewtest/model/state/state_model.dart';
import 'package:webviewtest/model/subcategory/subcategory_model.dart';
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
    var response = await DioClient().get('${ApiConstant.relatedNews}$newsId');
    if (response == null) return null;
    final data = response['Data'];
    return RelatedNews.fromJson(data);
  }

  @override
  Future<NewsCategoryModel?> requestGetNewsGroup(
      int? groupId, int? page) async {
    var response = await DioClient().get(
        '${ApiConstant.newsGroup}?NewsGroupId=$groupId&Page=$page&PageSize=8');
    if (response == null) return null;
    final data = response;
    return NewsCategoryModel.fromJson(data);
  }

  @override
  Future<CategoryGroupModel?> requestGetProductsGroup(
      int? groupId, int? page) async {
    var response = await DioClient().get(
        '${ApiConstant.productsGroup}?CategoryId=$groupId&Page=$page&PageSize=8');
    if (response == null) return null;
    final data = response;
    return CategoryGroupModel.fromJson(data);
  }

  @override
  Future<BannerModel?> requestGetTopBanner() async {
    var response = await DioClient().get(ApiConstant.topBanner);
    if (response == null) return null;
    final data = response;
    return BannerModel.fromJson(data);
  }

  @override
  Future<BannerModel?> requestGetHomeBanner() async {
    var response = await DioClient().get(ApiConstant.homeBanner);
    if (response == null) return null;
    final data = response;
    return BannerModel.fromJson(data);
  }

  @override
  Future<BannerModel?> requestGetFooterBanner() async {
    var response = await DioClient().get(ApiConstant.footer);
    if (response == null) return null;
    final data = response;
    return BannerModel.fromJson(data);
  }

  @override
  Future<BannerModel?> requestGetCategoryBanner(int? id) async {
    var response = await DioClient().get('${ApiConstant.categoryBanner}$id');
    if (response == null) return null;
    final data = response;
    return BannerModel.fromJson(data);
  }

  @override
  Future<OrderModel?> requestGetOrder(int? id) async {
    var response = await DioClient().get('${ApiConstant.order}$id');
    if (response == null) return null;
    final data = response;
    return OrderModel.fromJson(data);
  }

  @override
  Future<CustomerModel?> requestGetCustomerAddress(int? id) async {
    var response = await DioClient().get('${ApiConstant.customer}$id');
    if (response == null) return null;
    final data = response;
    return CustomerModel.fromJson(data);
  }

  @override
  Future<MySystemModel?> requestGetMySystem(
      int? id, int? page, int? size) async {
    var response = await DioClient()
        .get('${ApiConstant.mySystem}?level=$id&pageIndex=$page&pageSize=8');
    if (response == null) return null;
    final data = response;
    return MySystemModel.fromJson(data);
  }

  @override
  Future<PointNotiModel?> requestGetNoti(int? size) async {
    var response =
        await DioClient().get('${ApiConstant.noti}?numberRecord=$size');
    if (response == null) return null;
    final data = response;
    return PointNotiModel.fromJson(data);
  }

  @override
  Future<String> requestDeleteAddress(int? customerId, int? addressId) async {
    var response = await DioClient()
        .delete('${ApiConstant.address}/$customerId/$addressId');
    if (response == null) return '';
    final data = response;
    return data;
  }

  @override
  Future<String> requestDeleteAccount() async {
    var response = await DioClient().delete(ApiConstant.customer);
    if (response == null) return '';
    final data = response;
    return data.toString();
  }

  @override
  Future<String> requestUpdateInfo(InfoModel? infoModel) async {
    var response = await DioClient().put(ApiConstant.updateInfo, infoModel);
    if (response == null) return '';
    final data = response;
    return data;
  }

  @override
  Future<String> requestRecoveryPassword(String email) async {
    var response =
        await DioClient().post(ApiConstant.recovery, {"email": email});
    if (response == null) return '';
    final data = response;
    return data;
  }

  @override
  Future<String> requestChangePassword(
    String oldPassword,
    String newPassword,
    String confirmNew,
  ) async {
    var response = await DioClient().put(ApiConstant.changePassword, {
      "OldPassword": oldPassword,
      "NewPassword": newPassword,
      "ConfirmNewPassword": confirmNew
    });
    if (response == null) return '';
    final data = response;
    return data;
  }

  @override
  Future<List<ProductHistory>> requestGetProduct(int? id) async {
    var response = await DioClient().get('${ApiConstant.productRating}$id');
    if (response == null) return [];
    Iterable list = response['products'];
    return list.map((e) => ProductHistory.fromJson(e)).toList();
  }

  @override
  Future<List<RatingHistoryModel>?> requestGetRatingHistory(int? id) async {
    var response = await DioClient().get('${ApiConstant.rating}$id');
    if (response == null) return [];
    Iterable list = response;
    return list.map((e) => RatingHistoryModel.fromJson(e)).toList();
  }

  @override
  Future<Addresses?> requestPostAddAddress(
      int? id, Addresses? addAddressModel) async {
    var response = await DioClient()
        .post('${ApiConstant.customer}$id/billingaddress', addAddressModel);
    if (response == null) return null;
    final data = response;
    return Addresses.fromJson(data);
  }

  @override
  Future<MyRankModel?> requestGetMyRank(
    int? page,
  ) async {
    var response =
        await DioClient().get('${ApiConstant.rewardPoint}?pageNumber=$page');
    if (response == null) return null;
    final data = response;
    return MyRankModel.fromJson(data);
  }

  @override
  Future<CouponModel?> requestGetPointExchange(
    int? point,
  ) async {
    var response = await DioClient()
        .get('${ApiConstant.exchangeCoupon}?pointExchange=$point');
    if (response == null) return null;
    final data = response;
    return CouponModel.fromJson(data);
  }

  @override
  Future<TotalCoupon?> requestGetListCoupon(int index, int size) async {
    var response = await DioClient()
        .get('${ApiConstant.listCoupon}?pageIndex=$index&pageSize=$size');
    if (response == null) return null;
    final data = response;
    return TotalCoupon.fromJson(data);
  }

  @override
  Future<String?> requestPutAddress(PutAddress? putAddress) async {
    var response = await DioClient().put(ApiConstant.address, putAddress);
    if (response == null) return null;
    final data = response;
    return data;
  }

  @override
  Future<String?> requestGetAvatar() async {
    var response = await DioClient().get(ApiConstant.avatar);
    if (response == null) return null;
    final data = response["AvatarUrl"];
    return data;
  }

  @override
  Future<String?> requestChangeAvatar(File? file) async {
    String fileName = file!.path.split('/').last;
    String fileType = file.path.split('.').last;
    FormData formData = FormData.fromMap({
      "uploadedFile": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", fileType),
      ),
    });
    var response =
        await DioClient().postAvatar(ApiConstant.uploadAvatar, formData);
    if (response == null) return null;
    String data = '';
    try {
      data = response[""]["Errors"][0]["ErrorMessage"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (data.isEmpty) {
      data = response["AvatarUrl"];
    }
    return data;
  }

  @override
  Future<InfoModel?> requestGetInfo() async {
    var response = await DioClient().get(ApiConstant.info);
    if (response == null) return null;
    final data = response;
    return InfoModel.fromJson(data);
  }

  @override
  Future<List<StateModel>?> requestGetState() async {
    var response = await DioClient().get(ApiConstant.state);
    if (response == null) return [];
    Iterable list = response;
    return list.map((e) => StateModel.fromJson(e)).toList();
  }

  @override
  Future<List<ProductsModel>> requestGetListProduct(int? id) async {
    var response = await DioClient().get(ApiConstant.products + id.toString());
    if (response == null) return [];
    Iterable list = response;
    return list.map((e) => ProductsModel.fromJson(e)).toList();
  }

  @override
  Future<List<SubCategories>?> requestGetSubCategories(int? id) async {
    var response = await DioClient().get('${ApiConstant.subCategory}$id');
    if (response == null) return [];
    Iterable list = response["Model"]["SubCategories"];
    return list.map((e) => SubCategories.fromJson(e)).toList();
  }

  @override
  Future<CatalogProductsModel?> requestGetSearchProduct(
    int? pageNumber,
    String? keyValue,
  ) async {
    var value = keyValue?.replaceAll(RegExp(r"\s+"), " ");
    final key = value?.replaceAll(" ", "%20");
    if (kDebugMode) {
      print(key);
    }
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

  @override
  Future<UserModel?> newToken() async {
    var response = await DioClient().post(
        ApiConstant.token,
        LoginModel(
          rememberMe: false,
          guest: true,
          username: 'shopdunk',
          password: 'shopdunk',
        ));
    if (response == null) return null;
    final user = UserModel.fromJson(response);
    DioClient.setToken(user.accessToken ?? '');
    return user;
  }

  @override
  Future<RegisterResponse?> register(RegisterModel? registerModel) async {
    var response = await DioClient().post(ApiConstant.register, registerModel);
    if (response == null) return null;
    final user = RegisterResponse.fromJson(response);
    return user;
  }
}
