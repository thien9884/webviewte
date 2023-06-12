import 'package:equatable/equatable.dart';

abstract class NotiEvent extends Equatable {
  const NotiEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetNoti extends NotiEvent {
  final int? size;

  const RequestGetNoti(
    this.size,
  );

  @override
  List<Object?> get props => [];
}
