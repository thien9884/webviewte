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
