import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';

abstract class RelatedNewsEvent extends Equatable {
  const RelatedNewsEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetRelatedNews extends RelatedNewsEvent {
  final int? newsId;

  const RequestGetRelatedNews(this.newsId);

  @override
  List<Object?> get props => [];
}

class RequestPostNewsComment extends RelatedNewsEvent {
  final int? newsId;
  final NewsCommentModel? newsCommentModel;

  const RequestPostNewsComment(
    this.newsId,
    this.newsCommentModel,
  );

  @override
  List<Object?> get props => [];
}
