import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';

abstract class RelatedNewsState extends Equatable {
  const RelatedNewsState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class RelatedNewsInitial extends RelatedNewsState {
  const RelatedNewsInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class RelatedNewsLoading extends RelatedNewsState {
  const RelatedNewsLoading();
}

class RelatedNewsLoaded extends RelatedNewsState {
  final RelatedNews newsData;

  const RelatedNewsLoaded({required this.newsData});

  @override
  List<Object?> get props => [newsData];
}

class RelatedNewsLoadError extends RelatedNewsState {
  final String message;

  const RelatedNewsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

// GET CATEGORIES STATES
class NewsCommentsLoading extends RelatedNewsState {
  const NewsCommentsLoading();
}

class NewsCommentsLoaded extends RelatedNewsState {
  final NewsCommentResponseModel newsCommentResponseModel;

  const NewsCommentsLoaded({required this.newsCommentResponseModel});

  @override
  List<Object?> get props => [newsCommentResponseModel];
}

class NewsCommentsLoadError extends RelatedNewsState {
  final String message;

  const NewsCommentsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
