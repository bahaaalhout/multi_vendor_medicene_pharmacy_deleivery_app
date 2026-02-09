import 'package:flutter_bloc/flutter_bloc.dart';
import 'delivery_order_state.dart';
import '../../../../core/models/delivery_model.dart';

class DeliveryOrderCubit extends Cubit<DeliveryOrderState> {
  DeliveryOrderCubit(DeliveryModel delivery) 
    : super(DeliveryOrderState(delivery: delivery));

  // Toggle product details visibility
  void toggleProductDetails() {
    emit(state.copyWith(showProductDetails: !state.showProductDetails));
  }

  // Advance to next valid status using enum index
  void advanceDeliveryStatus() {
    final nextStatus = state.delivery.getNextStatus();
    if (nextStatus != null) {
      final updatedDelivery = state.delivery.copyWith(status: nextStatus);
      emit(state.copyWith(delivery: updatedDelivery));
    }
  }
}
