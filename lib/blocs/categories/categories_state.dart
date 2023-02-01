import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/category_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  final List<Categories> categories;
  const CategoriesLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoriesLoadError extends CategoriesState {
  final String message;
  const CategoriesLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}