import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/login/login_event.dart';
import 'package:webviewtest/blocs/login/login_state.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/services/api_call.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<RequestPostLogin>((event, emit) async {
      LoginModel? loginModel = event.loginModel;
      await _handleLogin(emit, loginModel);
    });
  }

  _handleLogin(Emitter<LoginState> emit, LoginModel loginModel) async {
    final sPref = await SharedPreferencesService.instance;
    emit(const LoginLoading());
    try {
      final user = await ApiCall().login(loginModel);
      // sPref.setToken(user?.accessToken ?? '');
      sPref.setRememberMe(loginModel.rememberMe);
      sPref.setUserName(loginModel.username.toString());
      sPref.setPassword(loginModel.password ?? '');
      sPref.setCustomerId(user?.customerId ?? 0);
      print(user?.accessToken);
      emit(
        LoginLoaded(userModel: user ?? UserModel(), isLogin: user != null),
      );
    } catch (e) {
      emit(
        LoginLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
