import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StyledContainer extends StatelessWidget {
  const StyledContainer({
    super.key,
    this.assetName,
    this.border,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.containerColor,
    required this.text,
    required this.textStyle,
  });
  final double horizontalPadding;
  final double verticalPadding;
  final Color containerColor;
  final String text;
  final BoxBorder? border;
  final String? assetName;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: containerColor,
        border: border,
      ),
      alignment: Alignment.center,
      child: assetName == null
          ? Text(text, style: textStyle)
          : Row(
              children: [
                SvgPicture.asset(assetName!, width: 12.w, height: 12.h),
                4.horizontalSpace,
                Text(text, style: textStyle),
              ],
            ),
    );
  }
}
