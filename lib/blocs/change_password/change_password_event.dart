import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class RequestPutChangePassword extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmNew;

  const RequestPutChangePassword({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNew,
  });

  @override
  List<Object?> get props => [];
}
