import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/notification/noti_model.dart';

abstract class NotiState extends Equatable {
  const NotiState();

  @override
  List<Object?> get props => [];
}

class NotiInitial extends NotiState {
  const NotiInitial();

  @override
  List<Object?> get props => [];
}

class NotiLoading extends NotiState {
  const NotiLoading();
}

class NotiLoaded extends NotiState {
  final PointNotiModel pointNotiModel;

  const NotiLoaded({required this.pointNotiModel});

  @override
  List<Object?> get props => [pointNotiModel];
}

class NotiLoadError extends NotiState {
  final String message;

  const NotiLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
