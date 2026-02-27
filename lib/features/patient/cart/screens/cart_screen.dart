import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/app_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/cart_checkout_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/cart_item_status_normal.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/order_summary.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/secured_order.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/widgets/medicine_form.dart';

class CartScreen extends StatefulWidget {
  final MedicineModel medicineModel;
  const CartScreen({super.key, required this.medicineModel});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int index = 1;
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
                title: 'Cart',
                subTitle: '3 items in Total',
              ),
              16.verticalSpace,
              Row(
                children: [
                  Text('Orders', style: AppTextStyles.bold22),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.r),
                          border: Border.all(
                            width: .5.w,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16.r,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      12.horizontalSpace,
                      Text(
                        'Add new',
                        style: AppTextStyles.medium16.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              24.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutralNormal),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            'assets/images/panadol.png',
                            width: 76.w,
                            height: 85.h,
                          ),
                        ),
                        16.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pain Relief- Panadol',
                              style: AppTextStyles.semiBold16,
                            ),
                            4.verticalSpace,
                            Text(
                              'Paracetamol (Acetaminophen)',

                              style: AppTextStyles.reqular12.copyWith(
                                color: AppColors.primaryDarkActive,
                              ),
                            ),
                            8.verticalSpace,
                            SizedBox(
                              width: 170.w,
                              child: MedicineForm(
                                medicineModel: widget.medicineModel,
                              ),
                            ),
                            12.verticalSpace,
                            Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$${widget.medicineModel.salesInfo!.discountedPrice}",
                                      style: AppTextStyles.semiBold18.copyWith(
                                        color: AppColors.successDark,
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      "\$${widget.medicineModel.salesInfo!.originalPrice}",
                                      style: AppTextStyles.semiBold12.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                36.horizontalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 12.w,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (index == 0) {
                                            return;
                                          }
                                          index--;
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.primaryLightHover,
                                        radius: 12.r,
                                        child: Icon(
                                          Icons.remove,
                                          fontWeight: FontWeight.bold,
                                          size: 13.r,
                                          color: AppColors.primaryNormal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '$index',
                                      style: AppTextStyles.medium21,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          index++;
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.primaryLightHover,
                                        radius: 12.r,
                                        child: Icon(
                                          Icons.add,
                                          size: 13.r,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryNormal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    24.verticalSpace,
                    CartItemStatusNormal(),
                  ],
                ),
              ),
              32.verticalSpace,
              OrderSummary(),
              32.verticalSpace,

              AppButton(title: 'Chekout', onPressed: () {}),
              8.verticalSpace,
              AppButton(
                title: 'Continue to shopping',
                isWhite: true,
                isDisabled: true,
                onPressed: () {},
              ),
              8.verticalSpace,
              SecuredOrder(),
            ],
          ),
        ),
      ),
    );
  }
}
