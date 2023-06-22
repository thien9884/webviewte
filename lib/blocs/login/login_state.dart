import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/login/user_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  final bool isLogin;
  final UserModel userModel;

  const LoginLoaded({required this.userModel, required this.isLogin});

  @override
  List<Object?> get props => [userModel, isLogin];
}

class LoginLoadError extends LoginState {
  final String message;

  const LoginLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
