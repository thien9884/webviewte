import 'package:webviewtest/model/news/news_model.dart';

class RelatedModel {
  int? httpStatusCode;
  bool? success;
  dynamic message;
  RelatedNews? data;
  int? total;
  int? totalDone;
  int? totalNotDone;
  int? totalLock;
  int? totalFilter;
  dynamic objectCount;

  RelatedModel({
    this.httpStatusCode,
    this.success,
    this.message,
    this.data,
    this.total,
    this.totalDone,
    this.totalNotDone,
    this.totalLock,
    this.totalFilter,
    this.objectCount,
  });

  RelatedModel.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['HttpStatusCode'];
    success = json['Success'];
    message = json['Message'];
    data = json['Data'] != null ? RelatedNews.fromJson(json['Data']) : null;
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
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
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

class RelatedNews {
  int? relatedEntityTypeEnum;
  List<ProductOverviewModels>? productOverviewModels;
  List<NewsItems>? newsItemModels;

  RelatedNews({
    this.relatedEntityTypeEnum,
    this.productOverviewModels,
    this.newsItemModels,
  });

  RelatedNews.fromJson(Map<String, dynamic> json) {
    relatedEntityTypeEnum = json['RelatedEntityTypeEnum'];
    if (json['ProductOverviewModels'] != null) {
      productOverviewModels = <ProductOverviewModels>[];
      json['ProductOverviewModels'].forEach((v) {
        productOverviewModels!.add(ProductOverviewModels.fromJson(v));
      });
    }
    if (json['NewsItemModels'] != null) {
      newsItemModels = <NewsItems>[];
      json['NewsItemModels'].forEach((v) {
        newsItemModels!.add(NewsItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RelatedEntityTypeEnum'] = relatedEntityTypeEnum;
    if (productOverviewModels != null) {
      data['ProductOverviewModels'] =
          productOverviewModels!.map((v) => v.toJson()).toList();
    }
    if (newsItemModels != null) {
      data['NewsItemModels'] = newsItemModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductOverviewModels {
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
  ProductPrice? productPrice;
  List<dynamic>? products;

  ProductOverviewModels({
    this.id,
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
    this.productPrice,
    this.products,
  });

  ProductOverviewModels.fromJson(Map<String, dynamic> json) {
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
    productPrice = json['ProductPrice'] != null
        ? ProductPrice.fromJson(json['ProductPrice'])
        : null;
    // if (json['Products'] != null) {
    //   products = <Null>[];
    //   json['Products'].forEach((v) {
    //     products!.add(Null.fromJson(v));
    //   });
    // }
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
    if (productPrice != null) {
      data['ProductPrice'] = productPrice!.toJson();
    }
    // if (products != null) {
    //   data['Products'] = products!.map((v) => v.toJson()).toList();
    // }
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
  dynamic basePricePAngVValue;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? disableAddToCompareListButton;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  bool? isRental;
  bool? forceRedirectionAfterAddingToCart;
  bool? displayTaxShippingInfo;

  ProductPrice({
    this.oldPrice,
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
    this.displayTaxShippingInfo,
  });

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

class NewsItemModels {
  String? metaKeywords;
  String? metaDescription;
  String? metaTitle;
  String? seName;
  String? title;
  String? short;
  String? full;
  bool? allowComments;
  bool? preventNotRegisteredUsersToLeaveComments;
  int? numberOfComments;
  String? createdOn;
  PictureModel? pictureModel;
  List<dynamic>? comments;
  AddNewComment? addNewComment;
  int? id;

  NewsItemModels({
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.title,
    this.short,
    this.full,
    this.allowComments,
    this.preventNotRegisteredUsersToLeaveComments,
    this.numberOfComments,
    this.createdOn,
    this.pictureModel,
    this.comments,
    this.addNewComment,
    this.id,
  });

  NewsItemModels.fromJson(Map<String, dynamic> json) {
    metaKeywords = json['MetaKeywords'];
    metaDescription = json['MetaDescription'];
    metaTitle = json['MetaTitle'];
    seName = json['SeName'];
    title = json['Title'];
    short = json['Short'];
    full = json['Full'];
    allowComments = json['AllowComments'];
    preventNotRegisteredUsersToLeaveComments =
        json['PreventNotRegisteredUsersToLeaveComments'];
    numberOfComments = json['NumberOfComments'];
    createdOn = json['CreatedOn'];
    pictureModel = json['PictureModel'] != null
        ? PictureModel.fromJson(json['PictureModel'])
        : null;
    // if (json['Comments'] != null) {
    //   comments = <Null>[];
    //   json['Comments'].forEach((v) {
    //     comments!.add(new Null.fromJson(v));
    //   });
    // }
    addNewComment = json['AddNewComment'] != null
        ? AddNewComment.fromJson(json['AddNewComment'])
        : null;
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MetaKeywords'] = metaKeywords;
    data['MetaDescription'] = metaDescription;
    data['MetaTitle'] = metaTitle;
    data['SeName'] = seName;
    data['Title'] = title;
    data['Short'] = short;
    data['Full'] = full;
    data['AllowComments'] = allowComments;
    data['PreventNotRegisteredUsersToLeaveComments'] =
        preventNotRegisteredUsersToLeaveComments;
    data['NumberOfComments'] = numberOfComments;
    data['CreatedOn'] = createdOn;
    if (pictureModel != null) {
      data['PictureModel'] = pictureModel!.toJson();
    }
    // if (this.comments != null) {
    //   data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
    // }
    if (addNewComment != null) {
      data['AddNewComment'] = addNewComment!.toJson();
    }
    data['Id'] = id;
    return data;
  }
}

class PictureModel {
  String? imageUrl;
  dynamic thumbImageUrl;
  String? fullSizeImageUrl;
  String? title;
  String? alternateText;

  PictureModel({
    this.imageUrl,
    this.thumbImageUrl,
    this.fullSizeImageUrl,
    this.title,
    this.alternateText,
  });

  PictureModel.fromJson(Map<String, dynamic> json) {
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

class AddNewComment {
  dynamic commentTitle;
  dynamic commentText;
  bool? displayCaptcha;
  int? id;

  AddNewComment({
    this.commentTitle,
    this.commentText,
    this.displayCaptcha,
    this.id,
  });

  AddNewComment.fromJson(Map<String, dynamic> json) {
    commentTitle = json['CommentTitle'];
    commentText = json['CommentText'];
    displayCaptcha = json['DisplayCaptcha'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CommentTitle'] = commentTitle;
    data['CommentText'] = commentText;
    data['DisplayCaptcha'] = displayCaptcha;
    data['Id'] = id;
    return data;
  }
}
