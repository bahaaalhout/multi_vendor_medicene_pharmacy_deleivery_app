import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/async_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/cubit/delivery_history_state.dart';

class DeliveryHistoryCubit extends Cubit<DeliveryHistoryState> {
  DeliveryHistoryCubit() : super(DeliveryHistoryState.initial());

  void loadHistory() async {
    emit(state.copyWith(
      deliveries: const AsyncState.loading(),
    ));

    try {
      // Filter deliveries that are completed (delivered or confirmed)
      final completedDeliveries = fakeAvailableDeliveries
          .map((delivery) => delivery.copyWith(status: DeliveryStatus.confirmed))
          // .where((delivery) => delivery.isCompleted)
          .toList();

      emit(state.copyWith(
        deliveries: AsyncState.success(completedDeliveries),
      ));
    } catch (e) {
      emit(state.copyWith(
        deliveries: AsyncState.error(e.toString()),
      ));
    }
  }

  void filterByPeriod(HistoryPeriod period) {
    emit(state.copyWith(selectedPeriod: period));
  }
}
