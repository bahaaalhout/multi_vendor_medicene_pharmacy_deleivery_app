import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';

class ActionButton extends StatelessWidget {
  final DeliveryStatus status;
  final VoidCallback onAccept;
  final VoidCallback onStart;

  const ActionButton({
    super.key,
    required this.status,
    required this.onAccept,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getButtonConfig();

    return Container(
      padding: EdgeInsets.all(AppSizes.spacing16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralNormal),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Column(
        children: [
          Text(
            config.noticeText,
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.neutralDarkHover,
            ),
          ),
          SizedBox(height: AppSizes.spacing16.h),

          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: config.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDarkActive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                ),
              ),
              child: Text(
                config.buttonText,
                style: AppTextStyles.semiBold16.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonConfig _getButtonConfig() {
    switch (status) {
      case DeliveryStatus.accepted:
        return ButtonConfig(
          buttonText: 'Accept Order',
          noticeText: 'By agreeing now to deliver this order, you will be required to wait for a completion notification from the pharmacy.',
          onPressed: onAccept,
        );
      case DeliveryStatus.pickedUp:
        return ButtonConfig(
          buttonText: 'Start Delivery',
          noticeText: 'Confirming the order now will change its status to "On the way" to the customer\'s location.',
          onPressed: onStart,
        );
      default:
        return ButtonConfig(
          buttonText: '',
          noticeText: '',
          onPressed: () {},
        );
    }
  }
}

class ButtonConfig {
  final String buttonText;
  final String noticeText;
  final VoidCallback onPressed;

  ButtonConfig({
    required this.buttonText,
    required this.noticeText,
    required this.onPressed,
  });
}
