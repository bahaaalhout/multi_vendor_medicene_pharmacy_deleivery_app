import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/navigation/patient_bottom_nav_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/screens/home_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/add_reminder_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.selectedIndex});
  final int? selectedIndex;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  late final List<Widget> data;

  @override
  void initState() {
    super.initState();
    index = widget.selectedIndex ?? 0;

    data = [
      const HomeScreen(),
      const Center(child: Text('order page')),
      const AddReminderPage(),
      const Center(child: Text('cart page')),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralNormal,
      body: Stack(
        children: [
          data[index],

          Positioned(
            bottom: 27,
            left: 24,
            right: 24,
            child: Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.neutralNormal,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PatientBottonNavBarItem(
                    tabIndex: 0,
                    index: index,
                    activeIcon: 'assets/icons/home_icon.svg',

                    label: 'Home',
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                  ),
                  PatientBottonNavBarItem(
                    tabIndex: 1,
                    index: index,
                    activeIcon: 'assets/icons/order.svg',

                    label: 'Orders',
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                  ),
                  PatientBottonNavBarItem(
                    tabIndex: 2,
                    index: index,
                    activeIcon: 'assets/icons/reminder.svg',

                    label: 'Reminder',
                    onTap: () {
                      setState(() {
                        index = 2;
                      });
                    },
                  ),
                  PatientBottonNavBarItem(
                    tabIndex: 3,
                    index: index,
                    activeIcon: 'assets/icons/cart.svg',

                    label: 'Cart',
                    onTap: () {
                      setState(() {
                        index = 3;
                      });
                    },
                  ),
                  PatientBottonNavBarItem(
                    tabIndex: 4,
                    index: index,
                    activeIcon: 'assets/icons/profile.svg',

                    label: 'Profile',
                    onTap: () {
                      setState(() {
                        index = 4;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
