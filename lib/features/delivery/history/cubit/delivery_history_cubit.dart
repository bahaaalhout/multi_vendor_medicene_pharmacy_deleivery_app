import 'package:flutter_bloc/flutter_bloc.dart';
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
    stateUpdater: (newState) => emit(state.copyWith(deliveries: newState)),
  );

  void filterByPeriod(HistoryPeriod period) {
    emit(state.copyWith(selectedPeriod: period));
  }
}
