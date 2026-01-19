// base_main_nav_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/base_bottom_navigation_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/bottom_navigation_item.dart';

abstract class BaseMainNavScreen extends StatefulWidget {
  const BaseMainNavScreen({super.key, this.selectedIndex});
  final int? selectedIndex;

  // 👇 You will define these in your actual screen
  List<Widget> get tabScreens;
  List<BottomNavigationItem> get navItems;

  @override
  State<BaseMainNavScreen> createState() => _BaseMainNavScreenState();
}

class _BaseMainNavScreenState extends State<BaseMainNavScreen> {
  late int _currentIndex;
  late final List<Widget> _tabNavigators;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex ?? 0;

    // 👈 Auto-wrap all tab screens in nested navigators automatically
    _tabNavigators = widget.tabScreens.asMap().entries.map((entry) {
      final tabIndex = entry.key;
      final screen = entry.value;
      return Navigator(
        // Unique key per tab to preserve navigation state
        key: GlobalObjectKey<NavigatorState>('tab_$tabIndex'),
        // Default route: show the initial screen for this tab
        onGenerateRoute: (settings) => MaterialPageRoute(builder: (_) => screen),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralNormal,
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _tabNavigators),
          Positioned(
            bottom: AppSizes.spacing16.h,
            left: AppSizes.spacing16.w,
            right: AppSizes.spacing16.w,
            child: SafeArea(
              top: false,
              child: BaseBottomNavigationBar(
                items: widget.navItems,
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}