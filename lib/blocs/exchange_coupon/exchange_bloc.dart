import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/exchange_coupon/exchange_event.dart';
import 'package:webviewtest/blocs/exchange_coupon/exchange_state.dart';
import 'package:webviewtest/model/coupon/coupon_model.dart';
import 'package:webviewtest/services/api_call.dart';

class ExchangeBloc extends BaseBloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(const ExchangeInitial()) {
    // GET EXCHANGE POINT
    on<RequestGetExchangePoint>((event, emit) {
      int? pointExchange = event.pointExchange;
      return _handleGetExchangePoint(
        emit,
        pointExchange,
      );
    });
    on<RequestGetListCoupon>((event, emit) {
      int index = event.index;
      int size = event.size;
      return _handleGetListCoupon(
        emit,
        index,
        size,
      );
    });
  }

  _handleGetExchangePoint(
    Emitter<ExchangeState> emit,
    int? point,
  ) async {
    emit(const ExchangePointLoading());
    try {
      final data = await ApiCall().requestGetPointExchange(point);
      emit(
        ExchangePointLoaded(couponModel: data ?? CouponModel()),
      );
    } catch (e) {
      emit(
        ExchangePointLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetListCoupon(Emitter<ExchangeState> emit, int index, int size) async {
    emit(const ListCouponLoading());
    try {
      final data = await ApiCall().requestGetListCoupon(index, size);
      emit(
        ListCouponLoaded(
          listCoupon: data,
        ),
      );
    } catch (e) {
      emit(
        ListCouponLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
