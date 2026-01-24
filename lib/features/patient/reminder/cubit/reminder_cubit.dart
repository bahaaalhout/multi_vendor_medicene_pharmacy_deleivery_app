import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/reminder_filter.dart';
import '../models/reminder_item.dart';
import 'reminder_states.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/helpers.dart';

class ReminderCubit extends Cubit<ReminderStates> {
  //constructor(list of reminders) : super constructor takes intialState
  ReminderCubit(List<ReminderItem> reminders) : super(ReminderInitialState()) {
    allReminders = reminders;
  }

  //load reminders to date that i gave for you
  late List<ReminderItem> allReminders;
  void loadReminders({DateTime? date}) async {
    //loading state
    emit(ReminderLoadingState());
    try {
      //if you give me date (use it), if not set newdate(now)
      final selectedDate = date ?? DateTime.now();
      //build daystrip from the date above(days around that's date - M T W T F S S)
      final days = buildDaysStrip(selectedDate);
      //do filtering for all reminders into(all-rate-reminders-rate) based date (for each date his reminders)
      final dayReminders = filterRemindersByDate(allReminders, selectedDate);

      //return result to ui screen(success state)
      emit(
        ReminderSuccessState(
          selectedDate: selectedDate,
          days: days,
          dayReminders: dayReminders,
        ),
      );
      //or if there's a problem (error state)
    } catch (e) {
      emit(ReminderErrorState(e.toString()));
    }
  }

  //when user click on next day icon ->take the current date and plus one day on it
  // ->then call load state to load the new day reminders
  void nextDayPressed(DateTime currentDate) {
    //loadReminders(date: currentDate.add(const Duration(days: 1)));
    loadReminders(date: nextDay(currentDate));
  }

  //when user click on prev day icon ->take the current date and minus one day on it
  // ->then call load state to load the new day reminders
  void prevDayPressed(DateTime currentDate) {
    //loadReminders(date: currentDate.subtract(const Duration(days: 1)));
    loadReminders(date: prevDay(currentDate));
  }

  //when user click on any day on the strip ->create new date have the same date details that user click it(focus -> same year-same month-but not the same day!!)
  // ->then call load state to load the new day reminders
  void selectDay(DateTime currentDate, int dayNumber) {
    final newDate = DateTime(currentDate.year, currentDate.month, dayNumber);
    loadReminders(date: newDate);
  }

  //when user want to add new reminder in any date add his reminder item to reminders list then call load state to load reminders in the day that the user on it
  void addReminder(ReminderItem item, DateTime currentDate) {
    allReminders.add(item);
    loadReminders(date: currentDate);
  }
}
