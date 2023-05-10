import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';

abstract class CustomerAddressEvent extends Equatable {
  const CustomerAddressEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetCustomerAddress extends CustomerAddressEvent {
  final int? customerId;

  const RequestGetCustomerAddress(this.customerId);

  @override
  List<Object?> get props => [];
}

class RequestPostAddAddress extends CustomerAddressEvent {
  final int? customerId;
  final AddAddressModel? addAddressModel;

  const RequestPostAddAddress(this.customerId, this.addAddressModel);

  @override
  List<Object?> get props => [];
}

class RequestPutAddress extends CustomerAddressEvent {
  final int? customerId;
  final CustomerModel? customerModel;

  const RequestPutAddress(this.customerId, this.customerModel);

  @override
  List<Object?> get props => [];
}

class RequestDeleteAddress extends CustomerAddressEvent {
  final int? customerId;
  final int? addressId;

  const RequestDeleteAddress(this.customerId, this.addressId);

  @override
  List<Object?> get props => [];
}
