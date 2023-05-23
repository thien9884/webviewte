import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();

  @override
  List<Object?> get props => [];
}

// GET CATEGORIES STATES
class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

class ChangePasswordLoaded extends ChangePasswordState {
  final String message;

  const ChangePasswordLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChangePasswordLoadError extends ChangePasswordState {
  final String message;

  const ChangePasswordLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
