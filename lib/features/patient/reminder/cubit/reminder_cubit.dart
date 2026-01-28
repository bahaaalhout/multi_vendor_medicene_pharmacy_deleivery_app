import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/date_time_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_filter.dart';
import '../models/reminder_item.dart';
import 'reminder_states.dart';

class ReminderCubit extends Cubit<ReminderStates> {
  //constructor(list of reminders) : super constructor takes intialState
  ReminderCubit(List<ReminderItem> reminders) : super(ReminderInitialState()) {
    allReminders = reminders;
  }

  //all reminders list (source)
  late List<ReminderItem> allReminders;

  //load reminders for specific date
  void loadReminders({DateTime? date}) async {
    //loading state
    emit(ReminderLoadingState());
    try {
      //if you give me date (use it), if not set newdate(now)
      final selectedDate = date ?? DateTime.now();

      //build daystrip from the date above (days around date)
      final days = buildDaysStrip(selectedDate);

      //do filtering for all reminders based on selected date
      final dayReminders = filterRemindersByDate(allReminders, selectedDate);

      //return result to ui screen(success state)
      emit(
        ReminderSuccessState(
          selectedDate: selectedDate,
          days: days,
          dayReminders: dayReminders,
        ),
      );
    } catch (e) {
      //if there's a problem (error state)
      emit(ReminderErrorState(e.toString()));
    }
  }

  //when user click next day icon -> plus one day -> reload
  void nextDayPressed(DateTime currentDate) {
    loadReminders(date: nextDay(currentDate));
  }

  //when user click prev day icon -> minus one day -> reload
  void prevDayPressed(DateTime currentDate) {
    loadReminders(date: prevDay(currentDate));
  }

  //when user click any day on strip -> focus same month/year but new day -> reload
  void selectDay(DateTime currentDate, int dayNumber) {
    final newDate = DateTime(currentDate.year, currentDate.month, dayNumber);
    loadReminders(date: newDate);
  }

  //when user add new reminder -> add to list -> reload current day
  void addReminder(ReminderItem item, DateTime currentDate) {
    allReminders.add(item);
    loadReminders(date: currentDate);
  }
}
