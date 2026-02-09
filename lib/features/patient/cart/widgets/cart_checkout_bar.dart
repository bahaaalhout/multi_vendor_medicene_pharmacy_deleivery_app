import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/info_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';

class CartCheckoutBar extends StatelessWidget {
  const CartCheckoutBar({
    super.key,
    required this.infoButtonOnPressed,
    required this.title,
    required this.subTitle,
  });
  final Function() infoButtonOnPressed;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NavigateBackButton(),
        Column(
          children: [
            Text(title, style: AppTextStyles.bold24),
            Text(
              subTitle,
              style: AppTextStyles.reqular14.copyWith(
                color: AppColors.secondaryDark,
              ),
            ),
          ],
        ),
        InfoButton(fun: infoButtonOnPressed),
      ],
    );
  }
}
