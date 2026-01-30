import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/async_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/async_cubit_extensions.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/cubit/delivery_history_state.dart';

class DeliveryHistoryCubit extends Cubit<DeliveryHistoryState> {
  DeliveryHistoryCubit() : super(DeliveryHistoryState.initial());

  void loadHistory() => tryExecute(
    call: () async {
      //api call should be here
      return fakeAvailableDeliveries
          .map((delivery) => delivery.copyWith(status: DeliveryStatus.confirmed))
          // .where((delivery) => delivery.isCompleted)
          .toList();
    },
    stateUpdater: (newState) => emit(state.copyWith(
      deliveries: newState,
      filteredDeliveries: newState.data ?? [],
    )),
  );

  void filterByPeriod(HistoryPeriod period) {
    emit(state.copyWith(selectedPeriod: period));
    
    // Get the original deliveries from the state
    final originalDeliveries = state.deliveries.data;
    
    if (originalDeliveries != null) {
      final filtered = _filterDeliveriesByPeriod(originalDeliveries, period);
      emit(state.copyWith(filteredDeliveries: filtered));
    }
  }

  List<DeliveryModel> _filterDeliveriesByPeriod(List<DeliveryModel> deliveries, HistoryPeriod period) {
    final now = DateTime.now();
    
    return deliveries.where((delivery) {
      final deliveryDate = delivery.order.createdAt;
      
      switch (period) {
        case HistoryPeriod.all:
          return true;
        case HistoryPeriod.today:
          return _isSameDay(deliveryDate, now);
        case HistoryPeriod.thisWeek:
          return _isSameWeek(deliveryDate, now);
        case HistoryPeriod.thisMonth:
          return _isSameMonth(deliveryDate, now);
      }
    }).toList();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  bool _isSameWeek(DateTime date1, DateTime date2) {
    final weekStart1 = _getWeekStart(date1);
    final weekStart2 = _getWeekStart(date2);
    return weekStart1.difference(weekStart2).inDays == 0;
  }

  bool _isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  DateTime _getWeekStart(DateTime date) {
    // Assuming week starts on Sunday
    return date.subtract(Duration(days: date.weekday - 1));
  }
}