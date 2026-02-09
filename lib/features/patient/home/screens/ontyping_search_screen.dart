import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/recent_card.dart';

class OntypingSearchScreen extends StatelessWidget {
  const OntypingSearchScreen({
    super.key,
    required this.textInput,
    required this.results,
  });

  final String textInput;
  final List<ProductMatch> results;

  @override
  Widget build(BuildContext context) {
    final uniqueMedicines = {
      for (var item in results) item.medicine.brandName: item.medicine,
    }.values.toList();

    final uniquePharmacies = {
      for (var item in results) item.pharmacy.name: item.pharmacy,
    }.values.toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Text(
            'Suggestions',
            style: AppTextStyles.bold22.copyWith(
              color: AppColors.primaryDarker,
              fontWeight: FontWeight.w700,
            ),
          ),

          if (uniqueMedicines.isNotEmpty) ...[
            12.verticalSpace,
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryLightActive,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medicine',
                    style: AppTextStyles.semiBold17.copyWith(
                      color: AppColors.primaryDarkActive,
                      fontSize: 18,
                    ),
                  ),
                  8.verticalSpace,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: uniqueMedicines.length < 4
                        ? uniqueMedicines.length
                        : 3,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentCard(recentItem: uniqueMedicines[index]);
                    },
                  ),
                ],
              ),
            ),
          ],

          if (uniquePharmacies.isNotEmpty) ...[
            12.verticalSpace,
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.primaryLightActive,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pharmacies',
                    style: AppTextStyles.semiBold17.copyWith(
                      color: AppColors.primaryDarkActive,
                      fontSize: 18,
                    ),
                  ),
                  8.verticalSpace,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: uniquePharmacies.length < 3
                        ? uniquePharmacies.length
                        : 2,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentCard(recentItem: uniquePharmacies[index]);
                    },
                  ),
                ],
              ),
            ),
          ],

          if (uniqueMedicines.isNotEmpty || uniquePharmacies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    context.read<SearchCubit>().onSubmit(textInput);

                    FocusScope.of(context).unfocus();
                  },
                  child: Text(
                    'Show all results for “$textInput”',
                    style: AppTextStyles.semiBold16.copyWith(
                      color: AppColors.primaryDarker,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
