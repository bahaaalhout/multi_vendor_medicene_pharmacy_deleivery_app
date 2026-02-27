import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/low_stock_trends_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/data/low_stock_repository.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/models/low_stock_alert_model.dart';

class LowStockTrendsCubit extends Cubit<LowStockTrendsState> {
  LowStockTrendsCubit({
    LowStockRepository? repository,
  })  : _repository = repository ?? LowStockRepository(),
        super(const LowStockTrendsState()) {
    loadAlerts();
  }

  final LowStockRepository _repository;

  Future<void> loadAlerts() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final alerts = await _repository.getLowStockAlerts();
      final urgent = alerts
          .where((a) => a.daysUntilOutOfStock != null && a.daysUntilOutOfStock! > 0)
          .toList()
        ..sort((a, b) =>
            (a.daysUntilOutOfStock ?? 999)
                .compareTo(b.daysUntilOutOfStock ?? 999));

      emit(state.copyWith(
        alerts: alerts,
        urgentAlert: urgent.isNotEmpty ? urgent.first : null,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
