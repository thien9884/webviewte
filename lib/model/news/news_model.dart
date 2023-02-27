class NewsModel {
  int? httpStatusCode;
  bool? success;
  dynamic message;
  Data? data;
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
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
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

class Data {
  int? workingLanguageId;
  List<LatestNews>? latestNews;
  List<NewsGroup>? newsGroup;
  int? id;

  Data({this.workingLanguageId, this.latestNews, this.newsGroup, this.id});

  Data.fromJson(Map<String, dynamic> json) {
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
  dynamic comments;
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
      this.comments,
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

class NewsGroup {
  String? name;
  bool? showOnNews;
  int? displayOrder;
  bool? showOnTopMenu;
  String? seName;
  List<NewsItems>? newsItems;
  int? id;

  NewsGroup(
      {this.name,
      this.showOnNews,
      this.displayOrder,
      this.showOnTopMenu,
      this.seName,
      this.newsItems,
      this.id});

  NewsGroup.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    showOnNews = json['ShowOnNews'];
    displayOrder = json['DisplayOrder'];
    showOnTopMenu = json['ShowOnTopMenu'];
    seName = json['SeName'];
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
    if (newsItems != null) {
      data['NewsItems'] = newsItems!.map((v) => v.toJson()).toList();
    }
    data['Id'] = id;
    return data;
  }
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
  dynamic comments;
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
      this.comments,
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
    if (comments != null) {
      data['Comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (addNewComment != null) {
      data['AddNewComment'] = addNewComment!.toJson();
    }
    data['Id'] = id;
    return data;
  }
}
