import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/saved/cubit/saved_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/saved/widgets/saved_product_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavedCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    const NavigateBackButton(),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Saved',
                          style: AppTextStyles.bold25.copyWith(
                            fontSize: 24.sp,
                            color: AppColors.neutralDarker,
                          ),
                        ),
                      ),
                    ),
                    40.horizontalSpace,
                  ],
                ),
              ),

              // Products List
              Expanded(
                child: BlocBuilder<SavedCubit, SavedState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.savedProducts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_border,
                              size: 64.sp,
                              color: AppColors.neutralNormal,
                            ),
                            16.verticalSpace,
                            Text(
                              'No saved products',
                              style: AppTextStyles.medium14.copyWith(
                                color: AppColors.neutralDark,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        ...state.savedProducts.map((offer) => SavedProductCard(
                              offer: offer,
                              onAddToCart: () {
                                context.read<SavedCubit>().addToCart(offer.id);
                                // Optional: Show snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${offer.medicine.brandName} added to cart'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              onRemove: () {
                                context.read<SavedCubit>().removeProduct(offer.id);
                                // Optional: Show snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${offer.medicine.brandName} removed from saved'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            )),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

