import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/categories/categories_event.dart';
import 'package:webviewtest/blocs/categories/categories_state.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/services/api_call.dart';

class CategoriesBloc extends BaseBloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesInitial()) {
    // GET NEWS EVENT
    on<RequestGetNews>((event, emit) => _handleGetNews(event, emit));

    // GET CATEGORIES EVENT
    on<RequestGetCategories>(
        (event, emit) => _handleGetCategories(event, emit));

    on<RequestGetIpad>((event, emit) async {
      int? id = event.idIpad;
      await _handleGetListIpad(emit, id);
    });

    on<RequestGetIphone>((event, emit) async {
      int? id = event.idIphone;
      await _handleGetListIphone(emit, id);
    });

    on<RequestGetMac>((event, emit) async {
      int? id = event.idMac;
      await _handleGetListMac(emit, id);
    });

    on<RequestGetAppleWatch>((event, emit) async {
      int? id = event.idWatch;
      await _handleGetListAppleWatch(emit, id);
    });

    on<RequestGetSound>((event, emit) async {
      int? id = event.idSound;
      await _handleGetListSound(emit, id);
    });

    on<RequestGetAccessories>((event, emit) async {
      int? id = event.idAccessories;
      await _handleGetListAccessories(emit, id);
    });
  }

  _handleGetNews(RequestGetNews event, Emitter emit) async {
    emit(const NewsLoading());
    try {
      final data = await ApiCall().requestGetNews();
      emit(
        NewsLoaded(newsData: data ?? NewsData()),
      );
    } catch (e) {
      emit(
        NewsLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  // Handle get categories
  _handleGetCategories(RequestGetCategories event, Emitter emit) async {
    emit(const CategoriesLoading());
    try {
      final categoriesResponse = await ApiCall().requestGetCategories();
      emit(CategoriesLoaded(categories: categoriesResponse));
    } catch (e) {
      emit(CategoriesLoadError(message: handleError(e)));
    }
  }

  _handleGetListIpad(Emitter<CategoriesState> emit, int? id) async {
    emit(const IpadLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(IpadLoaded(ipad: productsResponse));
    } catch (e) {
      emit(IpadLoadError(message: handleError(e)));
    }
  }

  _handleGetListIphone(Emitter<CategoriesState> emit, int? id) async {
    emit(const IphoneLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(IphoneLoaded(iphone: productsResponse));
    } catch (e) {
      emit(IphoneLoadError(message: handleError(e)));
    }
  }

  _handleGetListMac(Emitter<CategoriesState> emit, int? id) async {
    emit(const MacLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(MacLoaded(mac: productsResponse));
    } catch (e) {
      emit(MacLoadError(message: handleError(e)));
    }
  }

  _handleGetListAppleWatch(Emitter<CategoriesState> emit, int? id) async {
    emit(const AppleWatchLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(AppleWatchLoaded(watch: productsResponse));
    } catch (e) {
      emit(AppleWatchLoadError(message: handleError(e)));
    }
  }

  _handleGetListSound(Emitter<CategoriesState> emit, int? id) async {
    emit(const SoundLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(SoundLoaded(sound: productsResponse));
    } catch (e) {
      emit(SoundLoadError(message: handleError(e)));
    }
  }

  _handleGetListAccessories(Emitter<CategoriesState> emit, int? id) async {
    emit(const AccessoriesLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(AccessoriesLoaded(accessories: productsResponse));
    } catch (e) {
      emit(AccessoriesLoadError(message: handleError(e)));
    }
  }
}
