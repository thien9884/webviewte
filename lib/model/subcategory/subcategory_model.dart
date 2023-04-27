class SubCategories {
  String? name;
  String? seName;
  dynamic description;
  PictureModel? pictureModel;
  dynamic featuredProducts;
  bool? isShowCustomColumn;
  dynamic customColumnHeader1;
  dynamic customColumnHeader2;
  dynamic customColumnHeader3;
  int? id;

  SubCategories({
    this.name,
    this.seName,
    this.description,
    this.pictureModel,
    this.featuredProducts,
    this.isShowCustomColumn,
    this.customColumnHeader1,
    this.customColumnHeader2,
    this.customColumnHeader3,
    this.id,
  });

  SubCategories.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    seName = json['SeName'];
    description = json['Description'];
    pictureModel = json['PictureModel'] != null
        ? PictureModel.fromJson(json['PictureModel'])
        : null;
    featuredProducts = json['FeaturedProducts'];
    isShowCustomColumn = json['IsShowCustomColumn'];
    customColumnHeader1 = json['CustomColumnHeader1'];
    customColumnHeader2 = json['CustomColumnHeader2'];
    customColumnHeader3 = json['CustomColumnHeader3'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['SeName'] = seName;
    data['Description'] = description;
    if (pictureModel != null) {
      data['PictureModel'] = pictureModel!.toJson();
    }
    data['FeaturedProducts'] = featuredProducts;
    data['IsShowCustomColumn'] = isShowCustomColumn;
    data['CustomColumnHeader1'] = customColumnHeader1;
    data['CustomColumnHeader2'] = customColumnHeader2;
    data['CustomColumnHeader3'] = customColumnHeader3;
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
