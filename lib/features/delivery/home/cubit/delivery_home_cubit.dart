import 'package:flutter_bloc/flutter_bloc.dart';
import 'delivery_home_state.dart';
import '../../../../core/models/delivery_model.dart';
import '../../../../data/fake_data.dart';

class DeliveryHomeCubit extends Cubit<DeliveryHomeState> {
  DeliveryHomeCubit() : super(DeliveryHomeState(availableDeliveries: fakeAvailableDeliveries));

  // Toggle online status
  void toggleOnline(bool value) {
    emit(state.copyWith(isOnline: value));
  }

  // Accept order
  void acceptOrder(DeliveryModel delivery) {
    // Update delivery status locally
    final updatedDeliveries = state.availableDeliveries.map((d) {
      if (d.id == delivery.id) {
        return d.copyWith(status: DeliveryStatus.accepted);
      }
      return d;
    }).toList();

    emit(state.copyWith(availableDeliveries: updatedDeliveries));
  }
}
