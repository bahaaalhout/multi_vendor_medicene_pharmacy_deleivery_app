import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/circle_icon_button.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, required this.fun});
  final Function() fun;
  @override
  Widget build(BuildContext context) {
    return CircleIconButton(assetIcon: 'assets/icons/edit.svg', onPressed: fun);
  }
}
