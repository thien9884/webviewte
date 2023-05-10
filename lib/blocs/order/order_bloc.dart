import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/order/order_event.dart';
import 'package:webviewtest/blocs/order/order_state.dart';
import 'package:webviewtest/model/order/order_model.dart';
import 'package:webviewtest/services/api_call.dart';

class OrderBloc extends BaseBloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderInitial()) {
    // GET NEWS EVENT
    on<RequestGetOrder>((event, emit) {
      int? customerId = event.customerId;
      return _handleGetOrder(emit, customerId);
    });
  }

  _handleGetOrder(Emitter<OrderState> emit, int? customerId) async {
    emit(const OrderLoading());
    try {
      final data = await ApiCall().requestGetOrder(customerId);
      emit(
        OrderLoaded(orderModel: data ?? OrderModel()),
      );
    } catch (e) {
      emit(
        OrderLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
