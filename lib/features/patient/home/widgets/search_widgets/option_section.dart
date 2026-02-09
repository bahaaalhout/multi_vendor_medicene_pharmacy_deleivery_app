import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/filter_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/filter_state.dart';

class PrescriptionSection extends StatelessWidget {
  const PrescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state is FilterSuccess) {
          final currentType = state.model.prescriptionType;

          return Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutralLightActive),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: RadioGroup<String>(
              groupValue: currentType,
              onChanged: (val) {
                if (val != null) {
                  context.read<FilterCubit>().update(
                    state.model.copyWith(prescriptionType: val),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'Prescription type',
                      style: AppTextStyles.medium16.copyWith(
                        color: AppColors.neutralDarkActive,
                      ),
                    ),
                  ),
                  8.verticalSpace,

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      '- Prescription required to purchase and review by pharmacy',
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.neutralDark,
                      ),
                    ),
                  ),

                  4.verticalSpace,

                  RadioTile(
                    title: 'Requires Prescription',
                    value: 'Requires Prescription',
                    context: context,
                  ),

                  RadioTile(
                    title: 'No Prescription Needed',
                    value: 'No Prescription Needed',
                    context: context,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class RadioTile extends StatelessWidget {
  const RadioTile({
    super.key,
    required this.title,
    required this.value,
    required this.context,
  });
  final BuildContext context;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: AppTextStyles.medium16.copyWith(color: AppColors.primaryNormal),
      ),
      value: value,
      activeColor: AppColors.primaryNormal,
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
