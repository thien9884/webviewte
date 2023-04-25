import 'package:equatable/equatable.dart';

abstract class NewsCategoryEvent extends Equatable {
  const NewsCategoryEvent();

  @override
  List<Object?> get props => [];
}

class RequestGetNewsCategory extends NewsCategoryEvent {
  final int? pageNumber;
  final int? groupId;

  const RequestGetNewsCategory(
      this.pageNumber,
      this.groupId,
      );

  @override
  List<Object?> get props => [];
}
