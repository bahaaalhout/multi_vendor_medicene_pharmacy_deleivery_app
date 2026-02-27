import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/services/auth_service.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/cubit/notifications_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final reminderCubit = ReminderCubit([]);
  await reminderCubit.initLocal(allMedicines: medicineData);
  reminderCubit.loadReminders(date: DateTime.now());

  try {
    final ok = await AuthService().login("patient@test.com", "Patient@12345");
    debugPrint("LOGIN OK? $ok");
  } catch (e) {
    debugPrint("LOGIN ERROR: $e");
  }

  runApp(MyApp(reminderCubit: reminderCubit));
}
class MyApp extends StatelessWidget {
  final ReminderCubit reminderCubit;

  const MyApp({super.key, required this.reminderCubit});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: reminderCubit),
          BlocProvider(
            create: (context) =>
                NotificationsCubit(notifications)..loadNotifications(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Multi Vendor Medicene Pharmacy Deleivery App',
          theme: ThemeData(primaryColor: AppColors.primaryNormal),
          routerConfig: AppPages.router,
        ),
      ),
    );
  }
}