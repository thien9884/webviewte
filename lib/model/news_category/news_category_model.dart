import 'package:webviewtest/model/news/news_model.dart';

class NewsCategoryModel {
  int? httpStatusCode;
  bool? success;
  dynamic message;
  List<NewsItems>? newsCategoryData;
  int? total;
  int? totalDone;
  int? totalNotDone;
  int? totalLock;
  int? totalFilter;
  dynamic objectCount;

  NewsCategoryModel(
      {this.httpStatusCode,
        this.success,
        this.message,
        this.newsCategoryData,
        this.total,
        this.totalDone,
        this.totalNotDone,
        this.totalLock,
        this.totalFilter,
        this.objectCount});

  NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['HttpStatusCode'];
    success = json['Success'];
    message = json['Message'];
    if (json['Data'] != null) {
      newsCategoryData = <NewsItems>[];
      json['Data'].forEach((v) {
        newsCategoryData!.add(NewsItems.fromJson(v));
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
    if (newsCategoryData != null) {
      data['Data'] = newsCategoryData!.map((v) => v.toJson()).toList();
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

class NewsCategoryData {
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
  List<Null>? comments;
  AddNewComment? addNewComment;
  int? id;

  NewsCategoryData(
      {this.metaKeywords,
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
        this.id});

  NewsCategoryData.fromJson(Map<String, dynamic> json) {
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

  PictureModel(
      {this.imageUrl,
        this.thumbImageUrl,
        this.fullSizeImageUrl,
        this.title,
        this.alternateText});

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

  AddNewComment(
      {this.commentTitle, this.commentText, this.displayCaptcha, this.id});

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
