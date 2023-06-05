import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/my_rank/my_rank_event.dart';
import 'package:webviewtest/blocs/my_rank/my_rank_state.dart';
import 'package:webviewtest/model/my_rank/my_rank_model.dart';
import 'package:webviewtest/services/api_call.dart';

class MyRankBloc extends BaseBloc<MyRankEvent, MyRankState> {
  MyRankBloc() : super(const MyRankInitial()) {
    // GET MY RANK
    on<RequestGetMyRank>((event, emit) {
      int? pageNumber = event.pageNumber;
      return _handleGetMyRank(
        emit,
        pageNumber,
      );
    });
  }

  _handleGetMyRank(
    Emitter<MyRankState> emit,
    int? pageNumber,
  ) async {
    emit(const MyRankLoading());
    try {
      final data = await ApiCall().requestGetMyRank(pageNumber);
      emit(
        MyRankLoaded(myRankModel: data ?? MyRankModel()),
      );
    } catch (e) {
      emit(
        MyRankLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
