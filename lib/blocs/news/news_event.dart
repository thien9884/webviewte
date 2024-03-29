import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetNews extends NewsEvent {
  const RequestGetNews();

  @override
  List<Object?> get props => [];
}

class RequestGetRelatedNews extends NewsEvent {
  const RequestGetRelatedNews();

  @override
  List<Object?> get props => [];
}

class RequestGetHideBottom extends NewsEvent {
  final bool? isHide;

  const RequestGetHideBottom(
      this.isHide,
      );

  @override
  List<Object?> get props => [];
}
