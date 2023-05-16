import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/model/customer/product_rating_model.dart';
import 'package:webviewtest/model/customer/rating_model.dart';
import 'package:webviewtest/model/my_system/my_system_model.dart';
import 'package:webviewtest/model/state/state_model.dart';

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
  final Addresses? addAddressModel;

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
  final String? message;

  const PutAddressLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

class PutAddressLoadError extends CustomerState {
  final String message;

  const PutAddressLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteAddressLoading extends CustomerState {
  const DeleteAddressLoading();
}

class DeleteAddressLoaded extends CustomerState {
  final String? message;

  const DeleteAddressLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteAddressLoadError extends CustomerState {
  final String message;

  const DeleteAddressLoadError({required this.message});

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

class GetStateLoading extends CustomerState {
  const GetStateLoading();
}

class GetStateLoaded extends CustomerState {
  final List<StateModel>? stateModel;

  const GetStateLoaded({required this.stateModel});

  @override
  List<Object?> get props => [stateModel];
}

class GetStateLoadError extends CustomerState {
  final String message;

  const GetStateLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PutInfoLoading extends CustomerState {
  const PutInfoLoading();
}

class PutInfoLoaded extends CustomerState {
  final String? message;

  const PutInfoLoaded({required this.message});

  @override
  List<Object?> get props => [message];
}

class PutInfoLoadError extends CustomerState {
  final String message;

  const PutInfoLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class RatingHistoryLoading extends CustomerState {
  const RatingHistoryLoading();
}

class RatingHistoryLoaded extends CustomerState {
  final List<RatingHistoryModel>? listRatingModel;

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

class MySystemLoading extends CustomerState {
  const MySystemLoading();
}

class MySystemLoaded extends CustomerState {
  final MySystemModel mySystemModel;

  const MySystemLoaded({required this.mySystemModel});

  @override
  List<Object?> get props => [mySystemModel];
}

class MySystemLoadError extends CustomerState {
  final String message;

  const MySystemLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
