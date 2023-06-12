import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/noti/noti_event.dart';
import 'package:webviewtest/blocs/noti/noti_state.dart';
import 'package:webviewtest/model/notification/noti_model.dart';
import 'package:webviewtest/services/api_call.dart';

class NotiBloc extends BaseBloc<NotiEvent, NotiState> {
  NotiBloc() : super(const NotiInitial()) {
    // GET NEWS EVENT
    on<RequestGetNoti>((event, emit) {
      int? size = event.size;
      return _handleGetNoti(
        emit,
        size,
      );
    });
  }

  _handleGetNoti(
    Emitter<NotiState> emit,
    int? size,
  ) async {
    emit(const NotiLoading());
    try {
      final data = await ApiCall().requestGetNoti(size);
      emit(
        NotiLoaded(
          pointNotiModel: data ?? PointNotiModel(),
        ),
      );
    } catch (e) {
      emit(
        NotiLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
