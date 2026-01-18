import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class StyledText extends StatelessWidget {
  const StyledText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bold22.copyWith(
        color: Color(0xff17234D), //need to set static color
      ),
    );
  }
}
