import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/avatar/avatar_event.dart';
import 'package:webviewtest/blocs/avatar/avatar_state.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/services/api_call.dart';

class AvatarBloc extends BaseBloc<AvatarEvent, AvatarState> {
  AvatarBloc() : super(const AvatarInitial()) {
    // GET AVATAR
    on<RequestGetAvatar>((event, emit) {
      return _handleGetMyRank(
        event,
        emit,
      );
    });
  }

  _handleGetMyRank(
    RequestGetAvatar event,
    Emitter emit,
  ) async {
    emit(const GetAvatarLoading());
    try {
      final data = await ApiCall().requestGetMyRank(1);
      emit(
        GetAvatarLoaded(),
      );
    } catch (e) {
      emit(
        GetAvatarLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
