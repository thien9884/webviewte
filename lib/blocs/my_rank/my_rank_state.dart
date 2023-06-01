import 'package:equatable/equatable.dart';

abstract class MyRankState extends Equatable {
  const MyRankState();

  @override
  List<Object?> get props => [];
}

class MyRankInitial extends MyRankState {
  const MyRankInitial();

  @override
  List<Object?> get props => [];
}

class MyRankLoading extends MyRankState {
  const MyRankLoading();
}

class MyRankLoaded extends MyRankState {

  const MyRankLoaded();

  @override
  List<Object?> get props => [];
}

class MyRankLoadError extends MyRankState {
  final String message;

  const MyRankLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
