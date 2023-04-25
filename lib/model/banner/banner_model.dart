class BannerModel {
  List<Topics>? topics;

  BannerModel({this.topics});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String? systemName;
  bool? includeInSitemap;
  bool? includeInTopMenu;
  bool? includeInFooterColumn1;
  bool? includeInFooterColumn2;
  bool? includeInFooterColumn3;
  int? displayOrder;
  bool? accessibleWhenStoreClosed;
  bool? isPasswordProtected;
  dynamic password;
  dynamic title;
  String? body;
  bool? published;
  int? topicTemplateId;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  bool? subjectToAcl;
  bool? limitedToStores;
  int? id;

  Topics(
      {this.systemName,
      this.includeInSitemap,
      this.includeInTopMenu,
      this.includeInFooterColumn1,
      this.includeInFooterColumn2,
      this.includeInFooterColumn3,
      this.displayOrder,
      this.accessibleWhenStoreClosed,
      this.isPasswordProtected,
      this.password,
      this.title,
      this.body,
      this.published,
      this.topicTemplateId,
      this.metaKeywords,
      this.metaDescription,
      this.metaTitle,
      this.subjectToAcl,
      this.limitedToStores,
      this.id});

  Topics.fromJson(Map<String, dynamic> json) {
    systemName = json['system_name'];
    includeInSitemap = json['include_in_sitemap'];
    includeInTopMenu = json['include_in_top_menu'];
    includeInFooterColumn1 = json['include_in_footer_column1'];
    includeInFooterColumn2 = json['include_in_footer_column2'];
    includeInFooterColumn3 = json['include_in_footer_column3'];
    displayOrder = json['display_order'];
    accessibleWhenStoreClosed = json['accessible_when_store_closed'];
    isPasswordProtected = json['is_password_protected'];
    password = json['password'];
    title = json['title'];
    body = json['body'];
    published = json['published'];
    topicTemplateId = json['topic_template_id'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    metaTitle = json['meta_title'];
    subjectToAcl = json['subject_to_acl'];
    limitedToStores = json['limited_to_stores'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['system_name'] = systemName;
    data['include_in_sitemap'] = includeInSitemap;
    data['include_in_top_menu'] = includeInTopMenu;
    data['include_in_footer_column1'] = includeInFooterColumn1;
    data['include_in_footer_column2'] = includeInFooterColumn2;
    data['include_in_footer_column3'] = includeInFooterColumn3;
    data['display_order'] = displayOrder;
    data['accessible_when_store_closed'] = accessibleWhenStoreClosed;
    data['is_password_protected'] = isPasswordProtected;
    data['password'] = password;
    data['title'] = title;
    data['body'] = body;
    data['published'] = published;
    data['topic_template_id'] = topicTemplateId;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['meta_title'] = metaTitle;
    data['subject_to_acl'] = subjectToAcl;
    data['limited_to_stores'] = limitedToStores;
    data['id'] = id;
    return data;
  }
}
