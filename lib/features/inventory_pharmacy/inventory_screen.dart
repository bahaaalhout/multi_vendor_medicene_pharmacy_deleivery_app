import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/inventory_services.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/provider/inventory_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/provider/inventory_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/inventory_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class InventoryScreen extends StatefulWidget {
  final PharmacyModel pharmacy;

  const InventoryScreen({super.key, required this.pharmacy});
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InventoryCubit>(
      create: (context) =>
          InventoryCubit(InventoryApiService())..fetchInventory(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/careway.png",
                          width: 34.w,
                          height: 32.h,
                          opacity: AlwaysStoppedAnimation(0.3),
                        ),
                        8.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CureWay",
                              style: AppTextStyles.bold24.copyWith(
                                color: AppColors.primaryNormal,
                              ),
                            ),
                            Text(
                              widget.pharmacy.name,
                              style: AppTextStyles.reqular12.copyWith(
                                color: AppColors.primaryNormalHover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset("assets/icons/notifications.svg"),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inventory",
                      style: AppTextStyles.semiBold20.copyWith(
                        color: Colors.black,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.r,
                          color: AppColors.neutralLightActive,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "All Status",
                            style: AppTextStyles.reqular12.copyWith(
                              color: AppColors.neutralDarkActive,
                            ),
                          ),
                          8.horizontalSpace,
                          SvgPicture.asset(
                            'assets/icons/arrow-drop-down-big.svg',
                          ),
                          8.horizontalSpace,
                          InkWell(
                            onTap: () async {
                              await context.push(AppRoutes.addMedicine);
                              if (context.mounted)
                                context.read<InventoryCubit>().fetchInventory();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/add_with_circle.svg',
                            ),
                          ),
                          8.horizontalSpace,
                          SvgPicture.asset('assets/icons/file.svg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: BlocBuilder<InventoryCubit, InventoryState>(
                  builder: (context, state) {
                    if (state is InventoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryNormal,
                        ),
                      );
                    } else if (state is InventoryError) {
                      return Center(
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.errorNormal),
                        ),
                      );
                    } else if (state is InventoryLoaded) {
                      final items = state.items;

                      if (items.isEmpty) {
                        return Center(
                          child: Text("No medicines found in inventory."),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: items.length,
                        separatorBuilder: (c, i) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          final realItem = items[index];
                          return InkWell(
                            onTap: () async {
                              await context.push(AppRoutes.medicineDetails);

                              if (context.mounted)
                                context.read<InventoryCubit>().fetchInventory();
                            },
                            child: InventoryCard(item: realItem),
                          );
                        },
                      );
                    }
                    return SizedBox.shrink(); // Initial state
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
