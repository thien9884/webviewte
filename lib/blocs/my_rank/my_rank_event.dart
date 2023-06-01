import 'package:equatable/equatable.dart';

abstract class MyRankEvent extends Equatable {
  const MyRankEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetMyRank extends MyRankEvent {
  final int? pageNumber;

  const RequestGetMyRank(
      this.pageNumber,
      );

  @override
  List<Object?> get props => [];
}
