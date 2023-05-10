import 'package:equatable/equatable.dart';
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
