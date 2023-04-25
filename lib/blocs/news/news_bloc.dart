import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/news/news_event.dart';
import 'package:webviewtest/blocs/news/news_state.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/services/api_call.dart';

class NewsBloc extends BaseBloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsInitial()) {
    // GET NEWS EVENT
    on<RequestGetNews>((event, emit) => _handleGetNews(event, emit));

    // GET HIDE BOTTOM
    on<RequestGetHideBottom>((event, emit) {
      bool? isHide = event.isHide;
      return _handleGetHideBottom(
        emit,
        isHide,
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

  _handleGetHideBottom(Emitter<NewsState> emit, bool? isHide) async {
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
}
