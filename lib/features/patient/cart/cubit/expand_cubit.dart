import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandCubit extends Cubit<bool> {
  ExpandCubit() : super(false);

  void toggle() => emit(!state);

  void expand() => emit(true);

  void collapse() => emit(false);
}
