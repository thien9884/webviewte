import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';

abstract class SearchProductsState extends Equatable {
  const SearchProductsState();

  @override
  List<Object?> get props => [];
}

class SearchProductsInitial extends SearchProductsState {
  const SearchProductsInitial();

  @override
  List<Object?> get props => [];
}

class SearchProductsLoading extends SearchProductsState {
  const SearchProductsLoading();
}

class SearchProductsLoaded extends SearchProductsState {
  final CatalogProductsModel catalogProductsModel;

  const SearchProductsLoaded({required this.catalogProductsModel});

  @override
  List<Object?> get props => [catalogProductsModel];
}

class SearchProductsLoadError extends SearchProductsState {
  final String message;

  const SearchProductsLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
