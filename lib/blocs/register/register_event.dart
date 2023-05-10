import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/register/register_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RequestPostRegister extends RegisterEvent {
  final RegisterModel registerModel;

  const RequestPostRegister({required this.registerModel});

  @override
  List<Object?> get props => [];
}
