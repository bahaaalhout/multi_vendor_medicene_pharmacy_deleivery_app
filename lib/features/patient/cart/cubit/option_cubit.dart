import 'package:flutter_bloc/flutter_bloc.dart';

class OptionCubit extends Cubit<String?> {
  OptionCubit() : super(null);

  void select(String type) {
    if (state == type) {
      emit(null);
    } else {
      emit(type);
    }
  }
}
