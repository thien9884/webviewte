import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class RequestPostRecoveryPassword extends ForgotPasswordEvent {
  final String email;

  const RequestPostRecoveryPassword({required this.email});

  @override
  List<Object?> get props => [];
}
