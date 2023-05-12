import 'package:webviewtest/model/customer/product_rating_model.dart';

class RatingModel {
  int? customerId;
  int? productId;
  int? storeId;
  bool? isApproved;
  String? title;
  String? reviewText;
  dynamic replyText;
  bool? customerNotifiedOfReply;
  int? rating;
  int? helpfulYesTotal;
  int? helpfulNoTotal;
  String? createdOnUtc;
  ProductHistory? productsModel;
  int? id;

  RatingModel({
    this.customerId,
    this.productId,
    this.storeId,
    this.isApproved,
    this.title,
    this.reviewText,
    this.replyText,
    this.customerNotifiedOfReply,
    this.rating,
    this.helpfulYesTotal,
    this.helpfulNoTotal,
    this.createdOnUtc,
    this.productsModel,
    this.id,
  });

  RatingModel.fromJson(Map<String, dynamic> json) {
    customerId = json['CustomerId'];
    productId = json['ProductId'];
    storeId = json['StoreId'];
    isApproved = json['IsApproved'];
    title = json['Title'];
    reviewText = json['ReviewText'];
    replyText = json['ReplyText'];
    customerNotifiedOfReply = json['CustomerNotifiedOfReply'];
    rating = json['Rating'];
    helpfulYesTotal = json['HelpfulYesTotal'];
    helpfulNoTotal = json['HelpfulNoTotal'];
    createdOnUtc = json['CreatedOnUtc'];
    productsModel = json['ProductsModel'] != null ? ProductHistory.fromJson(json['ProductsModel']) : null;
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerId'] = customerId;
    data['ProductId'] = productId;
    data['StoreId'] = storeId;
    data['IsApproved'] = isApproved;
    data['Title'] = title;
    data['ReviewText'] = reviewText;
    data['ReplyText'] = replyText;
    data['CustomerNotifiedOfReply'] = customerNotifiedOfReply;
    data['Rating'] = rating;
    data['HelpfulYesTotal'] = helpfulYesTotal;
    data['HelpfulNoTotal'] = helpfulNoTotal;
    data['CreatedOnUtc'] = createdOnUtc;
    if (productsModel != null) {
      data['ProductsModel'] = productsModel!.toJson();
    }
    data['Id'] = id;
    return data;
  }
}
