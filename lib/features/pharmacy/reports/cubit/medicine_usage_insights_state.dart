import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

enum UsagePeriod { today, thisWeek, thisMonth }

class TopDayData {
  final String dayLabel;
  final int orderCount;

  const TopDayData({required this.dayLabel, required this.orderCount});
}

class MedicineWithShare {
  final MedicineModel medicine;
  final int orderCount;
  final double sharePercent;

  const MedicineWithShare({
    required this.medicine,
    required this.orderCount,
    required this.sharePercent,
  });

  String get displayName => '${medicine.genericName} ${medicine.strength}';
}

class MedicineUsageInsightsState {
  final UsagePeriod selectedPeriod;
  final List<TopDayData> topDays;
  final List<MedicineWithShare> topMedicines;
  final bool isLoading;
  final String? errorMessage;

  const MedicineUsageInsightsState({
    this.selectedPeriod = UsagePeriod.thisWeek,
    this.topDays = const [],
    this.topMedicines = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  MedicineUsageInsightsState copyWith({
    UsagePeriod? selectedPeriod,
    List<TopDayData>? topDays,
    List<MedicineWithShare>? topMedicines,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MedicineUsageInsightsState(
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      topDays: topDays ?? this.topDays,
      topMedicines: topMedicines ?? this.topMedicines,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  static const periodLabels = ['Today', 'This Week', 'This Month'];
}
