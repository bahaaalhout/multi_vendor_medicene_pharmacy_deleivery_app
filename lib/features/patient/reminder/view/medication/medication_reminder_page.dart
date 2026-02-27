import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart' show medicineData;

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/confirm_reminder_args.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/shared_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/sections/medication_header_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/sections/medication_list_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/components/medication_reminder_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/section/selected_medication_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/medication_actions.dart' as act;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

part 'medication_reminder_ui_actions.dart';
class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => MedicationReminderPageState();
}

class MedicationReminderPageState extends State<MedicationReminderPage> {
  MedicationReminderTab tab = MedicationReminderTab.prescriptions;

  final Set<String> selectedIds = {};
  final Map<String, AdjustedScheduleResult> singleOverrides = {};
  AdjustedScheduleResult? multiOverride;

  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: tab.index);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prescriptions = medicineData.where((m) => m.requiresPrescription).toList();
    final recents = medicineData.where((m) => !m.requiresPrescription).toList();

    final selectedMedicines = act.getSelectedMeds(
      selectedIds: selectedIds,
      listA: prescriptions,
      listB: recents,
    );

    return BlocBuilder<ReminderCubit, ReminderStates>(
      builder: (context, state) {
        final cubit = context.read<ReminderCubit>();
        final allReminders = cubit.allReminders;

        final scheduleInfo = getScheduleForMedicines(
          medicines: selectedMedicines,
          reminders: allReminders,
        );

        final effective = resolveEffectiveSchedule(
          selectedIds: selectedIds,
          singleOverrides: singleOverrides,
          multiOverride: multiOverride,
          allMedicines: [...prescriptions, ...recents],
          reminders: allReminders,
        );

        final schedule = effective.isValid ? effective.toAdjusted() : defaultSchedule;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                SizedBox(height: 34.h),

                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: SvgPicture.asset("assets/icons/back.svg"),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Medication Reminder',
                      style: AppTextStyles.bold22.copyWith(
                        color: AppColors.primaryDarker,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Expanded(
                  child: MainFrame(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MedicationHeaderSection(),
                        SizedBox(height: 24.h),

                        MedicationReminderTabs(
                          selected: tab,
                          prescriptionsCount: prescriptions.length,
                          onChanged: (v) async {
                            setState(() => tab = v);
                            await animateToTab(v);
                          },
                        ),

                        SizedBox(height: 12.h),

                        Expanded(
                          child: PageView(
                            controller: pageController,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (index) => setState(() => tab = MedicationReminderTab.values[index]),
                            children: [
                              MedicationListSection(
                                items: prescriptions,
                                selectedIds: selectedIds,
                                reminders: allReminders,
                                onToggleSelect: toggleSelectWithDefault,
                                onSetReminder: (m) => setState(() => selectedIds.add(m.id)),
                              ),
                              MedicationListSection(
                                items: recents,
                                selectedIds: selectedIds,
                                reminders: allReminders,
                                onToggleSelect: toggleSelectWithDefault,
                                onSetReminder: (m) => setState(() => selectedIds.add(m.id)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (selectedMedicines.isNotEmpty) ...[
                  SafeArea(
                    top: false,

                    child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 260.h),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SelectedMedicationsSection(
                          medicines: selectedMedicines,
                          sameSchedule: multiOverride != null || scheduleInfo.sameSchedule,
                          groupTimes: schedule.times,
                          groupDays: schedule.days,
                          groupFrequency: schedule.frequency,
                          singleOverrides: singleOverrides,
                      
                          onRemoveMedicine: (id) => act.removeMedicineWithOverrides(
                            setState: setState,
                            selectedIds: selectedIds,
                            singleOverrides: singleOverrides,
                            multiOverride: multiOverride,
                            setMultiOverride: (v) => multiOverride = v,
                            id: id,
                          ),
                      
                          onClearAll: () => act.clearAllWithOverrides(
                            setState: setState,
                            selectedIds: selectedIds,
                            singleOverrides: singleOverrides,
                            setMultiOverride: (v) => multiOverride = v,
                          ),
                      
                          onCreateReminders: (meds) async {
                            if (meds.isEmpty) return;
                      
                            final hasDifferent = meds.length > 1 && scheduleInfo.sameSchedule == false;
                            if (hasDifferent && multiOverride == null) {
                              final unify = await showUnifyDialog();
                              if (!unify) return;
                              setState(() => multiOverride = schedule);
                            }
                      
                            final args = ConfirmReminderArgs(
                              medicines: meds,
                              schedule: schedule,
                            );
                      
                            final res = await context.push(
                              AppRoutes.confirmReminder,
                              extra: args,
                            );
                      
                            if (res is List<ReminderItem>) {
                              cubit.replaceRemindersForMedicines(
                                res,
                                currentDate: DateTime.now(),
                              );
                      
                              if (!mounted) return;
                              context.pop();
                            }
                          },
                      
                          onAdjustSingle: adjustSingle,
                          onAdjustMulti: (m) => adjustMulti(m),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}