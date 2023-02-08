import 'package:webviewtest/constant/api_constant.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/services/api_interfaces.dart';
import 'package:webviewtest/services/dio_client.dart';

class ApiCall implements ApiInterface {
  @override
  Future<List<Categories>> requestGetCategories() async {
    var response = await DioClient().get(baseUrl, categories);
    if (response == null) return [];
    Iterable list = response['categories'];
    return list.map((e) => Categories.fromJson(e)).toList();
  }

  @override
  Future<List<ProductsModel>> requestGetProduct(int? id) async {
    var response = await DioClient().get(baseUrl, products + id.toString());
    if (response == null) return [];
    Iterable list = response;
    return list.map((e) => ProductsModel.fromJson(e)).toList();
  }
}
