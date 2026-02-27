import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/sales_overview_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/data/sales_overview_repository.dart';

class SalesOverviewCubit extends Cubit<SalesOverviewState> {
  SalesOverviewCubit({
    SalesOverviewRepository? repository,
    String? pharmacyId,
  })  : _repository = repository ?? SalesOverviewRepository(),
        _pharmacyId = pharmacyId,
        super(const SalesOverviewState()) {
    loadSalesData();
  }

  final SalesOverviewRepository _repository;
  final String? _pharmacyId;

  List<OrderModel> _allOrders = [];

  Future<void> loadSalesData() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      _allOrders = await _repository.getPharmacyOrders(pharmacyId: _pharmacyId);
      _emitFilteredState();
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void setPeriod(SalesPeriod period) {
    emit(state.copyWith(selectedPeriod: period));
    _emitFilteredState();
  }

  void _emitFilteredState() {
    final filtered = _filterOrdersByPeriod(_allOrders);
    final dailyCounts = _computeDailyOrderCounts(filtered);
    final topMedicines = _computeTopMedicines(filtered);
    final totalOrders = dailyCounts.reduce((a, b) => a + b);

    emit(state.copyWith(
      dailyOrderCounts: dailyCounts,
      topMedicines: topMedicines,
      totalOrders: totalOrders,
      isLoading: false,
    ));
  }

  List<OrderModel> _filterOrdersByPeriod(List<OrderModel> orders) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    switch (state.selectedPeriod) {
      case SalesPeriod.today:
        return orders
            .where((o) =>
                o.createdAt.isAfter(todayStart) ||
                o.createdAt.isAtSameMomentAs(todayStart))
            .toList();
      case SalesPeriod.thisWeek:
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekStartMidnight = DateTime(
          weekStart.year,
          weekStart.month,
          weekStart.day,
        );
        final weekEnd = weekStartMidnight.add(const Duration(days: 7));
        return orders
            .where((o) =>
                !o.createdAt.isBefore(weekStartMidnight) &&
                o.createdAt.isBefore(weekEnd))
            .toList();
      case SalesPeriod.thisMonth:
        final monthStart = DateTime(now.year, now.month, 1);
        final monthEnd = DateTime(now.year, now.month + 1, 1);
        return orders
            .where((o) =>
                !o.createdAt.isBefore(monthStart) &&
                o.createdAt.isBefore(monthEnd))
            .toList();
    }
  }

  /// Returns [mon, tue, wed, thu, fri, sat, sun] order counts
  List<int> _computeDailyOrderCounts(List<OrderModel> orders) {
    final counts = List.filled(7, 0);
    final now = DateTime.now();

    int weekStartOffset;
    DateTime referenceDate;
    switch (state.selectedPeriod) {
      case SalesPeriod.today:
        referenceDate = now;
        for (final o in orders) {
          if (o.createdAt.day == now.day &&
              o.createdAt.month == now.month &&
              o.createdAt.year == now.year) {
            final idx = now.weekday - 1;
            counts[idx]++;
          }
        }
        return counts;
      case SalesPeriod.thisWeek:
        weekStartOffset = now.weekday - 1;
        referenceDate = now.subtract(Duration(days: weekStartOffset));
        break;
      case SalesPeriod.thisMonth:
        referenceDate = now.subtract(const Duration(days: 6));
        for (var i = 0; i < 7; i++) {
          final d = referenceDate.add(Duration(days: i));
          counts[i] = orders
              .where((o) =>
                  o.createdAt.day == d.day &&
                  o.createdAt.month == d.month &&
                  o.createdAt.year == d.year)
              .length;
        }
        return counts;
    }

    for (final o in orders) {
      final diff = o.createdAt.difference(referenceDate).inDays;
      if (diff >= 0 && diff < 7) {
        counts[diff]++;
      }
    }
    return counts;
  }

  List<TopMedicine> _computeTopMedicines(List<OrderModel> orders) {
    final Map<String, _MedicineCount> map = {};
    for (final order in orders) {
      for (final item in order.items) {
        final med = item.pharmacyOffer.medicine;
        final key = med.id;
        if (map.containsKey(key)) {
          final existing = map[key]!;
          map[key] = _MedicineCount(
            medicine: med,
            orderCount: existing.orderCount + 1,
          );
        } else {
          map[key] = _MedicineCount(medicine: med, orderCount: 1);
        }
      }
    }
    return map.values
        .map((e) => TopMedicine(medicine: e.medicine, orderCount: e.orderCount))
        .toList()
      ..sort((a, b) => b.orderCount.compareTo(a.orderCount));
  }
}

class _MedicineCount {
  final MedicineModel medicine;
  final int orderCount;
  _MedicineCount({required this.medicine, required this.orderCount});
}
