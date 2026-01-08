import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/section_bar.dart';

class PharmacyOffers extends StatelessWidget {
  const PharmacyOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionBar(sectionTitle: 'Pharmacy Offers', onPressed: () {}),
        SizedBox(height: 16),
        GestureDetector(
          onTap: null,
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // الجزء الأيسر مع الأيقونة
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.neutralLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/game-icons_first-aid-kit.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
                // الجزء الأيمن مع النص
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              '20% Discount',
                              style: AppTextStyles.bold.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              ' First Aid',
                              style: AppTextStyles.bold.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        SizedBox(height: 8),
                        Text(
                          'Everything you need to act fast in emergencies',
                          style: AppTextStyles.small.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutralDark,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
