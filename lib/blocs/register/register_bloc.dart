import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/register/register_event.dart';
import 'package:webviewtest/blocs/register/register_state.dart';
import 'package:webviewtest/model/register/register_model.dart';
import 'package:webviewtest/model/register/register_response.dart';
import 'package:webviewtest/services/api_call.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<RequestPostRegister>((event, emit) async {
      RegisterModel? registerModel = event.registerModel;
      await _handleRegister(emit, registerModel);
    });
  }

  _handleRegister(Emitter<RegisterState> emit, RegisterModel registerModel) async {
    emit(const RegisterLoading());
    try {
      final user = await ApiCall().register(registerModel);
      emit(
        RegisterLoaded(registerResponse: user ?? RegisterResponse()),
      );
    } catch (e) {
      emit(
        RegisterLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
