import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/change_password/change_password_event.dart';
import 'package:webviewtest/blocs/change_password/change_password_state.dart';
import 'package:webviewtest/services/api_call.dart';

class ChangePasswordBloc
    extends BaseBloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(const ChangePasswordInitial()) {
    on<RequestPutChangePassword>((event, emit) async {
      String oldPassword = event.oldPassword;
      String newPassword = event.newPassword;
      String confirmNew = event.confirmNew;
      await _handleChangePassword(
        emit,
        oldPassword,
        newPassword,
        confirmNew,
      );
    });
  }

  _handleChangePassword(
    Emitter<ChangePasswordState> emit,
    String oldPassword,
    String newPassword,
    String confirmNew,
  ) async {
    emit(const ChangePasswordLoading());
    try {
      final data = await ApiCall().requestChangePassword(
        oldPassword,
        newPassword,
        confirmNew,
      );
      emit(
        ChangePasswordLoaded(message: data),
      );
    } catch (e) {
      emit(
        ChangePasswordLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
