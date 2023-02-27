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
  final List<NewsGroup> newGroup;
  const NewsLoaded({required this.newGroup});

  @override
  List<Object?> get props => [newGroup];
}

class NewsLoadError extends NewsState {
  final String message;
  const NewsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}