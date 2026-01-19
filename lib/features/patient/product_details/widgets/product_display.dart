import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/circle_icon_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({
    super.key,
    required this.pharmacy,
    required this.medicine,
  });
  final PharmacyModel pharmacy;
  final MedicineModel medicine;

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  int currentIndex = 0;
  List<String> medicineImages = [
    'assets/images/pandol.png',
    'assets/images/pandol.png',
    'assets/images/pandol.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleIconButton(
                assetIcon: 'assets/icons/arrow_left.svg',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                            width: 1,
                            color: AppColors.successLightActive,
                          ),
                        ),
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppColors.successDarkHover,
                          ),
                        ),
                      ),
                      4.horizontalSpace,
                      StyledText(title: 'Available'),
                      4.horizontalSpace,
                      Text(
                        '(in stock)',
                        style: AppTextStyles.medium16.copyWith(
                          color: AppColors.primaryNormal,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.pharmacy.name,
                    style: AppTextStyles.reqular16.copyWith(
                      color: AppColors.primaryDark,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted,
                      decorationColor: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
              CircleIconButton(
                assetIcon: 'assets/icons/upload.svg',
                onPressed: () {},
              ),
            ],
          ),
          20.verticalSpace,
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffF7F8FF), Color(0xffDFE5FF)],
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15.5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/Star 1.svg',
                            width: 20,
                          ),
                          6.horizontalSpace,
                          Text(
                            '${widget.medicine.rating}',
                            style: AppTextStyles.semiBold14,
                          ),
                          3.horizontalSpace,
                          Text(
                            '(5)',
                            style: AppTextStyles.reqular12.copyWith(
                              color: Color(0xff7D7D7D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/book_mark.svg',
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ],
                ),
                32.verticalSpace,
                CarouselSlider(
                  items: medicineImages.map((img) {
                    return Image.asset(img);
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 1.5,

                    padEnds: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                54.verticalSpace,
              ],
            ),
          ),
          20.verticalSpace,
          AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: medicineImages.length,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 8,
              activeDotColor: Color(0xff313131),
              dotColor: Color(0xffD9D9D9),
            ),
          ),
        ],
      ),
    );
  }
}
