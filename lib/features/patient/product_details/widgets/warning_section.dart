import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';

class WarningSection extends StatefulWidget {
  const WarningSection({super.key, required this.medicine});
  final MedicineModel medicine;

  @override
  _WarningSectionState createState() => _WarningSectionState();
}

class _WarningSectionState extends State<WarningSection> {
  bool _isExpanded = false;
  bool _isExpandedText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: StyledText(title: 'Warnings'),
          trailing: _isExpanded
              ? SvgPicture.asset(
                  'assets/icons/arrow_up.svg',
                  width: 24.w,
                  height: 24.h,
                )
              : Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightHover,
                    borderRadius: BorderRadius.circular(60),
                  ),

                  child: Icon(
                    Icons.expand_more,
                    fontWeight: FontWeight.w400,
                    size: 18,
                    color: AppColors.primaryNormal,
                  ),
                ),
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          tilePadding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.warningLightActive,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '• ${widget.medicine.warnings[0]}.',
                        style: AppTextStyles.medium12.copyWith(
                          color: AppColors.warningDarker,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpandedText = !_isExpandedText;
                          });
                        },
                        child: Text(
                          _isExpandedText ? 'Read less' : 'Read more',
                          style: AppTextStyles.medium12.copyWith(
                            color: AppColors.warningDarker,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_isExpandedText)
                    Column(
                      children: widget.medicine.warnings
                          .skip(1)
                          .map(
                            (warning) => Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                '• $warning',
                                style: AppTextStyles.medium12.copyWith(
                                  color: AppColors.warningDarker,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
