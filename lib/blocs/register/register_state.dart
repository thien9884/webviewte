import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/login/user_model.dart';
import 'package:webviewtest/model/register/register_response.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class RegisterInitial extends RegisterState {
  const RegisterInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterLoaded extends RegisterState {
  final RegisterResponse registerResponse;

  const RegisterLoaded({required this.registerResponse});

  @override
  List<Object?> get props => [registerResponse];
}

class RegisterLoadError extends RegisterState {
  final String message;

  const RegisterLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NewTokenLoading extends RegisterState {
  const NewTokenLoading();
}

class NewTokenLoaded extends RegisterState {
  final UserModel userModel;

  const NewTokenLoaded({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class NewTokenLoadError extends RegisterState {
  final String message;

  const NewTokenLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
