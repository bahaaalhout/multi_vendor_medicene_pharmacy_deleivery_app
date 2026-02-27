
part of 'medication_reminder_page.dart';
const defaultSchedule = AdjustedScheduleResult(
  times: ['8:00 AM'],
  days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  frequency: 'Daily',
);

extension MedicationReminderPageActions on MedicationReminderPageState {
  Future<void> animateToTab(MedicationReminderTab t) async {
    if (!pageController.hasClients) return;
    await pageController.animateToPage(
      t.index,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  void toggleSelectWithDefault(String id) {
    setState(() {
      if (selectedIds.remove(id)) {
        singleOverrides.remove(id);
        if (selectedIds.length < 2) multiOverride = null;
      } else {
        selectedIds.add(id);
        singleOverrides.putIfAbsent(id, () => defaultSchedule);
      }
    });
  }

  Future<bool> showUnifyDialog() async {
    final res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Different schedules'),
        content: const Text(
          'Selected medications have different reminder schedules.\n\n'
          'Do you want to unify them and continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text('Unify'),
          ),
        ],
      ),
    );
    return res == true;
  }

  Future<void> adjustSingle(MedicineModel med) async {
    final res = await act.openAdjustBottomSheet(
      context: context,
      selected: [med],
      title: 'Adjust reminder',
      subtitle: 'Single medication',
      sameSchedule: true,
      times: defaultSchedule.times,
      days: defaultSchedule.days,
      frequency: defaultSchedule.frequency,
      showRemoveInSelectedCard: false,
    );

    if (res != null) setState(() => singleOverrides[med.id] = res);
  }

  Future<void> adjustMulti(List<MedicineModel> meds) async {
    final base = defaultSchedule;

    final res = await act.openAdjustBottomSheet(
      context: context,
      selected: meds,
      title: 'Adjust reminder',
      subtitle: 'Multiple medications',
      sameSchedule: true,
      times: multiOverride?.times ?? base.times,
      days: multiOverride?.days ?? base.days,
      frequency: multiOverride?.frequency ?? base.frequency,
      showRemoveInSelectedCard: false,
      showDaysInSelectedCard: false,
    );

    if (res != null) setState(() => multiOverride = res);
  }
}