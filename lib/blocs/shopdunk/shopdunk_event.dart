import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';

abstract class ShopdunkEvent extends Equatable {
  const ShopdunkEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetNews extends ShopdunkEvent {
  const RequestGetNews();

  @override
  List<Object?> get props => [];
}

class RequestGetCategories extends ShopdunkEvent {
  const RequestGetCategories();

  @override
  List<Object?> get props => [];
}

class RequestGetIpad extends ShopdunkEvent {
  final int? idIpad;

  const RequestGetIpad({required this.idIpad});

  @override
  List<Object?> get props => [];
}

class RequestGetIphone extends ShopdunkEvent {
  final int? idIphone;

  const RequestGetIphone({required this.idIphone});

  @override
  List<Object?> get props => [];
}

class RequestGetMac extends ShopdunkEvent {
  final int? idMac;

  const RequestGetMac({required this.idMac});

  @override
  List<Object?> get props => [];
}

class RequestGetAppleWatch extends ShopdunkEvent {
  final int? idWatch;

  const RequestGetAppleWatch({required this.idWatch});

  @override
  List<Object?> get props => [];
}

class RequestGetSound extends ShopdunkEvent {
  final int? idSound;

  const RequestGetSound({required this.idSound});

  @override
  List<Object?> get props => [];
}

class RequestGetAccessories extends ShopdunkEvent {
  final int? idAccessories;

  const RequestGetAccessories({required this.idAccessories});

  @override
  List<Object?> get props => [];
}

class RequestGetSearchProductResult extends ShopdunkEvent {
  final int? pageNumber;
  final String? keySearch;

  const RequestGetSearchProductResult(
    this.pageNumber,
    this.keySearch,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetHideBottom extends ShopdunkEvent {
  final bool? isHide;

  const RequestGetHideBottom(
    this.isHide,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetRelatedNews extends ShopdunkEvent {
  final int? newsId;

  const RequestGetRelatedNews(this.newsId);

  @override
  List<Object?> get props => [];
}

class RequestPostNewsComment extends ShopdunkEvent {
  final int? newsId;
  final NewsCommentModel? newsCommentModel;

  const RequestPostNewsComment(
    this.newsId,
    this.newsCommentModel,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetNewsCategory extends ShopdunkEvent {
  final int? groupId;
  final int? pageNumber;

  const RequestGetNewsCategory(
    this.groupId,
    this.pageNumber,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetProductsCategory extends ShopdunkEvent {
  final int? groupId;
  final int? pageNumber;

  const RequestGetProductsCategory(
    this.groupId,
    this.pageNumber,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetTopBanner extends ShopdunkEvent {
  final int? bannerId;

  const RequestGetTopBanner(
    this.bannerId,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetHomeBanner extends ShopdunkEvent {
  final int? bannerId;

  const RequestGetHomeBanner(
    this.bannerId,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetCategoryBanner extends ShopdunkEvent {
  final int? bannerId;

  const RequestGetCategoryBanner(
    this.bannerId,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetSubCategory extends ShopdunkEvent {
  final int? categoryId;

  const RequestGetSubCategory(
    this.categoryId,
  );

  @override
  List<Object?> get props => [];
}
