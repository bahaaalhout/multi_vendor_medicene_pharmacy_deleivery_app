import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(FilterModel initialData) : super(FilterInitial()) {
    init(initialData);
  }

  void init(FilterModel initialData) async {
    emit(FilterLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(FilterSuccess(initialData));
  }

  void update(FilterModel newModel) {
    emit(FilterSuccess(newModel));
  }

  void reset() {
    emit(FilterSuccess(FilterModel.initial()));
  }
}
