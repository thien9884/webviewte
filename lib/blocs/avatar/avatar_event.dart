import 'package:equatable/equatable.dart';

abstract class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetAvatar extends AvatarEvent {
  const RequestGetAvatar();

  @override
  List<Object?> get props => [];
}
