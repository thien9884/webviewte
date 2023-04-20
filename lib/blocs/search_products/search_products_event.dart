import 'package:equatable/equatable.dart';

abstract class SearchProductsEvent extends Equatable {
  const SearchProductsEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetSearchProductResult extends SearchProductsEvent {
  final int? pageNumber;
  final String? keySearch;

  const RequestGetSearchProductResult(
    this.pageNumber,
    this.keySearch,
  );

  @override
  List<Object?> get props => [];
}
