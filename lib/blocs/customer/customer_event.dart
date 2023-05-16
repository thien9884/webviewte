import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/customer/info_model.dart';

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
  final Addresses? addAddressModel;

  const RequestPostAddAddress(this.customerId, this.addAddressModel);

  @override
  List<Object?> get props => [];
}

class RequestPutAddress extends CustomerEvent {
  final PutAddress? putAddress;

  const RequestPutAddress(this.putAddress);

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

class RequestGetState extends CustomerEvent {
  const RequestGetState();

  @override
  List<Object?> get props => [];
}

class RequestPutInfo extends CustomerEvent {
  final InfoModel? infoModel;
  const RequestPutInfo({required this.infoModel});

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

class RequestGetMySystem extends CustomerEvent {
  final int? levelId;

  const RequestGetMySystem(this.levelId);

  @override
  List<Object?> get props => [];
}
