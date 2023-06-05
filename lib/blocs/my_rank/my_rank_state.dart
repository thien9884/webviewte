import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/my_rank/my_rank_model.dart';

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
  final MyRankModel myRankModel;

  const MyRankLoaded({required this.myRankModel});

  @override
  List<Object?> get props => [myRankModel];
}

class MyRankLoadError extends MyRankState {
  final String message;

  const MyRankLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
