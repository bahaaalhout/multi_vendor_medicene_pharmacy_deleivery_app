import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/circle_icon_button.dart';

class NavigateBackButton extends StatelessWidget {
  const NavigateBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      assetIcon: 'assets/icons/arrow_left.svg',
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
