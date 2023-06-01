import 'package:equatable/equatable.dart';

abstract class AvatarState extends Equatable {
  const AvatarState();

  @override
  List<Object?> get props => [];
}

class AvatarInitial extends AvatarState {
  const AvatarInitial();

  @override
  List<Object?> get props => [];
}

class GetAvatarLoading extends AvatarState {
  const GetAvatarLoading();
}

class GetAvatarLoaded extends AvatarState {

  const GetAvatarLoaded();

  @override
  List<Object?> get props => [];
}

class GetAvatarLoadError extends AvatarState {
  final String message;

  const GetAvatarLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
