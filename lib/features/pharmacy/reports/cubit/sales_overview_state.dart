import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

enum SalesPeriod { today, thisWeek, thisMonth }

class TopMedicine {
  final MedicineModel medicine;
  final int orderCount;

  const TopMedicine({
    required this.medicine,
    required this.orderCount,
  });

  String get displayName => '${medicine.genericName} ${medicine.strength}';
}

class SalesOverviewState {
  final SalesPeriod selectedPeriod;
  final List<int> dailyOrderCounts;
  final List<TopMedicine> topMedicines;
  final int totalOrders;
  final bool isLoading;
  final String? errorMessage;

  const SalesOverviewState({
    this.selectedPeriod = SalesPeriod.thisWeek,
    this.dailyOrderCounts = const [],
    this.topMedicines = const [],
    this.totalOrders = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  SalesOverviewState copyWith({
    SalesPeriod? selectedPeriod,
    List<int>? dailyOrderCounts,
    List<TopMedicine>? topMedicines,
    int? totalOrders,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SalesOverviewState(
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      dailyOrderCounts: dailyOrderCounts ?? this.dailyOrderCounts,
      topMedicines: topMedicines ?? this.topMedicines,
      totalOrders: totalOrders ?? this.totalOrders,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  static const periodLabels = ['Today', 'This Week', 'This Month'];
  String get periodLabel => periodLabels[selectedPeriod.index];
}
