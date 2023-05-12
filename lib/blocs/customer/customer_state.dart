import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/model/customer/product_rating_model.dart';
import 'package:webviewtest/model/customer/rating_model.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class CustomerAddressInitial extends CustomerState {
  const CustomerAddressInitial();

  @override
  List<Object?> get props => [];
}

// GET ORDER STATES
class CustomerAddressLoading extends CustomerState {
  const CustomerAddressLoading();
}

class CustomerAddressLoaded extends CustomerState {
  final CustomerModel? customerModel;

  const CustomerAddressLoaded({required this.customerModel});

  @override
  List<Object?> get props => [customerModel];
}

class CustomerAddressLoadError extends CustomerState {
  final String message;

  const CustomerAddressLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddAddressLoading extends CustomerState {
  const AddAddressLoading();
}

class AddAddressLoaded extends CustomerState {
  final AddAddressModel? addAddressModel;

  const AddAddressLoaded({required this.addAddressModel});

  @override
  List<Object?> get props => [addAddressModel];
}

class AddAddressLoadError extends CustomerState {
  final String message;

  const AddAddressLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PutAddressLoading extends CustomerState {
  const PutAddressLoading();
}

class PutAddressLoaded extends CustomerState {
  final CustomerModel? customerModel;

  const PutAddressLoaded({required this.customerModel});

  @override
  List<Object?> get props => [customerModel];
}

class PutAddressLoadError extends CustomerState {
  final String message;

  const PutAddressLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetInfoLoading extends CustomerState {
  const GetInfoLoading();
}

class GetInfoLoaded extends CustomerState {
  final InfoModel? infoModel;

  const GetInfoLoaded({required this.infoModel});

  @override
  List<Object?> get props => [infoModel];
}

class GetInfoLoadError extends CustomerState {
  final String message;

  const GetInfoLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RatingHistoryLoading extends CustomerState {
  const RatingHistoryLoading();
}

class RatingHistoryLoaded extends CustomerState {
  final List<RatingModel>? listRatingModel;

  const RatingHistoryLoaded({required this.listRatingModel});

  @override
  List<Object?> get props => [listRatingModel];
}

class RatingHistoryLoadError extends CustomerState {
  final String message;

  const RatingHistoryLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductRatingLoading extends CustomerState {
  const ProductRatingLoading();
}

class ProductRatingLoaded extends CustomerState {
  final List<ProductHistory> productsModel;

  const ProductRatingLoaded({required this.productsModel});

  @override
  List<Object?> get props => [productsModel];
}

class ProductRatingLoadError extends CustomerState {
  final String message;

  const ProductRatingLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
