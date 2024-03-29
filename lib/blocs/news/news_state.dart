import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/news/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class NewsInitial extends NewsState {
  const NewsInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final NewsData newsData;
  const NewsLoaded({required this.newsData});

  @override
  List<Object?> get props => [newsData];
}

class NewsLoadError extends NewsState {
  final String message;
  const NewsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

// GET CATEGORIES STATES
class RelatedNewsLoading extends NewsState {
  const RelatedNewsLoading();
}

class RelatedNewsLoaded extends NewsState {
  final NewsData newsData;
  const RelatedNewsLoaded({required this.newsData});

  @override
  List<Object?> get props => [newsData];
}

class RelatedNewsLoadError extends NewsState {
  final String message;
  const RelatedNewsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class HideBottomSuccess extends NewsState {
  final bool isHide;

  const HideBottomSuccess({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}

class HideBottomError extends NewsState {
  final String? message;

  const HideBottomError({required this.message});

  @override
  List<Object?> get props => [message];
}
