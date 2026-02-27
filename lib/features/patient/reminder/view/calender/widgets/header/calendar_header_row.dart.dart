import 'package:flutter/material.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/add_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';

class CalendarHeaderRow extends StatelessWidget {
  final String title;
  final Future<void> Function() onAdd;

  const CalendarHeaderRow({
    super.key,
    required this.title,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NavigateBackButton(),
        Text(
          title,
          style: AppTextStyles.bold25.copyWith(color: AppColors.primaryDarker),
        ),
        AddButton(fun: onAdd),
      ],
    );
  }
}