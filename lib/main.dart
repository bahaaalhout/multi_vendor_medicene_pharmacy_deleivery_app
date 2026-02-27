import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/auth.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/cubit/notifications_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("MAIN STARTED");

  final prefs = await SharedPreferences.getInstance();
  final login = await AuthService().login(
    "pharmacy@test.com",
    "Pharmacy@12345",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ReminderCubit(reminders)..loadReminders(),
          ),
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
