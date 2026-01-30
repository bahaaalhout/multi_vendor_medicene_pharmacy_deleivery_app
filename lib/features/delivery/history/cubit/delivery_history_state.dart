import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/async_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';

part 'delivery_history_state.freezed.dart';

@freezed
abstract class DeliveryHistoryState with _$DeliveryHistoryState {
  const factory DeliveryHistoryState({
    @Default(AsyncState.initial()) AsyncState<List<DeliveryModel>> deliveries,
    @Default(HistoryPeriod.all) HistoryPeriod selectedPeriod,
    @Default([]) List<DeliveryModel> filteredDeliveries,
  }) = _DeliveryHistoryState;

  factory DeliveryHistoryState.initial() => const DeliveryHistoryState();
}

enum HistoryPeriod {
  all('All'),
  today('Today'),
  thisWeek('This Week'),
  thisMonth('This Month');

  const HistoryPeriod(this.label);
  final String label;
}
