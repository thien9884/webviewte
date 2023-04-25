import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/news_category/news_category_event.dart';
import 'package:webviewtest/blocs/news_category/news_category_state.dart';
import 'package:webviewtest/model/news_category/news_category_model.dart';
import 'package:webviewtest/services/api_call.dart';

class NewsCategoryBloc extends BaseBloc<NewsCategoryEvent, NewsCategoryState> {
  NewsCategoryBloc() : super(const NewsCategoryInitial()) {
    // GET NEWS EVENT
    on<RequestGetNewsCategory>((event, emit) {
      int? pageNumber = event.pageNumber;
      int? groupId = event.groupId;
      return _handleGetRelatedNews(
        emit,
        pageNumber,
        groupId,
      );
    });
  }

  _handleGetRelatedNews(
    Emitter<NewsCategoryState> emit,
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
}
