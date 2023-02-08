import 'package:webviewtest/model/product/products_model.dart';

class CategoryModel {
  List<Categories>? categories;

  CategoryModel({this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;
  String? description;
  int? categoryTemplateId;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  int? parentCategoryId;
  int? pageSize;
  String? pageSizeOptions;
  dynamic priceRanges;
  dynamic showOnHomePage;
  bool? includeInTopMenu;
  dynamic hasDiscountsApplied;
  bool? published;
  bool? deleted;
  int? displayOrder;
  String? createdOnUtc;
  String? updatedOnUtc;
  List<dynamic>? roleIds;
  List<dynamic>? discountIds;
  List<dynamic>? storeIds;
  ImageProduct? image;
  String? seName;
  int? id;
  List<ProductsModel>? listProduct;

  Categories({
    this.name,
    this.description,
    this.categoryTemplateId,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.parentCategoryId,
    this.pageSize,
    this.pageSizeOptions,
    this.priceRanges,
    this.showOnHomePage,
    this.includeInTopMenu,
    this.hasDiscountsApplied,
    this.published,
    this.deleted,
    this.displayOrder,
    this.createdOnUtc,
    this.updatedOnUtc,
    this.roleIds,
    this.discountIds,
    this.storeIds,
    this.image,
    this.seName,
    this.id,
    this.listProduct,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    categoryTemplateId = json['category_template_id'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    metaTitle = json['meta_title'];
    parentCategoryId = json['parent_category_id'];
    pageSize = json['page_size'];
    pageSizeOptions = json['page_size_options'];
    priceRanges = json['price_ranges'];
    showOnHomePage = json['show_on_home_page'];
    includeInTopMenu = json['include_in_top_menu'];
    hasDiscountsApplied = json['has_discounts_applied'];
    published = json['published'];
    deleted = json['deleted'];
    displayOrder = json['display_order'];
    createdOnUtc = json['created_on_utc'];
    updatedOnUtc = json['updated_on_utc'];
    // if (json['role_ids'] != null) {
    //   roleIds = <Null>[];
    //   json['role_ids'].forEach((v) {
    //     roleIds!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['discount_ids'] != null) {
    //   discountIds = <Null>[];
    //   json['discount_ids'].forEach((v) {
    //     discountIds!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['store_ids'] != null) {
    //   storeIds = <Null>[];
    //   json['store_ids'].forEach((v) {
    //     storeIds!.add(Null.fromJson(v));
    //   });
    // }
    image = json['image'] != null ? ImageProduct.fromJson(json['image']) : null;
    seName = json['se_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['category_template_id'] = categoryTemplateId;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['meta_title'] = metaTitle;
    data['parent_category_id'] = parentCategoryId;
    data['page_size'] = pageSize;
    data['page_size_options'] = pageSizeOptions;
    data['price_ranges'] = priceRanges;
    data['show_on_home_page'] = showOnHomePage;
    data['include_in_top_menu'] = includeInTopMenu;
    data['has_discounts_applied'] = hasDiscountsApplied;
    data['published'] = published;
    data['deleted'] = deleted;
    data['display_order'] = displayOrder;
    data['created_on_utc'] = createdOnUtc;
    data['updated_on_utc'] = updatedOnUtc;
    // if (roleIds != null) {
    //   data['role_ids'] = roleIds!.map((v) => v.toJson()).toList();
    // }
    // if (discountIds != null) {
    //   data['discount_ids'] = discountIds!.map((v) => v.toJson()).toList();
    // }
    // if (storeIds != null) {
    //   data['store_ids'] = storeIds!.map((v) => v.toJson()).toList();
    // }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['se_name'] = seName;
    data['id'] = id;
    return data;
  }
}

class ImageProduct {
  String? src;
  dynamic attachment;

  ImageProduct({this.src, this.attachment});

  ImageProduct.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['attachment'] = attachment;
    return data;
  }
}
