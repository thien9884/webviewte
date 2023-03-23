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