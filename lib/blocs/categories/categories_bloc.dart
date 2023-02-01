import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/categories/categories_event.dart';
import 'package:webviewtest/blocs/categories/categories_state.dart';
import 'package:webviewtest/services/api_call.dart';

class CategoriesBloc extends BaseBloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesInitial()) {
    // GET CATEGORIES EVENT
    on<RequestGetCategories>((event, emit) => _handleGetCategories(event, emit));
  }

  // Handle get categories
  _handleGetCategories(RequestGetCategories event, Emitter emit) async {
    emit(const CategoriesLoading());
    try {
      final response = await ApiCall().requestGetCategories();
      emit(CategoriesLoaded(categories: response));
    } catch (e) {
      emit(CategoriesLoadError(message: handleError(e)));
    }
  }
}