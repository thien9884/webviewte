import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetCategories extends CategoriesEvent {
  const RequestGetCategories();

  @override
  List<Object?> get props => [];
}

class RequestGetIpad extends CategoriesEvent {
  final int? idIpad;
  const RequestGetIpad({required this.idIpad});

  @override
  List<Object?> get props => [];
}

class RequestGetIphone extends CategoriesEvent {
  final int? idIphone;
  const RequestGetIphone({required this.idIphone});

  @override
  List<Object?> get props => [];
}

class RequestGetMac extends CategoriesEvent {
  final int? idMac;
  const RequestGetMac({required this.idMac});

  @override
  List<Object?> get props => [];
}

class RequestGetAppleWatch extends CategoriesEvent {
  final int? idWatch;
  const RequestGetAppleWatch({required this.idWatch});

  @override
  List<Object?> get props => [];
}

class RequestGetSound extends CategoriesEvent {
  final int? idSound;
  const RequestGetSound({required this.idSound});

  @override
  List<Object?> get props => [];
}

class RequestGetAccessories extends CategoriesEvent {
  final int? idAccessories;
  const RequestGetAccessories({required this.idAccessories});

  @override
  List<Object?> get props => [];
}