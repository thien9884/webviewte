import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/model/category_model/category_group_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/news_category/news_category_model.dart';
import 'package:webviewtest/model/related_news_model/comment_model.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/model/search_products/search_products_model.dart';
import 'package:webviewtest/services/api_call.dart';

class ShopdunkBloc extends BaseBloc<ShopdunkEvent, ShopdunkState> {
  ShopdunkBloc() : super(const CategoriesInitial()) {
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

    // GET NEWS EVENT
    on<RequestGetSearchProductResult>((event, emit) {
      int? pageNumber = event.pageNumber;
      String? keyValue = event.keySearch;
      return _handleGetSearchProductsResult(
        emit,
        pageNumber,
        keyValue,
      );
    });

    // GET HIDE BOTTOM
    on<RequestGetHideBottom>((event, emit) {
      bool? isHide = event.isHide;
      return _handleGetHideBottom(
        emit,
        isHide,
      );
    });

    on<RequestGetRelatedNews>((event, emit) {
      int? newsId = event.newsId;
      return _handleGetRelatedNews(emit, newsId);
    });

    on<RequestPostNewsComment>((event, emit) {
      int? newsId = event.newsId;
      NewsCommentModel? newsCommentModel = event.newsCommentModel;
      return _handlePostNewsComments(
        emit,
        newsId,
        newsCommentModel,
      );
    });

    on<RequestGetNewsCategory>((event, emit) {
      int? pageNumber = event.pageNumber;
      int? groupId = event.groupId;
      return _handleGetNewsCategory(
        emit,
        pageNumber,
        groupId,
      );
    });

    on<RequestGetProductsCategory>((event, emit) {
      int? pageNumber = event.pageNumber;
      int? groupId = event.groupId;
      return _handleGetProductsCategory(
        emit,
        pageNumber,
        groupId,
      );
    });

    on<RequestGetTopBanner>((event, emit) {
      int? bannerId = event.bannerId;
      return _handleGetTopBanner(
        emit,
        bannerId,
      );
    });

    on<RequestGetHomeBanner>((event, emit) {
      int? bannerId = event.bannerId;
      return _handleGetHomeBanner(
        emit,
        bannerId,
      );
    });

    on<RequestGetCategoryBanner>((event, emit) {
      int? bannerId = event.bannerId;
      return _handleGetCategoryBanner(
        emit,
        bannerId,
      );
    });

    on<RequestGetSubCategory>((event, emit) {
      int? categoryId = event.categoryId;
      return _handleGetSubCategory(
        emit,
        categoryId,
      );
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

  _handleGetListIpad(Emitter<ShopdunkState> emit, int? id) async {
    emit(const IpadLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(IpadLoaded(ipad: productsResponse));
    } catch (e) {
      emit(IpadLoadError(message: handleError(e)));
    }
  }

  _handleGetListIphone(Emitter<ShopdunkState> emit, int? id) async {
    emit(const IphoneLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(IphoneLoaded(iphone: productsResponse));
    } catch (e) {
      emit(IphoneLoadError(message: handleError(e)));
    }
  }

  _handleGetListMac(Emitter<ShopdunkState> emit, int? id) async {
    emit(const MacLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(MacLoaded(mac: productsResponse));
    } catch (e) {
      emit(MacLoadError(message: handleError(e)));
    }
  }

  _handleGetListAppleWatch(Emitter<ShopdunkState> emit, int? id) async {
    emit(const AppleWatchLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(AppleWatchLoaded(watch: productsResponse));
    } catch (e) {
      emit(AppleWatchLoadError(message: handleError(e)));
    }
  }

  _handleGetListSound(Emitter<ShopdunkState> emit, int? id) async {
    emit(const SoundLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(SoundLoaded(sound: productsResponse));
    } catch (e) {
      emit(SoundLoadError(message: handleError(e)));
    }
  }

  _handleGetListAccessories(Emitter<ShopdunkState> emit, int? id) async {
    emit(const AccessoriesLoading());
    try {
      final productsResponse = await ApiCall().requestGetProduct(id);
      emit(AccessoriesLoaded(accessories: productsResponse));
    } catch (e) {
      emit(AccessoriesLoadError(message: handleError(e)));
    }
  }

  _handleGetSearchProductsResult(
    Emitter<ShopdunkState> emit,
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

  _handleGetHideBottom(Emitter<ShopdunkState> emit, bool? isHide) async {
    try {
      emit(
        HideBottomSuccess(
          isHide: isHide ?? false,
        ),
      );
    } catch (e) {
      emit(
        HideBottomError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetRelatedNews(Emitter<ShopdunkState> emit, int? newsId) async {
    emit(const RelatedNewsLoading());
    try {
      final data = await ApiCall().requestGetRelatedNews(newsId);
      emit(
        RelatedNewsLoaded(newsData: data ?? RelatedNews()),
      );
    } catch (e) {
      emit(
        RelatedNewsLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handlePostNewsComments(
    Emitter<ShopdunkState> emit,
    int? newsId,
    NewsCommentModel? newsCommentModel,
  ) async {
    emit(const NewsCommentsLoading());
    try {
      final data = await ApiCall().requestPostNewsComment(
        newsId,
        newsCommentModel ?? NewsCommentModel(),
      );
      emit(
        NewsCommentsLoaded(
          newsCommentResponseModel: data ?? NewsCommentResponseModel(),
        ),
      );
    } catch (e) {
      emit(
        NewsCommentsLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetNewsCategory(
    Emitter<ShopdunkState> emit,
    int? pageNumber,
    int? groupId,
  ) async {
    emit(const NewsCategoryLoading());
    try {
      final data = await ApiCall().requestGetNewsGroup(groupId, pageNumber);
      emit(
        NewsCategoryLoaded(
          newsCategoryModel: data ?? NewsCategoryModel(),
        ),
      );
    } catch (e) {
      emit(
        NewsCategoryLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetProductsCategory(
    Emitter<ShopdunkState> emit,
    int? pageNumber,
    int? groupId,
  ) async {
    emit(const ProductsCategoryLoading());
    try {
      final data = await ApiCall().requestGetProductsGroup(groupId, pageNumber);
      emit(
        ProductsCategoryLoaded(
          categoryGroupModel: data ?? CategoryGroupModel(),
        ),
      );
    } catch (e) {
      emit(
        ProductsCategoryLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetTopBanner(
    Emitter<ShopdunkState> emit,
    int? bannerId,
  ) async {
    emit(const TopBannerLoading());
    try {
      final data = await ApiCall().requestGetTopBanner();
      emit(
        TopBannerLoaded(listTopics: data ?? BannerModel()),
      );
    } catch (e) {
      emit(
        TopBannerLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetHomeBanner(
    Emitter<ShopdunkState> emit,
    int? bannerId,
  ) async {
    emit(const HomeBannerLoading());
    try {
      final data = await ApiCall().requestGetHomeBanner();
      emit(
        HomeBannerLoaded(listTopics: data ?? BannerModel()),
      );
    } catch (e) {
      emit(
        HomeBannerLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetCategoryBanner(
    Emitter<ShopdunkState> emit,
    int? bannerId,
  ) async {
    emit(const CategoryBannerLoading());
    try {
      final data = await ApiCall().requestGetCategoryBanner(bannerId);
      emit(
        CategoryBannerLoaded(listTopics: data ?? BannerModel()),
      );
    } catch (e) {
      emit(
        CategoryBannerLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetSubCategory(
    Emitter<ShopdunkState> emit,
    int? categoryId,
  ) async {
    emit(const SubCategoryLoading());
    try {
      final data = await ApiCall().requestGetSubCategories(categoryId);
      emit(
        SubCategoryLoaded(subCategory: data ?? []),
      );
    } catch (e) {
      emit(
        SubCategoryLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
