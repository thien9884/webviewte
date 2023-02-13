import 'package:webviewtest/constant/api_constant.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
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
  Future<List<ProductsModel>> requestGetProduct(int? id) async {
    var response = await DioClient().get(ApiConstant.products + id.toString());
    if (response == null) return [];
    Iterable list = response;
    return list.map((e) => ProductsModel.fromJson(e)).toList();
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
