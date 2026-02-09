import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/cubit/expand_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/app_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/cart_checkout_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/contact_info.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/contact_info_widget.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/coupon_field.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/delivery_address.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/delivery_options.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/price_breakdown.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/product_showcase_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/title_of_section_of_checkout.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              CartCheckoutBar(
                infoButtonOnPressed: () {},
                title: 'Checkout',
                subTitle: 'Estimated Delivery at 11:30am',
              ),
              16.verticalSpace,
              TitleOfSectionCheckout(title: 'Order Summary', fun: () {}),
              12.verticalSpace,
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutralNormal),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondaryLight,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          width: 160.w,
                          height: 92.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          child: ProductShowcaseCard(),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12.h,
                            children: [
                              Text(
                                'City Pharmacy',
                                style: AppTextStyles.semiBold14,
                              ),
                              Text(
                                'Omar Mukhtar Street, Al-Rimal Area',
                                style: AppTextStyles.medium14,
                                softWrap: true,
                              ),
                              Text(
                                '4 items | 24.00\$',
                                style: AppTextStyles.reqular14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.warningLightActive,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 17.h,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/pending_icon.svg',
                            width: 20.w,
                            height: 20.h,
                          ),
                          12.horizontalSpace,
                          Text('Status', style: AppTextStyles.semiBold12),
                          Spacer(),
                          Text(
                            'Prescription under review',
                            style: AppTextStyles.medium12.copyWith(
                              color: Color(0xffD9A300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    8.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: AppTextStyles.medium12.copyWith(
                            color: AppColors.neutralDark,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'You can place the order now, prescription items will be processed after approval',
                            style: AppTextStyles.medium12.copyWith(
                              color: AppColors.neutralDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              12.verticalSpace,
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutralNormal),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondaryLight,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      width: 160.w,
                      height: 92.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12.h,
                        children: [
                          Text(
                            'City Pharmacy',
                            style: AppTextStyles.semiBold14,
                          ),
                          Text(
                            'Omar Mukhtar Street, Al-Rimal Area',
                            style: AppTextStyles.medium14,
                            softWrap: true,
                          ),
                          Text(
                            '4 items | 24.00\$',
                            style: AppTextStyles.reqular14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              DeliveryAddress(),
              16.verticalSpace,
              BlocProvider(
                create: (context) => ExpandCubit(),
                child: MyExpandWidget(
                  widget: ContactInfoWidget(),
                  title: 'ContactInformation',
                ),
              ),
              16.verticalSpace,
              DeliveryOptions(),
              16.verticalSpace,
              BlocProvider(
                create: (context) => ExpandCubit(),
                child: MyExpandWidget(widget: CouponField(), title: 'Discount'),
              ),
              16.verticalSpace,
              BlocProvider(
                create: (context) => ExpandCubit(),
                child: MyExpandWidget(
                  widget: ContactInfoWidget(),
                  title: 'Payment Method',
                ),
              ),
              16.verticalSpace,
              PriceBreakdown(),
              16.verticalSpace,
              AppButton(
                title: 'Place Order',
                onPressed: () {},
                isDisabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
