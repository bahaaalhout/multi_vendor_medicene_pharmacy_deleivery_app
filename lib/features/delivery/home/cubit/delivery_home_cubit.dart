import 'package:flutter_bloc/flutter_bloc.dart';
import 'delivery_home_state.dart';
import '../../../../data/fake_data.dart';

class DeliveryHomeCubit extends Cubit<DeliveryHomeState> {
  DeliveryHomeCubit() : super(DeliveryHomeState(availableDeliveries: fakeAvailableDeliveries));

  // Toggle online status
  void toggleOnline(bool value) {
    emit(state.copyWith(isOnline: value));
  }
}
