import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/base_blocs.dart';
import 'package:webviewtest/blocs/customer_address/customer_address_event.dart';
import 'package:webviewtest/blocs/customer_address/customer_address_state.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/services/api_call.dart';

class CustomerAddressBloc
    extends BaseBloc<CustomerAddressEvent, CustomerAddressState> {
  CustomerAddressBloc() : super(const CustomerAddressInitial()) {
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
  }

  _handleGetCustomerAddress(
      Emitter<CustomerAddressState> emit, int? customerId) async {
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

  _handlePostAddAddress(Emitter<CustomerAddressState> emit, int? customerId,
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
    Emitter<CustomerAddressState> emit,
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
}
