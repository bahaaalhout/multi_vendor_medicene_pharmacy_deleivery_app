import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/date_time_utils.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/storage/reminder_local_storage.dart';

class ReminderCubit extends Cubit<ReminderStates> {
  ReminderCubit(List<ReminderItem> reminders) : super(ReminderInitialState()) {
    allReminders = reminders;
  }

  final ReminderLocalStorage _storage = ReminderLocalStorage();
  late List<ReminderItem> allReminders;

  Future<void> initLocal({required List<MedicineModel> allMedicines}) async {
    try {
      allReminders = await _storage.loadReminders(allMedicines: allMedicines);
    } catch (_) {
      allReminders = [];
      await _storage.clear();
    }
  }

  Future<void> _persist() async {
    await _storage.saveReminders(allReminders);
  }

  void clearAllReminders({required DateTime currentDate}) {
    allReminders.clear();
    unawaited(_persist());
    loadReminders(date: currentDate);
  }

  void setReminders(
    List<ReminderItem> newList, {
    required DateTime currentDate,
  }) {
    allReminders = List<ReminderItem>.from(newList);
    unawaited(_persist());
    loadReminders(date: currentDate);
  }

  void replaceWithDefaults(
    List<ReminderItem> defaults, {
    required DateTime currentDate,
  }) {
    setReminders(defaults, currentDate: currentDate);
  }

  void loadReminders({DateTime? date}) async {
    emit(ReminderLoadingState());

    try {
      final selectedDate = dateOnly(date ?? DateTime.now());
      final daysStrip = buildDaysStrip(selectedDate);
      final dayReminders = filterRemindersByDate(allReminders, selectedDate);

      final now = DateTime.now();

      for (final r in dayReminders) {
        if (isBeforeDay(selectedDate, now)) {
          r.done = true;
          continue;
        }

        if (isAfterDay(selectedDate, now)) {
          r.done = false;
          continue;
        }

        final due = combineDateTime(selectedDate, r.time);
        r.done = !due.isAfter(now);
      }

      dayReminders.sort((a, b) {
        final sa = a.done ? 1 : 0;
        final sb = b.done ? 1 : 0;
        if (sa != sb) return sa.compareTo(sb);
        return timeToMinutes(a.time).compareTo(timeToMinutes(b.time));
      });

      emit(
        ReminderSuccessState(
          selectedDate: selectedDate,
          days: daysStrip,
          dayReminders: dayReminders,
        ),
      );
    } catch (e) {
      emit(ReminderErrorState(e.toString()));
    }
  }

  // Week navigation (used by Week view)
  void nextWeekPressed(DateTime currentDate) {
    loadReminders(date: nextWeek(currentDate));
  }

  void prevWeekPressed(DateTime currentDate) {
    loadReminders(date: prevWeek(currentDate));
  }

  // Day selection from strip
  void selectDay(DateTime currentDate, int dayNumber) {
    final newDate = DateTime(currentDate.year, currentDate.month, dayNumber);
    loadReminders(date: newDate);
  }

  bool upsertMany(
    List<ReminderItem> incoming, {
    required DateTime currentDate,
  }) {
    var hasDuplicate = false;

    for (final r in incoming) {
      final exists = allReminders.any((x) => _sameReminder(x, r));
      if (exists) {
        hasDuplicate = true;
        continue;
      }
      allReminders.add(r);
    }

    unawaited(_persist());
    loadReminders(date: currentDate);
    return hasDuplicate;
  }
void deleteSingleReminder(ReminderItem item, {required DateTime currentDate}) {
  allReminders.removeWhere((r) => _sameReminder(r, item));
  unawaited(_persist());
  loadReminders(date: currentDate);
}
  void deleteRemindersForMedicines(
    List<MedicineModel> medicines, {
    required DateTime currentDate,
  }) {
    final ids = medicines.map((m) => m.id).toSet();
    allReminders.removeWhere((r) => ids.contains(r.medicine.id));
    unawaited(_persist());
    loadReminders(date: currentDate);
  }

  void replaceRemindersForMedicines(
    List<ReminderItem> incoming, {
    required DateTime currentDate,
  }) {
    if (incoming.isEmpty) {
      loadReminders(date: currentDate);
      return;
    }

    final ids = incoming.map((r) => r.medicine.id).toSet();
    allReminders.removeWhere((r) => ids.contains(r.medicine.id));

    for (final r in incoming) {
      final exists = allReminders.any((x) => _sameReminder(x, r));
      if (!exists) allReminders.add(r);
    }

    unawaited(_persist());
    loadReminders(date: currentDate);
  }

  bool hasAnyReminderForMedicines(List<MedicineModel> meds) {
    final ids = meds.map((m) => m.id).toSet();
    return allReminders.any((r) => ids.contains(r.medicine.id));
  }

  void replaceForMedicines({
    required List<MedicineModel> medicines,
    required List<ReminderItem> newReminders,
    required DateTime currentDate,
  }) {
    final ids = medicines.map((m) => m.id).toSet();
    allReminders.removeWhere((r) => ids.contains(r.medicine.id));
    allReminders.addAll(newReminders);

    unawaited(_persist());
    loadReminders(date: currentDate);
  }
}

bool _sameReminder(ReminderItem a, ReminderItem b) {
  if (a.medicine.id != b.medicine.id) return false;
  if (timeToMinutes(a.time) != timeToMinutes(b.time)) return false;
  return _sameIntSet(a.days, b.days);
}

bool _sameIntSet(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  final sa = {...a};
  final sb = {...b};
  if (sa.length != sb.length) return false;
  for (final v in sa) {
    if (!sb.contains(v)) return false;
  }
  return true;
}