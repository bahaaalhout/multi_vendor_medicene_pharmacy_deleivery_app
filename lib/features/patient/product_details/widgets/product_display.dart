import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/product_appbar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/product_title.dart';
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
          ProductAppbar(title: ProductTitle(name: widget.pharmacy.name)),
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
