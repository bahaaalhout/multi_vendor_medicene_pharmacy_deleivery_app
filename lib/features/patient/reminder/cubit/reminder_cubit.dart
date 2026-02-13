import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';

import '../models/reminder_item.dart';
import 'reminder_states.dart';

class ReminderCubit extends Cubit<ReminderStates> {
  // constructor(list of reminders) : super constructor takes initialState
  ReminderCubit(List<ReminderItem> reminders) : super(ReminderInitialState()) {
    allReminders = reminders;
  }

  // all reminders list (source)
  late List<ReminderItem> allReminders;

  // load reminders for specific date
  void loadReminders({DateTime? date}) async {
    emit(ReminderLoadingState());
    try {
      // if date provided -> use it, else use now
      final selectedDate = date ?? DateTime.now();

      // build days strip around selected date
      final days = buildDaysStrip(selectedDate);

      // filter reminders for the selected date
      final dayReminders = filterRemindersByDate(allReminders, selectedDate);

      // 1) update reminder status based on selectedDate + time
      final now = DateTime.now();

      for (final r in dayReminders) {
        // past day -> all completed
        if (_isBeforeDay(selectedDate, now)) {
          r.done = true;
          continue;
        }

        // future day -> all waiting
        if (_isAfterDay(selectedDate, now)) {
          r.done = false;
          continue;
        }

        // today -> compare by time
        final due = _combineDateTime(selectedDate, r.time);
        r.done = !due.isAfter(now); // time passed or equal -> done
      }

      // 2) sort: waiting first, completed last, then by time
      dayReminders.sort((a, b) {
        final sa = a.done ? 1 : 0; // waiting=0, completed=1
        final sb = b.done ? 1 : 0;

        if (sa != sb) return sa.compareTo(sb);

        return _timeToMinutes(a.time).compareTo(_timeToMinutes(b.time));
      });

      emit(
        ReminderSuccessState(
          selectedDate: selectedDate,
          days: days,
          dayReminders: dayReminders,
        ),
      );
    } catch (e) {
      emit(ReminderErrorState(e.toString()));
    }
  }

  // when user click next day icon -> plus one day -> reload
  void nextDayPressed(DateTime currentDate) {
    loadReminders(date: nextDay(currentDate));
  }

  // when user click prev day icon -> minus one day -> reload
  void prevDayPressed(DateTime currentDate) {
    loadReminders(date: prevDay(currentDate));
  }

  // when user click any day on strip -> reload that date
  void selectDay(DateTime currentDate, int dayNumber) {
    final newDate = DateTime(currentDate.year, currentDate.month, dayNumber);
    loadReminders(date: newDate);
  }

  // insert only if not exists
  // returns true if there was any duplicate
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

    loadReminders(date: currentDate);
    return hasDuplicate;
  }

  // Delete all reminders for specific medicines
  void deleteRemindersForMedicines(
    List<MedicineModel> medicines, {
    required DateTime currentDate,
  }) {
    // We match by medicine ID
    final ids = medicines.map((m) => m.id).toSet();

    allReminders.removeWhere((r) => ids.contains(r.medicine.id));

    loadReminders(date: currentDate);
  }
}

// ============================
// Helpers (local to this file)
// ============================

int _timeToMinutes(TimeOfDay t) => (t.hour * 60) + t.minute;

DateTime _combineDateTime(DateTime day, TimeOfDay t) {
  return DateTime(day.year, day.month, day.day, t.hour, t.minute);
}

// compare days only (ignore time)
bool _isBeforeDay(DateTime a, DateTime b) {
  final da = DateTime(a.year, a.month, a.day);
  final db = DateTime(b.year, b.month, b.day);
  return da.isBefore(db);
}

bool _isAfterDay(DateTime a, DateTime b) {
  final da = DateTime(a.year, a.month, a.day);
  final db = DateTime(b.year, b.month, b.day);
  return da.isAfter(db);
}

// define "same reminder" (duplicate)
// recommended: compare medicine + time + days only
bool _sameReminder(ReminderItem a, ReminderItem b) {
  if (a.medicine.id != b.medicine.id) return false;
  if (_timeToMinutes(a.time) != _timeToMinutes(b.time)) return false;

  // compare days as sets
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
