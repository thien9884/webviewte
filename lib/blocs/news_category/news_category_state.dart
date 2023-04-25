import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/news_category/news_category_model.dart';

abstract class NewsCategoryState extends Equatable {
  const NewsCategoryState();

  @override
  List<Object?> get props => [];
}

class NewsCategoryInitial extends NewsCategoryState {
  const NewsCategoryInitial();

  @override
  List<Object?> get props => [];
}

class NewsCategoryLoading extends NewsCategoryState {
  const NewsCategoryLoading();
}

class NewsCategoryLoaded extends NewsCategoryState {
  final NewsCategoryModel newsCategoryModel;

  const NewsCategoryLoaded({required this.newsCategoryModel});

  @override
  List<Object?> get props => [newsCategoryModel];
}

class NewsCategoryLoadError extends NewsCategoryState {
  final String message;

  const NewsCategoryLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
