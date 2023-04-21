import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/product/products_model.dart';

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
class NewsLoading extends CategoriesState {
  const NewsLoading();
}

class NewsLoaded extends CategoriesState {
  final NewsData newsData;
  const NewsLoaded({required this.newsData});

  @override
  List<Object?> get props => [newsData];
}

class NewsLoadError extends CategoriesState {
  final String message;
  const NewsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
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

class IpadLoading extends CategoriesState {
  const IpadLoading();
}

class IpadLoaded extends CategoriesState {
  final List<ProductsModel> ipad;
  const IpadLoaded({required this.ipad});

  @override
  List<Object?> get props => [ipad];
}

class IpadLoadError extends CategoriesState {
  final String message;
  const IpadLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class IphoneLoading extends CategoriesState {
  const IphoneLoading();
}

class IphoneLoaded extends CategoriesState {
  final List<ProductsModel> iphone;
  const IphoneLoaded({required this.iphone});

  @override
  List<Object?> get props => [iphone];
}

class IphoneLoadError extends CategoriesState {
  final String message;
  const IphoneLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MacLoading extends CategoriesState {
  const MacLoading();
}

class MacLoaded extends CategoriesState {
  final List<ProductsModel> mac;
  const MacLoaded({required this.mac});

  @override
  List<Object?> get props => [mac];
}

class MacLoadError extends CategoriesState {
  final String message;
  const MacLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AppleWatchLoading extends CategoriesState {
  const AppleWatchLoading();
}

class AppleWatchLoaded extends CategoriesState {
  final List<ProductsModel> watch;
  const AppleWatchLoaded({required this.watch});

  @override
  List<Object?> get props => [watch];
}

class AppleWatchLoadError extends CategoriesState {
  final String message;
  const AppleWatchLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SoundLoading extends CategoriesState {
  const SoundLoading();
}

class SoundLoaded extends CategoriesState {
  final List<ProductsModel> sound;
  const SoundLoaded({required this.sound});

  @override
  List<Object?> get props => [sound];
}

class SoundLoadError extends CategoriesState {
  final String message;
  const SoundLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AccessoriesLoading extends CategoriesState {
  const AccessoriesLoading();
}

class AccessoriesLoaded extends CategoriesState {
  final List<ProductsModel> accessories;
  const AccessoriesLoaded({required this.accessories});

  @override
  List<Object?> get props => [accessories];
}

class AccessoriesLoadError extends CategoriesState {
  final String message;
  const AccessoriesLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}