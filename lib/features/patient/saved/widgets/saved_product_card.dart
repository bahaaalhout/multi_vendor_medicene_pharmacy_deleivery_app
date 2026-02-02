import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SavedProductCard extends StatelessWidget {
  final dynamic product; // استخدم SavedProduct model هنا

  const SavedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المنتج داخل حاوية رمادية فاتحة
              Container(
                width: 100.w, height: 100.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Image.asset(product.image, fit: BoxFit.contain),
              ),
              SizedBox(width: 12.w),
              // تفاصيل النص والبادجات
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.name, style: AppTextStyles.bold16),
                        Icon(Icons.bookmark, color: AppColors.primaryNormal.withOpacity(0.2)),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row( // البادجات الصفراء (OTC, 12 Tablets...)
                      children: [
                        _buildBadge(product.type),
                        SizedBox(width: 4.w),
                        _buildBadge(product.tablets),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text("\$${product.price}", style: AppTextStyles.semiBold20.copyWith(color: AppColors.successDark)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // صف الأزرار (Add to Cart & Remove)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  label: const Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryDark),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Remove"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF9EB), // لون خلفية البادج
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: const Color(0xFFFBE8B3)),
      ),
      child: Text(text, style: AppTextStyles.medium10.copyWith(color: const Color(0xFF8B6E0B))),
    );
  }
}