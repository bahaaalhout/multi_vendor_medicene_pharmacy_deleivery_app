// Your new main nav screen is now ~25 lines of code!
import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/navigation/base_main_nav_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/screens/delivery_home_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/bottom_navigation_item.dart';

class DeliveryMainScreen extends BaseMainNavScreen {
  const DeliveryMainScreen({super.key, super.selectedIndex});

  @override
  List<Widget> get tabScreens => [
    const DeliveryHomeScreen(),
    const Center(child: Text('History')),
    const Center(child: Text('Deliveries')),
    const Center(child: Text('Profile')),
  ];

  @override
  List<BottomNavigationItem> get navItems => [
    BottomNavigationItem(
      activeIcon: 'assets/icons/home_icon.svg',
      label: 'Home',
      tabIndex: 0,
    ),
    BottomNavigationItem(
      activeIcon: 'assets/icons/history.svg',
      label: 'History',
      tabIndex: 1,
    ),
    BottomNavigationItem(
      activeIcon: 'assets/icons/delivery.svg',
      label: 'Deliveries',
      tabIndex: 2,
    ),
    BottomNavigationItem(
      activeIcon: 'assets/icons/profile.svg',
      label: 'Profile',
      tabIndex: 3,
    ),
  ];
}