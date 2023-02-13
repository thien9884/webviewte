import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/login/login_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class RequestPostLogin extends LoginEvent {
  final LoginModel loginModel;

  const RequestPostLogin({required this.loginModel});

  @override
  List<Object?> get props => [];
}
