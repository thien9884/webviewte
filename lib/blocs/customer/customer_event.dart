import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetCustomerAddress extends CustomerEvent {
  final int? customerId;

  const RequestGetCustomerAddress(this.customerId);

  @override
  List<Object?> get props => [];
}

class RequestPostAddAddress extends CustomerEvent {
  final int? customerId;
  final AddAddressModel? addAddressModel;

  const RequestPostAddAddress(this.customerId, this.addAddressModel);

  @override
  List<Object?> get props => [];
}

class RequestPutAddress extends CustomerEvent {
  final int? customerId;
  final CustomerModel? customerModel;

  const RequestPutAddress(this.customerId, this.customerModel);

  @override
  List<Object?> get props => [];
}

class RequestDeleteAddress extends CustomerEvent {
  final int? customerId;
  final int? addressId;

  const RequestDeleteAddress(this.customerId, this.addressId);

  @override
  List<Object?> get props => [];
}

class RequestGetInfo extends CustomerEvent {
  const RequestGetInfo();

  @override
  List<Object?> get props => [];
}

class RequestGetRatingHistory extends CustomerEvent {
  final int? customerId;

  const RequestGetRatingHistory(this.customerId);

  @override
  List<Object?> get props => [];
}

class RequestGetProductRating extends CustomerEvent {
  final int? productId;

  const RequestGetProductRating(this.productId);

  @override
  List<Object?> get props => [];
}
