import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/register/register_event.dart';
import 'package:webviewtest/blocs/register/register_state.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/model/register/register_model.dart';
import 'package:webviewtest/model/register/register_response.dart';
import 'package:webviewtest/services/api_call.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<RequestPostRegister>((event, emit) async {
      RegisterModel? registerModel = event.registerModel;
      await _handleRegister(emit, registerModel);
    });
    on<RequestNewToken>((event, emit) async {
      await _handleNewToken(event, emit);
    });
  }

  _handleRegister(
      Emitter<RegisterState> emit, RegisterModel registerModel) async {
    emit(const RegisterLoading());
    try {
      final user = await ApiCall().register(registerModel);
      print('user:::::::::::: $user');
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

  _handleNewToken(RequestNewToken event, Emitter<RegisterState> emit) async {
    emit(const NewTokenLoading());
    try {
      final user = await ApiCall().newToken();
      emit(
        NewTokenLoaded(userModel: user ?? UserModel()),
      );
    } catch (e) {
      emit(
        NewTokenLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
