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

  // Accept order (change status to pickedUp)
  void acceptOrder() {
    final updatedDelivery = state.delivery.copyWith(
      status: DeliveryStatus.pickedUp,
    );
    emit(state.copyWith(delivery: updatedDelivery));
  }

  // Start delivery (change status to enRoute)
  void startDelivery() {
    final updatedDelivery = state.delivery.copyWith(
      status: DeliveryStatus.enRoute,
    );
    emit(state.copyWith(delivery: updatedDelivery));
  }

  // Confirm delivery (change status to delivered)
  void confirmDelivery() {
    final updatedDelivery = state.delivery.copyWith(
      status: DeliveryStatus.delivered,
    );
    emit(state.copyWith(delivery: updatedDelivery));
  }
}
