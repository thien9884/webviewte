class NewsCommentModel {
  int? id;
  int? customerId;
  String? customerName;
  String? customerAvatarUrl;
  String? commentTitle;
  String? commentText;
  String? createOn;
  bool allowViewingProfiles = true;

  NewsCommentModel({
    this.id,
    this.customerId,
    this.customerName,
    this.customerAvatarUrl,
    this.commentTitle,
    this.commentText,
    this.createOn,
    this.allowViewingProfiles = true,
  });

  NewsCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    customerAvatarUrl = json['CustomerAvatarUrl'];
    commentTitle = json['CommentTitle'];
    commentText = json['CommentText'];
    createOn = json['CreatedOn'];
    allowViewingProfiles = json['AllowViewingProfiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CustomerId'] = customerId;
    data['CustomerName'] = customerName;
    data['CustomerAvatarUrl'] = customerAvatarUrl;
    data['CommentTitle'] = commentTitle;
    data['CommentText'] = commentText;
    data['CreatedOn'] = createOn;
    data['AllowViewingProfiles'] = allowViewingProfiles;
    return data;
  }
}

class NewsCommentResponseModel {
  int? httpStatusCode;
  bool? success;
  dynamic message;
  DataComments? data;
  int? total;
  int? totalDone;
  int? totalNotDone;
  int? totalLock;
  int? totalFilter;
  dynamic objectCount;

  NewsCommentResponseModel(
      {this.httpStatusCode,
      this.success,
      this.message,
      this.data,
      this.total,
      this.totalDone,
      this.totalNotDone,
      this.totalLock,
      this.totalFilter,
      this.objectCount});

  NewsCommentResponseModel.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['HttpStatusCode'];
    success = json['Success'];
    message = json['Message'];
    data = json['Data'] != null ? DataComments.fromJson(json['Data']) : null;
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

class DataComments {
  String? seName;
  String? message;

  DataComments({this.seName, this.message});

  DataComments.fromJson(Map<String, dynamic> json) {
    seName = json['SeName'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SeName'] = seName;
    data['Message'] = message;
    return data;
  }
}
