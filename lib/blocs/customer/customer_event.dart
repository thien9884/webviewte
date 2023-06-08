import 'dart:io';

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
  final int? page;
  final int? size;

  const RequestGetMySystem(this.levelId, this.page, this.size);

  @override
  List<Object?> get props => [];
}

class RequestGetAvatar extends CustomerEvent {
  const RequestGetAvatar();

  @override
  List<Object?> get props => [];
}

class RequestUploadAvatar extends CustomerEvent {
  final File? file;
  const RequestUploadAvatar({required this.file});

  @override
  List<Object?> get props => [];
}

class RequestDeleteAccount extends CustomerEvent {
  const RequestDeleteAccount();

  @override
  List<Object?> get props => [];
}
