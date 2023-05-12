import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/services/api_call.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class CustomerBloc extends BaseBloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(const CustomerAddressInitial()) {
    // GET NEWS EVENT
    on<RequestGetCustomerAddress>((event, emit) {
      int? customerId = event.customerId;
      return _handleGetCustomerAddress(emit, customerId);
    });
    on<RequestPostAddAddress>((event, emit) {
      int? customerId = event.customerId;
      AddAddressModel? addAddressModel = event.addAddressModel;
      return _handlePostAddAddress(emit, customerId, addAddressModel);
    });
    on<RequestPutAddress>((event, emit) {
      int? customerId = event.customerId;
      CustomerModel? customerModel = event.customerModel;
      return _handlePutAddress(emit, customerId, customerModel);
    });
    on<RequestGetInfo>((event, emit) {
      return _handleGetInfo(event, emit);
    });
    on<RequestGetRatingHistory>((event, emit) {
      int? customerId = event.customerId;
      return _handleGetRatingHistory(emit, customerId);
    });
    on<RequestGetProductRating>((event, emit) {
      int? productId = event.productId;
      return _handleGetProductRating(emit, productId);
    });
  }

  _handleGetCustomerAddress(
      Emitter<CustomerState> emit, int? customerId) async {
    emit(const CustomerAddressLoading());
    try {
      final data = await ApiCall().requestGetCustomerAddress(customerId);
      emit(
        CustomerAddressLoaded(customerModel: data ?? CustomerModel()),
      );
    } catch (e) {
      emit(
        CustomerAddressLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handlePostAddAddress(Emitter<CustomerState> emit, int? customerId,
      AddAddressModel? addAddressModel) async {
    emit(const AddAddressLoading());
    try {
      final data =
          await ApiCall().requestPostAddAddress(customerId, addAddressModel);
      emit(
        AddAddressLoaded(addAddressModel: data ?? AddAddressModel()),
      );
    } catch (e) {
      emit(
        AddAddressLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handlePutAddress(
    Emitter<CustomerState> emit,
    int? customerId,
    CustomerModel? customerModel,
  ) async {
    emit(const PutAddressLoading());
    try {
      final data =
          await ApiCall().requestPutAddAddress(customerId, customerModel);
      emit(
        PutAddressLoaded(customerModel: data ?? CustomerModel()),
      );
    } catch (e) {
      emit(
        PutAddressLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetInfo(RequestGetInfo event, Emitter<CustomerState> emit) async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;

    emit(const GetInfoLoading());
    try {
      final data = await ApiCall().requestGetInfo();
      sPref.setInfoCustomer(jsonEncode(data));

      emit(
        GetInfoLoaded(infoModel: data ?? InfoModel()),
      );
    } catch (e) {
      emit(
        GetInfoLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetRatingHistory(Emitter<CustomerState> emit, int? customerId) async {
    emit(const RatingHistoryLoading());
    try {
      final data = await ApiCall().requestGetRatingHistory(customerId);
      emit(
        RatingHistoryLoaded(
          listRatingModel: data ?? [],
        ),
      );
    } catch (e) {
      emit(
        RatingHistoryLoadError(
          message: handleError(e),
        ),
      );
    }
  }

  _handleGetProductRating(Emitter<CustomerState> emit, int? productId) async {
    emit(const ProductRatingLoading());
    try {
      final data = await ApiCall().requestGetProduct(productId);
      emit(
        ProductRatingLoaded(
          productsModel: data,
        ),
      );
    } catch (e) {
      emit(
        ProductRatingLoadError(
          message: handleError(e),
        ),
      );
    }
  }
}
