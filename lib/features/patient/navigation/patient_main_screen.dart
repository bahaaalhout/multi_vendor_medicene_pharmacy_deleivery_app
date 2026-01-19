import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/navigation/base_main_nav_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/screens/home_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/add_reminder_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/screens/profile_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/bottom_navigation_item.dart';

class MainScreen extends BaseMainNavScreen {
  const MainScreen({super.key, super.selectedIndex});

  @override
  List<Widget> get tabScreens => [
    const HomeScreen(),
    const Center(child: Text('Orders')),
    const AddReminderPage(),
    const Center(child: Text('Cart')),
    const ProfileScreen(),
  ];

  @override
  List<BottomNavigationItem> get navItems => [
    BottomNavigationItem(
      activeIcon: 'assets/icons/home_icon.svg',
      label: 'Home',
      tabIndex: 0,
    ),
    BottomNavigationItem(
      activeIcon: 'assets/icons/order.svg',
      label: 'Orders',
      tabIndex: 1,
    ),
    BottomNavigationItem(
      activeIcon: 'assets/icons/reminder.svg',
      label: 'Reminder',
      tabIndex: 2,
    ),
    BottomNavigationItem(
      activeIcon: 'assets/icons/cart.svg',
      label: 'Cart',
      tabIndex: 3,
    ),
    BottomNavigationItem(
      activeIcon: 'assets/icons/profile.svg',
      label: 'Profile',
      tabIndex: 4,
    ),
  ];
}
