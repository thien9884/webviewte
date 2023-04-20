import 'package:webviewtest/model/product/products_model.dart';

class SearchProductsModel {
  CatalogProductsModel? catalogProductsModel;

  SearchProductsModel({
    this.catalogProductsModel,
  });

  SearchProductsModel.fromJson(Map<String, dynamic> json) {
    catalogProductsModel = json['CatalogProductsModel'] != null
        ? CatalogProductsModel.fromJson(json['CatalogProductsModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (catalogProductsModel != null) {
      data['CatalogProductsModel'] = catalogProductsModel!.toJson();
    }
    return data;
  }
}

class CatalogProductsModel {
  List<ProductsModel>? products;
  double? tradeInPrice;
  int? pageIndex;
  int? pageNumber;
  int? pageSize;
  int? totalItems;
  int? totalPages;
  int? firstItem;
  int? lastItem;
  bool? hasPreviousPage;
  bool? hasNextPage;

  CatalogProductsModel({
    this.products,
    this.tradeInPrice,
    this.pageIndex,
    this.pageNumber,
    this.pageSize,
    this.totalItems,
    this.totalPages,
    this.firstItem,
    this.lastItem,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  CatalogProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['Products'] != null) {
      products = <ProductsModel>[];
      json['Products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }
    tradeInPrice = json['TradeInPrice'];
    pageIndex = json['PageIndex'];
    pageNumber = json['PageNumber'];
    pageSize = json['PageSize'];
    totalItems = json['TotalItems'];
    totalPages = json['TotalPages'];
    firstItem = json['FirstItem'];
    lastItem = json['LastItem'];
    hasPreviousPage = json['HasPreviousPage'];
    hasNextPage = json['HasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['Products'] = products!.map((v) => v.toJson()).toList();
    }
    data['TradeInPrice'] = tradeInPrice;
    data['PageIndex'] = pageIndex;
    data['PageNumber'] = pageNumber;
    data['PageSize'] = pageSize;
    data['TotalItems'] = totalItems;
    data['TotalPages'] = totalPages;
    data['FirstItem'] = firstItem;
    data['LastItem'] = lastItem;
    data['HasPreviousPage'] = hasPreviousPage;
    data['HasNextPage'] = hasNextPage;
    return data;
  }
}
