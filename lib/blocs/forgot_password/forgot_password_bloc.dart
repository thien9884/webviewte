import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/forgot_password/forgot_password_event.dart';
import 'package:webviewtest/blocs/forgot_password/forgot_password_state.dart';
import 'package:webviewtest/services/api_call.dart';

class ForgotPasswordBloc
    extends BaseBloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordInitial()) {
    on<RequestPostRecoveryPassword>((event, emit) async {
      String email = event.email;
      await _handleForgotPassword(emit, email);
    });
  }

  _handleForgotPassword(Emitter<ForgotPasswordState> emit, String email) async {
    emit(const ForgotPasswordLoading());
    try {
      final data = await ApiCall().requestRecoveryPassword(email);
      emit(
        ForgotPasswordLoaded(message: data),
      );
    } catch (e) {
      emit(
        ForgotPasswordLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
