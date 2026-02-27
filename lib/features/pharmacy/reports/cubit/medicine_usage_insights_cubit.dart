import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/medicine_usage_insights_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/data/sales_overview_repository.dart';

const _dayLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

class MedicineUsageInsightsCubit extends Cubit<MedicineUsageInsightsState> {
  MedicineUsageInsightsCubit({
    SalesOverviewRepository? repository,
    String? pharmacyId,
  })  : _repository = repository ?? SalesOverviewRepository(),
        _pharmacyId = pharmacyId,
        super(const MedicineUsageInsightsState()) {
    loadData();
  }

  final SalesOverviewRepository _repository;
  final String? _pharmacyId;
  List<OrderModel> _allOrders = [];

  Future<void> loadData() async {
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

  void setPeriod(UsagePeriod period) {
    emit(state.copyWith(selectedPeriod: period));
    _emitFilteredState();
  }

  void _emitFilteredState() {
    final filtered = _filterOrdersByPeriod(_allOrders);
    final topDays = _computeTopDays(filtered);
    final topMedicines = _computeTopMedicinesWithShare(filtered);

    emit(state.copyWith(
      topDays: topDays,
      topMedicines: topMedicines,
      isLoading: false,
    ));
  }

  List<OrderModel> _filterOrdersByPeriod(List<OrderModel> orders) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    switch (state.selectedPeriod) {
      case UsagePeriod.today:
        return orders
            .where((o) =>
                o.createdAt.isAfter(todayStart) ||
                o.createdAt.isAtSameMomentAs(todayStart))
            .toList();
      case UsagePeriod.thisWeek:
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
      case UsagePeriod.thisMonth:
        final monthStart = DateTime(now.year, now.month, 1);
        final monthEnd = DateTime(now.year, now.month + 1, 1);
        return orders
            .where((o) =>
                !o.createdAt.isBefore(monthStart) &&
                o.createdAt.isBefore(monthEnd))
            .toList();
    }
  }

  /// Returns top 4 days by order count (descending)
  List<TopDayData> _computeTopDays(List<OrderModel> orders) {
    final counts = List.filled(7, 0);
    final now = DateTime.now();

    switch (state.selectedPeriod) {
      case UsagePeriod.today:
        for (final o in orders) {
          if (o.createdAt.day == now.day &&
              o.createdAt.month == now.month &&
              o.createdAt.year == now.year) {
            counts[now.weekday - 1]++;
          }
        }
        break;
      case UsagePeriod.thisWeek:
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekStartMidnight = DateTime(
          weekStart.year,
          weekStart.month,
          weekStart.day,
        );
        for (final o in orders) {
          final diff = o.createdAt.difference(weekStartMidnight).inDays;
          if (diff >= 0 && diff < 7) counts[diff]++;
        }
        break;
      case UsagePeriod.thisMonth:
        final dayCounts = <int, int>{};
        for (final o in orders) {
          if (o.createdAt.month == now.month && o.createdAt.year == now.year) {
            final weekday = o.createdAt.weekday;
            dayCounts[weekday] = (dayCounts[weekday] ?? 0) + 1;
          }
        }
        final sorted = dayCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        return sorted
            .take(4)
            .map((e) => TopDayData(
                  dayLabel: _dayLabels[e.key - 1],
                  orderCount: e.value,
                ))
            .toList();
    }

    final dayCountList = <TopDayData>[];
    for (var i = 0; i < 7; i++) {
      dayCountList.add(TopDayData(
        dayLabel: _dayLabels[i],
        orderCount: counts[i],
      ));
    }
    dayCountList.sort((a, b) => b.orderCount.compareTo(a.orderCount));
    return dayCountList.take(4).toList();
  }

  List<MedicineWithShare> _computeTopMedicinesWithShare(
      List<OrderModel> orders) {
    final Map<String, _MedicineCount> map = {};
    var totalItems = 0;
    for (final order in orders) {
      for (final item in order.items) {
        totalItems += item.quantity;
        final med = item.pharmacyOffer.medicine;
        final key = med.id;
        if (map.containsKey(key)) {
          final existing = map[key]!;
          map[key] = _MedicineCount(
            medicine: med,
            orderCount: existing.orderCount + item.quantity,
          );
        } else {
          map[key] = _MedicineCount(
            medicine: med,
            orderCount: item.quantity,
          );
        }
      }
    }
    if (totalItems == 0) return [];
    return map.values
        .map((e) => MedicineWithShare(
              medicine: e.medicine,
              orderCount: e.orderCount,
              sharePercent: (e.orderCount / totalItems) * 100,
            ))
        .toList()
      ..sort((a, b) => b.orderCount.compareTo(a.orderCount));
  }
}

class _MedicineCount {
  final MedicineModel medicine;
  final int orderCount;
  _MedicineCount({required this.medicine, required this.orderCount});
}
