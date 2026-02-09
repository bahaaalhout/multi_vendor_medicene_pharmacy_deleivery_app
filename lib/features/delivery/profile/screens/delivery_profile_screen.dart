import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/edit_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/error_view.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/loading_view.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/widgets/profile_info_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/widgets/earnings_summary_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/widgets/reviews_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/widgets/logout_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/cubit/delivery_profile_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/async_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/screens/edit_profile_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/cubit/delivery_profile_state.dart';

class DeliveryProfileScreen extends StatelessWidget {
  const DeliveryProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryProfileCubit()..loadProfileData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<DeliveryProfileCubit, AsyncState<DeliveryProfileState>>(
            builder: (context, state) {
              return state.when(
                initial: () => const LoadingView(),
              loading: () => const LoadingView(),
                success: (data) => _buildProfileContent(context, data),
                error: (message) => ErrorView(message: message),
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _buildProfileContent(BuildContext context, DeliveryProfileState data) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16.w,
        vertical: AppSizes.spacing16.h,
      ),
      child: Column(
        children: [
          // Profile Header
          AppPrimaryAppBar(
            title: 'Profile',
            actionButton: EditButton(fun: () => _showEditProfileDialog(context)),
          ),

          SizedBox(height: AppSizes.spacing16.h),

          // Profile Info Card
          ProfileInfoCard(
            name: data.name,
            email: data.email,
            location: data.location,
            phone: data.phone,
            status: data.status,
            carType: data.carType,
          ),

          SizedBox(height: AppSizes.spacing32.h),

          // Earnings Summary
          EarningsSummaryCard(
            totalDeliveries: data.totalDeliveries,
            totalEarnings: data.totalEarnings,
            onViewDetailsPressed: () => _showEarningsDetailsDialog(context),
          ),

          SizedBox(height: AppSizes.spacing16.h),

          // Reviews Section
          ReviewsSection(reviews: data.reviews),

          SizedBox(height: AppSizes.spacing16.h),

          // Logout Button
          LogoutButton(),

          SizedBox(height: AppSizes.bottomPadding.h),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(),
      ),
    );
  }

  void _showEarningsDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Earnings Details', style: AppTextStyles.bold16),
          content: Text(
            'Detailed earnings breakdown would be shown here.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: AppTextStyles.medium12),
            ),
          ],
        );
      },
    );
  }
}
