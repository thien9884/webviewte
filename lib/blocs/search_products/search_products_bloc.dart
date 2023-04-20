import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/search_products/search_products_event.dart';
import 'package:webviewtest/blocs/search_products/search_products_state.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';
import 'package:webviewtest/services/api_call.dart';

class SearchProductsBloc
    extends BaseBloc<SearchProductsEvent, SearchProductsState> {
  SearchProductsBloc() : super(const SearchProductsInitial()) {
    // GET NEWS EVENT
    on<RequestGetSearchProductResult>((event, emit) {
      int? pageNumber = event.pageNumber;
      String? keyValue = event.keySearch;
      return _handleGetRelatedNews(
        emit,
        pageNumber,
        keyValue,
      );
    });
  }

  _handleGetRelatedNews(
    Emitter<SearchProductsState> emit,
    int? pageNumber,
    String? keyValue,
  ) async {
    emit(const SearchProductsLoading());
    try {
      final data =
          await ApiCall().requestGetSearchProduct(pageNumber, keyValue);
      emit(
        SearchProductsLoaded(
          catalogProductsModel: data ?? CatalogProductsModel(),
        ),
      );
    } catch (e) {
      emit(
        SearchProductsLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
