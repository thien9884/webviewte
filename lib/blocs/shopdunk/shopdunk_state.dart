import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/category_model/category_group_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/news_category/news_category_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';
import 'package:webviewtest/model/subcategory/subcategory_model.dart';

abstract class ShopdunkState extends Equatable {
  const ShopdunkState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class CategoriesInitial extends ShopdunkState {
  const CategoriesInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class NewsLoading extends ShopdunkState {
  const NewsLoading();
}

class NewsLoaded extends ShopdunkState {
  final NewsData newsData;

  const NewsLoaded({required this.newsData});

  @override
  List<Object?> get props => [newsData];
}

class NewsLoadError extends ShopdunkState {
  final String message;

  const NewsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RelatedNewsLoading extends ShopdunkState {
  const RelatedNewsLoading();
}

class RelatedNewsLoaded extends ShopdunkState {
  final RelatedNews newsData;

  const RelatedNewsLoaded({required this.newsData});

  @override
  List<Object?> get props => [newsData];
}

class RelatedNewsLoadError extends ShopdunkState {
  final String message;

  const RelatedNewsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

// GET CATEGORIES STATES
class NewsCommentsLoading extends ShopdunkState {
  const NewsCommentsLoading();
}

class NewsCommentsLoaded extends ShopdunkState {
  final NewsCommentResponseModel newsCommentResponseModel;

  const NewsCommentsLoaded({required this.newsCommentResponseModel});

  @override
  List<Object?> get props => [newsCommentResponseModel];
}

class NewsCommentsLoadError extends ShopdunkState {
  final String message;

  const NewsCommentsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

// GET CATEGORIES STATES
class CategoriesLoading extends ShopdunkState {
  const CategoriesLoading();
}

class CategoriesLoaded extends ShopdunkState {
  final List<Categories> categories;

  const CategoriesLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoriesLoadError extends ShopdunkState {
  final String message;

  const CategoriesLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class IpadLoading extends ShopdunkState {
  const IpadLoading();
}

class IpadLoaded extends ShopdunkState {
  final List<ProductsModel> ipad;

  const IpadLoaded({required this.ipad});

  @override
  List<Object?> get props => [ipad];
}

class IpadLoadError extends ShopdunkState {
  final String message;

  const IpadLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class IphoneLoading extends ShopdunkState {
  const IphoneLoading();
}

class IphoneLoaded extends ShopdunkState {
  final List<ProductsModel> iphone;

  const IphoneLoaded({required this.iphone});

  @override
  List<Object?> get props => [iphone];
}

class IphoneLoadError extends ShopdunkState {
  final String message;

  const IphoneLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MacLoading extends ShopdunkState {
  const MacLoading();
}

class MacLoaded extends ShopdunkState {
  final List<ProductsModel> mac;

  const MacLoaded({required this.mac});

  @override
  List<Object?> get props => [mac];
}

class MacLoadError extends ShopdunkState {
  final String message;

  const MacLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AppleWatchLoading extends ShopdunkState {
  const AppleWatchLoading();
}

class AppleWatchLoaded extends ShopdunkState {
  final List<ProductsModel> watch;

  const AppleWatchLoaded({required this.watch});

  @override
  List<Object?> get props => [watch];
}

class AppleWatchLoadError extends ShopdunkState {
  final String message;

  const AppleWatchLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SoundLoading extends ShopdunkState {
  const SoundLoading();
}

class SoundLoaded extends ShopdunkState {
  final List<ProductsModel> sound;

  const SoundLoaded({required this.sound});

  @override
  List<Object?> get props => [sound];
}

class SoundLoadError extends ShopdunkState {
  final String message;

  const SoundLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AccessoriesLoading extends ShopdunkState {
  const AccessoriesLoading();
}

class AccessoriesLoaded extends ShopdunkState {
  final List<ProductsModel> accessories;

  const AccessoriesLoaded({required this.accessories});

  @override
  List<Object?> get props => [accessories];
}

class AccessoriesLoadError extends ShopdunkState {
  final String message;

  const AccessoriesLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SearchProductsLoading extends ShopdunkState {
  const SearchProductsLoading();
}

class SearchProductsLoaded extends ShopdunkState {
  final CatalogProductsModel catalogProductsModel;

  const SearchProductsLoaded({required this.catalogProductsModel});

  @override
  List<Object?> get props => [catalogProductsModel];
}

class SearchProductsLoadError extends ShopdunkState {
  final String message;

  const SearchProductsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class HideBottomSuccess extends ShopdunkState {
  final bool isHide;

  const HideBottomSuccess({required this.isHide});

  @override
  List<Object?> get props => [isHide];
}

class HideBottomError extends ShopdunkState {
  final String? message;

  const HideBottomError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NewsCategoryLoading extends ShopdunkState {
  const NewsCategoryLoading();
}

class NewsCategoryLoaded extends ShopdunkState {
  final NewsCategoryModel newsCategoryModel;

  const NewsCategoryLoaded({required this.newsCategoryModel});

  @override
  List<Object?> get props => [newsCategoryModel];
}

class NewsCategoryLoadError extends ShopdunkState {
  final String message;

  const NewsCategoryLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductsCategoryLoading extends ShopdunkState {
  const ProductsCategoryLoading();
}

class ProductsCategoryLoaded extends ShopdunkState {
  final CategoryGroupModel categoryGroupModel;

  const ProductsCategoryLoaded({required this.categoryGroupModel});

  @override
  List<Object?> get props => [categoryGroupModel];
}

class ProductsCategoryLoadError extends ShopdunkState {
  final String message;

  const ProductsCategoryLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TopBannerLoading extends ShopdunkState {
  const TopBannerLoading();
}

class TopBannerLoaded extends ShopdunkState {
  final BannerModel listTopics;

  const TopBannerLoaded({required this.listTopics});

  @override
  List<Object?> get props => [listTopics];
}

class TopBannerLoadError extends ShopdunkState {
  final String message;

  const TopBannerLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class HomeBannerLoading extends ShopdunkState {
  const HomeBannerLoading();
}

class HomeBannerLoaded extends ShopdunkState {
  final BannerModel listTopics;

  const HomeBannerLoaded({required this.listTopics});

  @override
  List<Object?> get props => [listTopics];
}

class HomeBannerLoadError extends ShopdunkState {
  final String message;

  const HomeBannerLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CategoryBannerLoading extends ShopdunkState {
  const CategoryBannerLoading();
}

class CategoryBannerLoaded extends ShopdunkState {
  final BannerModel listTopics;

  const CategoryBannerLoaded({required this.listTopics});

  @override
  List<Object?> get props => [listTopics];
}

class CategoryBannerLoadError extends ShopdunkState {
  final String message;

  const CategoryBannerLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SubCategoryLoading extends ShopdunkState {
  const SubCategoryLoading();
}

class SubCategoryLoaded extends ShopdunkState {
  final List<SubCategories>? subCategory;

  const SubCategoryLoaded({required this.subCategory});

  @override
  List<Object?> get props => [subCategory];
}

class SubCategoryLoadError extends ShopdunkState {
  final String message;

  const SubCategoryLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
