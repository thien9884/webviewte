import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/coupon/coupon_model.dart';
import 'package:webviewtest/model/my_rank/my_rank_model.dart';

abstract class ExchangeState extends Equatable {
  const ExchangeState();

  @override
  List<Object?> get props => [];
}

class ExchangeInitial extends ExchangeState {
  const ExchangeInitial();

  @override
  List<Object?> get props => [];
}

class ExchangePointLoading extends ExchangeState {
  const ExchangePointLoading();
}

class ExchangePointLoaded extends ExchangeState {
  final CouponModel? couponModel;

  const ExchangePointLoaded({required this.couponModel});

  @override
  List<Object?> get props => [couponModel];
}

class ExchangePointLoadError extends ExchangeState {
  final String message;

  const ExchangePointLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ListCouponLoading extends ExchangeState {
  const ListCouponLoading();
}

class ListCouponLoaded extends ExchangeState {
  final TotalCoupon? listCoupon;

  const ListCouponLoaded({required this.listCoupon});

  @override
  List<Object?> get props => [listCoupon];
}

class ListCouponLoadError extends ExchangeState {
  final String message;

  const ListCouponLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MyRankLoading extends ExchangeState {
  const MyRankLoading();
}

class MyRankLoaded extends ExchangeState {
  final MyRankModel myRankModel;

  const MyRankLoaded({required this.myRankModel});

  @override
  List<Object?> get props => [myRankModel];
}

class MyRankLoadError extends ExchangeState {
  final String message;

  const MyRankLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

