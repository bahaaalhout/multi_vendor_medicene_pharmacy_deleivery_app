import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'step_label.dart';
import 'step_node.dart';
import 'step_connector.dart';

class DeliveryProgressStepper extends StatelessWidget {
  final DeliveryModel delivery;

  const DeliveryProgressStepper({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing16.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Progress',
            style: AppTextStyles.bold16.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: AppSizes.spacing16.h),

          Row(
            children: [
              StepLabel(
                label: 'Pickup',
                isActive: delivery.isStepActive(DeliveryStep.pickup),
                isCompleted: delivery.isStepCompleted(DeliveryStep.pickup),
              ),
              StepLabel(
                label: 'On the way',
                isActive: delivery.isStepActive(DeliveryStep.onTheWay),
                isCompleted: delivery.isStepCompleted(DeliveryStep.onTheWay),
                alignment: TextAlign.center,
              ),
              StepLabel(
                label: 'Delivered',
                isActive: delivery.isStepActive(DeliveryStep.delivered),
                isCompleted: delivery.isStepCompleted(DeliveryStep.delivered),
                alignment: TextAlign.right,
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacing16.h),

          Row(
            children: [
              StepNode(
                number: '1',
                isActive: delivery.isStepActive(DeliveryStep.pickup),
                isCompleted: delivery.isStepCompleted(DeliveryStep.pickup),
              ),
              StepConnector(
                isCompleted: delivery.isStepCompleted(DeliveryStep.onTheWay),
                isActive: delivery.isStepActive(DeliveryStep.onTheWay),
              ),
              StepNode(
                number: '2',
                isActive: delivery.isStepActive(DeliveryStep.onTheWay),
                isCompleted: delivery.isStepCompleted(DeliveryStep.onTheWay),
              ),
              StepConnector(
                isCompleted: delivery.isStepCompleted(DeliveryStep.delivered),
                isActive: delivery.isStepActive(DeliveryStep.delivered),
              ),
              StepNode(
                number: '3',
                isActive: delivery.isStepActive(DeliveryStep.delivered),
                isCompleted: delivery.isStepCompleted(DeliveryStep.delivered),
              ),
            ],
          ),

          if (delivery.statusMessage != null) ...[
            SizedBox(height: AppSizes.spacing16.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.spacing12.w,
                vertical: AppSizes.spacing14.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.warningLightActive,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: AppSizes.iconSize20.sp,
                    color: AppColors.neutralDarker,
                  ),
                  SizedBox(width: AppSizes.spacing4.w),
                  Text(
                    'Status',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    delivery.statusMessage!,
                    style: AppTextStyles.medium12.copyWith(
                      color: AppColors.warningDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
