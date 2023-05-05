import 'dart:convert';

class ProductsModel {
  int? id;
  String? name;
  String? shortDescription;
  String? fullDescription;
  String? productPolicy;
  dynamic homePageDescription;
  String? seName;
  bool? cspIsPercent;
  dynamic cspDiscountValue;
  bool? cspIsCombineWithOtherDiscount;
  bool? flashSale;
  dynamic flashSaleStartTimeUTC;
  dynamic flashSaleEndTimeUTC;
  dynamic flashSalePriceAmount;
  int? flashSaleQuantity;
  int? flashSaleSelledQuantity;
  dynamic sku;
  String? productType;
  bool? markAsNew;
  DefaultPictureModel? defaultPictureModel;
  List<ProductTags>? productTags;
  ProductPrice? productPrice;
  dynamic products;

  ProductsModel(
      {this.id,
      this.name,
      this.shortDescription,
      this.fullDescription,
      this.productPolicy,
      this.homePageDescription,
      this.seName,
      this.cspIsPercent,
      this.cspDiscountValue,
      this.cspIsCombineWithOtherDiscount,
      this.flashSale,
      this.flashSaleStartTimeUTC,
      this.flashSaleEndTimeUTC,
      this.flashSalePriceAmount,
      this.flashSaleQuantity,
      this.flashSaleSelledQuantity,
      this.sku,
      this.productType,
      this.markAsNew,
      this.defaultPictureModel,
      this.productTags,
      this.productPrice,
      this.products});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    shortDescription = json['ShortDescription'];
    fullDescription = json['FullDescription'];
    productPolicy = json['ProductPolicy'];
    homePageDescription = json['HomePageDescription'];
    seName = json['SeName'];
    cspIsPercent = json['CspIsPercent'];
    cspDiscountValue = json['CspDiscountValue'];
    cspIsCombineWithOtherDiscount = json['CspIsCombineWithOtherDiscount'];
    flashSale = json['FlashSale'];
    flashSaleStartTimeUTC = json['FlashSaleStartTimeUTC'];
    flashSaleEndTimeUTC = json['FlashSaleEndTimeUTC'];
    flashSalePriceAmount = json['FlashSalePriceAmount'];
    flashSaleQuantity = json['FlashSaleQuantity'];
    flashSaleSelledQuantity = json['FlashSaleSelledQuantity'];
    sku = json['Sku'];
    productType = json['ProductType'];
    markAsNew = json['MarkAsNew'];
    defaultPictureModel = json['DefaultPictureModel'] != null
        ? DefaultPictureModel.fromJson(json['DefaultPictureModel'])
        : null;
    if (json['ProductTags'] != null) {
      productTags = <ProductTags>[];
      json['ProductTags'].forEach((v) {
        productTags!.add(ProductTags.fromJson(v));
      });
    }
    productPrice = json['ProductPrice'] != null
        ? ProductPrice.fromJson(json['ProductPrice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['ShortDescription'] = shortDescription;
    data['FullDescription'] = fullDescription;
    data['ProductPolicy'] = productPolicy;
    data['HomePageDescription'] = homePageDescription;
    data['SeName'] = seName;
    data['CspIsPercent'] = cspIsPercent;
    data['CspDiscountValue'] = cspDiscountValue;
    data['CspIsCombineWithOtherDiscount'] = cspIsCombineWithOtherDiscount;
    data['FlashSale'] = flashSale;
    data['FlashSaleStartTimeUTC'] = flashSaleStartTimeUTC;
    data['FlashSaleEndTimeUTC'] = flashSaleEndTimeUTC;
    data['FlashSalePriceAmount'] = flashSalePriceAmount;
    data['FlashSaleQuantity'] = flashSaleQuantity;
    data['FlashSaleSelledQuantity'] = flashSaleSelledQuantity;
    data['Sku'] = sku;
    data['ProductType'] = productType;
    data['MarkAsNew'] = markAsNew;
    if (defaultPictureModel != null) {
      data['DefaultPictureModel'] = defaultPictureModel!.toJson();
    }
    if (productTags != null) {
      data['ProductTags'] = productTags!.map((v) => v.toJson()).toList();
    }
    if (productPrice != null) {
      data['ProductPrice'] = productPrice!.toJson();
    }
    if (products != null) {
      data['Products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<ProductsModel> decode(String productsModel) =>
      (json.decode(productsModel) as List<dynamic>)
          .map<ProductsModel>((item) => ProductsModel.fromJson(item))
          .toList();
}

class ProductTags {
  String? name;
  String? seName;
  int? productCount;
  int? id;

  ProductTags({
    this.name,
    this.seName,
    this.productCount,
    this.id,
  });

  ProductTags.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    seName = json['SeName'];
    productCount = json['ProductCount'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['SeName'] = seName;
    data['ProductCount'] = productCount;
    data['Id'] = id;
    return data;
  }
}

class DefaultPictureModel {
  String? imageUrl;
  dynamic thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;

  DefaultPictureModel({
    this.imageUrl,
    this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  DefaultPictureModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['ImageUrl'];
    thumbImageUrl = json['ThumbImageUrl'];
    fullSizeImageUrl = json['FullSizeImageUrl'];
    title = json['Title'];
    alternateText = json['AlternateText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ImageUrl'] = imageUrl;
    data['ThumbImageUrl'] = thumbImageUrl;
    data['FullSizeImageUrl'] = fullSizeImageUrl;
    data['Title'] = title;
    data['AlternateText'] = alternateText;
    return data;
  }
}

class ProductPrice {
  String? oldPrice;
  double? oldPriceValue;
  String? price;
  double? priceValue;
  dynamic basePricePAngV;
  double? basePricePAngVValue;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? disableAddToCompareListButton;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  bool? isRental;
  bool? forceRedirectionAfterAddingToCart;
  bool? displayTaxShippingInfo;

  ProductPrice(
      {this.oldPrice,
      this.oldPriceValue,
      this.price,
      this.priceValue,
      this.basePricePAngV,
      this.basePricePAngVValue,
      this.disableBuyButton,
      this.disableWishlistButton,
      this.disableAddToCompareListButton,
      this.availableForPreOrder,
      this.preOrderAvailabilityStartDateTimeUtc,
      this.isRental,
      this.forceRedirectionAfterAddingToCart,
      this.displayTaxShippingInfo});

  ProductPrice.fromJson(Map<String, dynamic> json) {
    oldPrice = json['OldPrice'];
    oldPriceValue = json['OldPriceValue'];
    price = json['Price'];
    priceValue = json['PriceValue'];
    basePricePAngV = json['BasePricePAngV'];
    basePricePAngVValue = json['BasePricePAngVValue'];
    disableBuyButton = json['DisableBuyButton'];
    disableWishlistButton = json['DisableWishlistButton'];
    disableAddToCompareListButton = json['DisableAddToCompareListButton'];
    availableForPreOrder = json['AvailableForPreOrder'];
    preOrderAvailabilityStartDateTimeUtc =
        json['PreOrderAvailabilityStartDateTimeUtc'];
    isRental = json['IsRental'];
    forceRedirectionAfterAddingToCart =
        json['ForceRedirectionAfterAddingToCart'];
    displayTaxShippingInfo = json['DisplayTaxShippingInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OldPrice'] = oldPrice;
    data['OldPriceValue'] = oldPriceValue;
    data['Price'] = price;
    data['PriceValue'] = priceValue;
    data['BasePricePAngV'] = basePricePAngV;
    data['BasePricePAngVValue'] = basePricePAngVValue;
    data['DisableBuyButton'] = disableBuyButton;
    data['DisableWishlistButton'] = disableWishlistButton;
    data['DisableAddToCompareListButton'] = disableAddToCompareListButton;
    data['AvailableForPreOrder'] = availableForPreOrder;
    data['PreOrderAvailabilityStartDateTimeUtc'] =
        preOrderAvailabilityStartDateTimeUtc;
    data['IsRental'] = isRental;
    data['ForceRedirectionAfterAddingToCart'] =
        forceRedirectionAfterAddingToCart;
    data['DisplayTaxShippingInfo'] = displayTaxShippingInfo;
    return data;
  }
}
