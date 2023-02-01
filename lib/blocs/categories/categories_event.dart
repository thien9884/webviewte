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