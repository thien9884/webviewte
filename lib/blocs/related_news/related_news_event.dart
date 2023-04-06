import 'package:equatable/equatable.dart';

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
