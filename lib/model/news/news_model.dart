import 'dart:convert';

class NewsModel {
  int? httpStatusCode;
  bool? success;
  dynamic message;
  NewsData? data;
  int? total;
  int? totalDone;
  int? totalNotDone;
  int? totalLock;
  int? totalFilter;
  dynamic objectCount;

  NewsModel(
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

  NewsModel.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['HttpStatusCode'];
    success = json['Success'];
    message = json['Message'];
    data = json['Data'] != null ? NewsData.fromJson(json['Data']) : null;
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

class NewsData {
  int? workingLanguageId;
  List<LatestNews>? latestNews;
  List<NewsGroup>? newsGroup;
  int? id;

  NewsData({this.workingLanguageId, this.latestNews, this.newsGroup, this.id});

  NewsData.fromJson(Map<String, dynamic> json) {
    workingLanguageId = json['WorkingLanguageId'];
    if (json['LatestNews'] != null) {
      latestNews = <LatestNews>[];
      json['LatestNews'].forEach((v) {
        latestNews!.add(LatestNews.fromJson(v));
      });
    }
    if (json['NewsGroup'] != null) {
      newsGroup = <NewsGroup>[];
      json['NewsGroup'].forEach((v) {
        newsGroup!.add(NewsGroup.fromJson(v));
      });
    }
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['WorkingLanguageId'] = workingLanguageId;
    if (latestNews != null) {
      data['LatestNews'] = latestNews!.map((v) => v.toJson()).toList();
    }
    if (newsGroup != null) {
      data['NewsGroup'] = newsGroup!.map((v) => v.toJson()).toList();
    }
    data['Id'] = id;
    return data;
  }
}

class LatestNews {
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String? seName;
  String? title;
  String? short;
  String? full;
  bool? allowComments;
  bool? preventNotRegisteredUsersToLeaveComments;
  int? numberOfComments;
  String? createdOn;
  PictureModel? pictureModel;
  List<NewsComments>? newsComments;
  AddNewComment? addNewComment;
  int? id;

  LatestNews(
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
      this.newsComments,
      this.addNewComment,
      this.id});

  LatestNews.fromJson(Map<String, dynamic> json) {
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
    if (json['Comments'] != null) {
      newsComments = <NewsComments>[];
      json['Comments'].forEach((v) {
        newsComments!.add(NewsComments.fromJson(v));
      });
    }
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
    if (newsComments != null) {
      data['Comments'] = newsComments!.map((v) => v.toJson()).toList();
    }
    if (addNewComment != null) {
      data['AddNewComment'] = addNewComment!.toJson();
    }
    data['Id'] = id;
    return data;
  }

  static List<LatestNews> decode(String latestNews) =>
      (json.decode(latestNews) as List<dynamic>)
          .map<LatestNews>((item) => LatestNews.fromJson(item))
          .toList();
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

class NewsComments {
  int? customerId;
  String? customerName;
  String? customerAvatarUrl;
  String? commentTitle;
  String? commentText;
  String? createdOn;
  bool? allowViewingProfiles;
  int? id;

  NewsComments(
      {this.customerId,
      this.customerName,
      this.customerAvatarUrl,
      this.commentTitle,
      this.commentText,
      this.createdOn,
      this.allowViewingProfiles,
      this.id});

  NewsComments.fromJson(Map<String, dynamic> json) {
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    customerAvatarUrl = json['CustomerAvatarUrl'];
    commentTitle = json['CommentTitle'];
    commentText = json['CommentText'];
    createdOn = json['CreatedOn'];
    allowViewingProfiles = json['AllowViewingProfiles'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerId'] = customerId;
    data['CustomerName'] = customerName;
    data['CustomerAvatarUrl'] = customerAvatarUrl;
    data['CommentTitle'] = commentTitle;
    data['CommentText'] = commentText;
    data['CreatedOn'] = createdOn;
    data['AllowViewingProfiles'] = allowViewingProfiles;
    data['Id'] = id;
    return data;
  }

  static List<NewsComments> decode(String newsComments) =>
      (json.decode(newsComments) as List<dynamic>)
          .map<NewsComments>((item) => NewsComments.fromJson(item))
          .toList();
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

class NewsGroup {
  String? name;
  bool? showOnNews;
  int? displayOrder;
  bool? showOnTopMenu;
  String? seName;
  String? icon;
  List<NewsItems>? newsItems;
  int? id;

  NewsGroup(
      {this.name,
      this.showOnNews,
      this.displayOrder,
      this.showOnTopMenu,
      this.seName,
      this.icon,
      this.newsItems,
      this.id});

  NewsGroup.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    showOnNews = json['ShowOnNews'];
    displayOrder = json['DisplayOrder'];
    showOnTopMenu = json['ShowOnTopMenu'];
    seName = json['SeName'];
    icon = json['Icon'];
    if (json['NewsItems'] != null) {
      newsItems = <NewsItems>[];
      json['NewsItems'].forEach((v) {
        newsItems!.add(NewsItems.fromJson(v));
      });
    }
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['ShowOnNews'] = showOnNews;
    data['DisplayOrder'] = displayOrder;
    data['ShowOnTopMenu'] = showOnTopMenu;
    data['SeName'] = seName;
    data['Icon'] = icon;
    if (newsItems != null) {
      data['NewsItems'] = newsItems!.map((v) => v.toJson()).toList();
    }
    data['Id'] = id;
    return data;
  }

  static List<NewsGroup> decode(String newsGroup) =>
      (json.decode(newsGroup) as List<dynamic>)
          .map<NewsGroup>((item) => NewsGroup.fromJson(item))
          .toList();
}

class NewsItems {
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String? seName;
  String? title;
  String? short;
  String? full;
  bool? allowComments;
  bool? preventNotRegisteredUsersToLeaveComments;
  int? numberOfComments;
  String? createdOn;
  PictureModel? pictureModel;
  List<NewsComments>? newsComments;
  AddNewComment? addNewComment;
  int? id;

  NewsItems(
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
      this.newsComments,
      this.addNewComment,
      this.id});

  NewsItems.fromJson(Map<String, dynamic> json) {
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
    if (json['Comments'] != null) {
      newsComments = <NewsComments>[];
      json['Comments'].forEach((v) {
        newsComments!.add(NewsComments.fromJson(v));
      });
    }
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
    if (newsComments != null) {
      data['Comments'] = newsComments!.map((v) => v.toJson()).toList();
    }
    if (addNewComment != null) {
      data['AddNewComment'] = addNewComment!.toJson();
    }
    data['Id'] = id;
    return data;
  }

  static List<NewsItems> decode(String newsItem) =>
      (json.decode(newsItem) as List<dynamic>)
          .map<NewsItems>((item) => NewsItems.fromJson(item))
          .toList();
}
