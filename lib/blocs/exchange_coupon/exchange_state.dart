import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/coupon/coupon_model.dart';

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
