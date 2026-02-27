import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/orders_repository.dart';
import 'orders_details_state.dart';

class OrdersDetailsCubit extends Cubit<OrdersDetailsState> {
  OrdersDetailsCubit() : super(const OrdersDetailsInitial());

  Future<void> fetchDetails(int id) async {
    emit(const OrdersDetailsLoading());

    try {
      final details = await OrdersRepository.fetchOrderDetails(id);
      emit(OrdersDetailsSuccess(details));
    } catch (e) {
      log('fetchDetails error: $e');
      emit(const OrdersDetailsError('Failed to load order details'));
    }
  }

  Future<void> cancelOrder(int id) async {
    try {
      await OrdersRepository.cancelOrder(id);
      await fetchDetails(id);
    } catch (e) {
      log('cancelOrder error: $e');
      emit(const OrdersDetailsError('Failed to cancel order'));
    }
  }
}