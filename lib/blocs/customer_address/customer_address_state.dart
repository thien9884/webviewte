import 'package:equatable/equatable.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';

abstract class CustomerAddressState extends Equatable {
  const CustomerAddressState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class CustomerAddressInitial extends CustomerAddressState {
  const CustomerAddressInitial();

  @override
  List<Object?> get props => [];
}

// GET ORDER STATES
class CustomerAddressLoading extends CustomerAddressState {
  const CustomerAddressLoading();
}

class CustomerAddressLoaded extends CustomerAddressState {
  final CustomerModel? customerModel;

  const CustomerAddressLoaded({required this.customerModel});

  @override
  List<Object?> get props => [customerModel];
}

class CustomerAddressLoadError extends CustomerAddressState {
  final String message;

  const CustomerAddressLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddAddressLoading extends CustomerAddressState {
  const AddAddressLoading();
}

class AddAddressLoaded extends CustomerAddressState {
  final AddAddressModel? addAddressModel;

  const AddAddressLoaded({required this.addAddressModel});

  @override
  List<Object?> get props => [addAddressModel];
}

class AddAddressLoadError extends CustomerAddressState {
  final String message;

  const AddAddressLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PutAddressLoading extends CustomerAddressState {
  const PutAddressLoading();
}

class PutAddressLoaded extends CustomerAddressState {
  final CustomerModel? customerModel;

  const PutAddressLoaded({required this.customerModel});

  @override
  List<Object?> get props => [customerModel];
}

class PutAddressLoadError extends CustomerAddressState {
  final String message;

  const PutAddressLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}
