import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/models/low_stock_alert_model.dart';

class LowStockTrendsState {
  final List<LowStockAlertModel> alerts;
  final LowStockAlertModel? urgentAlert;
  final bool isLoading;
  final String? errorMessage;

  const LowStockTrendsState({
    this.alerts = const [],
    this.urgentAlert,
    this.isLoading = false,
    this.errorMessage,
  });

  LowStockTrendsState copyWith({
    List<LowStockAlertModel>? alerts,
    LowStockAlertModel? urgentAlert,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LowStockTrendsState(
      alerts: alerts ?? this.alerts,
      urgentAlert: urgentAlert,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
