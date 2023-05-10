import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/order/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class OrderInitial extends OrderState {
  const OrderInitial();

  @override
  List<Object?> get props => [];
}

// GET ORDER STATES
class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderLoaded extends OrderState {
  final OrderModel? orderModel;

  const OrderLoaded({required this.orderModel});

  @override
  List<Object?> get props => [orderModel];
}

class OrderLoadError extends OrderState {
  final String message;

  const OrderLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
