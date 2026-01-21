import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/upload_button.dart';

class ProductAppbar extends StatelessWidget {
  const ProductAppbar({super.key, required this.title});
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NavigateBackButton(),

        title,
        UploadButton(fun: () {}),
      ],
    );
  }
}
