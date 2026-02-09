import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterSuccess extends FilterState {
  final FilterModel model;
  FilterSuccess(this.model);
}
