import 'package:webviewtest/model/product/products_model.dart';

class CategoryGroupModel {
  int? httpStatusCode;
  bool? success;
  dynamic message;
  List<ProductsModel>? productModel;
  int? total;
  int? totalDone;
  int? totalNotDone;
  int? totalLock;
  int? totalFilter;
  dynamic objectCount;

  CategoryGroupModel(
      {this.httpStatusCode,
      this.success,
      this.message,
      this.productModel,
      this.total,
      this.totalDone,
      this.totalNotDone,
      this.totalLock,
      this.totalFilter,
      this.objectCount});

  CategoryGroupModel.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['HttpStatusCode'];
    success = json['Success'];
    message = json['Message'];
    if (json['Data'] != null) {
      productModel = <ProductsModel>[];
      json['Data'].forEach((v) {
        productModel!.add(ProductsModel.fromJson(v));
      });
    }
    total = json['Total'];
    totalDone = json['TotalDone'];
    totalNotDone = json['TotalNotDone'];
    totalLock = json['TotalLock'];
    totalFilter = json['TotalFilter'];
    objectCount = json['ObjectCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HttpStatusCode'] = httpStatusCode;
    data['Success'] = success;
    data['Message'] = message;
    if (productModel != null) {
      data['Data'] = productModel!.map((v) => v.toJson()).toList();
    }
    data['Total'] = total;
    data['TotalDone'] = totalDone;
    data['TotalNotDone'] = totalNotDone;
    data['TotalLock'] = totalLock;
    data['TotalFilter'] = totalFilter;
    data['ObjectCount'] = objectCount;
    return data;
  }
}
