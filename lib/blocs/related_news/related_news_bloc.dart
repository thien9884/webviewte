import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/related_news/related_news_event.dart';
import 'package:webviewtest/blocs/related_news/related_news_state.dart';
import 'package:webviewtest/model/related_news_model/related_news_model.dart';
import 'package:webviewtest/services/api_call.dart';

class RelatedNewsBloc extends BaseBloc<RelatedNewsEvent, RelatedNewsState> {
  RelatedNewsBloc() : super(const RelatedNewsInitial()) {
    // GET NEWS EVENT
    on<RequestGetRelatedNews>(
        (event, emit) {
          int? newsId = event.newsId;
          return _handleGetRelatedNews(emit, newsId);
        });
  }

  _handleGetRelatedNews(Emitter<RelatedNewsState> emit, int? newsId) async {
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
}
