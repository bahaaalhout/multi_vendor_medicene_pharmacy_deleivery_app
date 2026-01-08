import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottonNavBarItem extends StatelessWidget {
  const CustomBottonNavBarItem({
    super.key,

    required this.tabIndex,
    required this.index,
    required this.activeIcon,

    required this.label,
    required this.onTap,
  });
  final void Function()? onTap;
  final int tabIndex;
  final int index;
  final String activeIcon;

  final String label;

  @override
  Widget build(BuildContext context) {
    bool isIndexTwo = tabIndex == 2;
    Widget iconTab = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          activeIcon,
          color: Colors.black,
          width: isIndexTwo ? 24.w : 18.w,
          height: isIndexTwo ? 27.h : 18.h,
        ),

        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: tabIndex == 2 ? FontWeight.w800 : FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: onTap,
      child: index == tabIndex
          ? Container(
              width: tabIndex == 2 ? 64.w : 56.w,
              height: tabIndex == 2 ? 64.h : 56.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: tabIndex <= 2
                      ? Radius.circular(16)
                      : Radius.circular(8),
                  bottomRight: tabIndex <= 2
                      ? Radius.circular(8)
                      : Radius.circular(16),
                  topLeft: tabIndex <= 2
                      ? Radius.circular(16)
                      : Radius.circular(8),
                  topRight: tabIndex <= 2
                      ? Radius.circular(8)
                      : Radius.circular(16),
                ),
              ),
              child: iconTab,
            )
          : iconTab,
    );
  }
}
