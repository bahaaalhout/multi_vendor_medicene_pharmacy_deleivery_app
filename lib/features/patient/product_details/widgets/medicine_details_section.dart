import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_container.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/widgets/medicine_form.dart';

class MedicineDetailsSection extends StatefulWidget {
  const MedicineDetailsSection({super.key, required this.medicine});
  final MedicineModel medicine;
  @override
  State<MedicineDetailsSection> createState() => _MedicineDetailsSectionState();
}

class _MedicineDetailsSectionState extends State<MedicineDetailsSection> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(child: StyledText(title: widget.medicine.brandName)),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/Frame.svg'),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (index == 0) {
                          return;
                        }
                        index--;
                      });
                    },
                    icon: CircleAvatar(
                      backgroundColor: AppColors.primaryLightHover,
                      radius: 12.r,
                      child: Icon(
                        Icons.remove,
                        fontWeight: FontWeight.bold,
                        size: 13,
                        color: AppColors.primaryNormal,
                      ),
                    ),
                  ),
                  Text('$index', style: AppTextStyles.medium21),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        index++;
                      });
                    },
                    icon: CircleAvatar(
                      backgroundColor: AppColors.primaryLightHover,
                      radius: 12.r,
                      child: Icon(
                        Icons.add,
                        size: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(widget.medicine.genericName, style: AppTextStyles.reqular12),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                StyledContainer(
                  horizontalPadding: 12,
                  verticalPadding: 8,
                  containerColor: Color(0xffEFEDED),
                  text: widget.medicine.type,
                  textStyle: AppTextStyles.semiBold12.copyWith(
                    color: AppColors.warningDarker,
                  ),
                ),
                4.horizontalSpace,
                StyledContainer(
                  horizontalPadding: 12,
                  verticalPadding: 8,
                  containerColor: Color(0xffEFEDED),
                  text: widget.medicine.brand,
                  textStyle: AppTextStyles.semiBold12.copyWith(
                    color: AppColors.warningDarker,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '\$${widget.medicine.salesInfo!.discountedPrice}',
                  style: AppTextStyles.bold25.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
                12.horizontalSpace,
                Text(
                  '\$${widget.medicine.salesInfo!.originalPrice}',
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.neutralDark,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
        16.verticalSpace,
        StyledText(title: 'Form'),
        8.verticalSpace,
        MedicineForm(medicineModel: widget.medicine),
      ],
    );
  }
}
