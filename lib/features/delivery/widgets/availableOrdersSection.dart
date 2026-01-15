import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/available_order_card.dart';

class AvailableOrdersSection extends StatelessWidget {
  final List<DeliveryModel> availableDeliveries;
  final Function(DeliveryModel) onAcceptOrder;

  const AvailableOrdersSection({
    super.key,
    required this.availableDeliveries,
    required this.onAcceptOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAvailableOrdersHeader(),
        SizedBox(height: AppSizes.spacing16.h),
        Expanded(child: _buildOrdersList()),
      ],
    );
  }

  Widget _buildAvailableOrdersHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Available Orders',
          style: AppTextStyles.bold21.copyWith(color: AppColors.primaryDarker),
        ),
        Text(
          '${availableDeliveries.length} orders',
          style: AppTextStyles.reqular14.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList() {
    return ListView.separated(
      itemCount: availableDeliveries.length,
      separatorBuilder: (_, __) => SizedBox(height: AppSizes.spacing16.h),
      itemBuilder: (context, index) {
        return AvailableOrderCard(
          deliveryModel: availableDeliveries[index],
          onAccept: () => onAcceptOrder(availableDeliveries[index]),
        );
      },
    );
  }
}
