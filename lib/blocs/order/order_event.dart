import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetOrder extends OrderEvent {
  final int? customerId;

  const RequestGetOrder(this.customerId);

  @override
  List<Object?> get props => [];
}
