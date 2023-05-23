import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

class ForgotPasswordLoaded extends ForgotPasswordState {
  final String message;

  const ForgotPasswordLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

class ForgotPasswordLoadError extends ForgotPasswordState {
  final String message;

  const ForgotPasswordLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
