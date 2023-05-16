class RatingHistoryModel {
  ProductReview? productReview;
  String? productName;
  String? productSeaName;

  RatingHistoryModel(
      {this.productReview, this.productName, this.productSeaName});

  RatingHistoryModel.fromJson(Map<String, dynamic> json) {
    productReview = json['ProductReview'] != null
        ? ProductReview.fromJson(json['ProductReview'])
        : null;
    productName = json['ProductName'];
    productSeaName = json['ProductSeaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productReview != null) {
      data['ProductReview'] = productReview!.toJson();
    }
    data['ProductName'] = productName;
    data['ProductSeaName'] = productSeaName;
    return data;
  }
}

class ProductReview {
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
  int? id;

  ProductReview(
      {this.customerId,
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
      this.id});

  ProductReview.fromJson(Map<String, dynamic> json) {
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
    data['Id'] = id;
    return data;
  }
}
