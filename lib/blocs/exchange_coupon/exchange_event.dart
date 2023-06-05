import 'package:equatable/equatable.dart';

abstract class ExchangeEvent extends Equatable {
  const ExchangeEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetExchangePoint extends ExchangeEvent {
  final int? pointExchange;

  const RequestGetExchangePoint(
    this.pointExchange,
  );

  @override
  List<Object?> get props => [];
}

class RequestGetListCoupon extends ExchangeEvent {
  final int index;
  final int size;

  const RequestGetListCoupon(
    this.index,
    this.size,
  );

  @override
  List<Object?> get props => [];
}
