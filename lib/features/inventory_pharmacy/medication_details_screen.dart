import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/delete_confirmation_dialog.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/upload_inventory_dialog.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Medication Details",
          style: AppTextStyles.bold16.copyWith(
            color: const Color(0xFF374151),
            fontSize: 18.sp,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onSelected: (value) {
              // Handle interactions here
              if (value == 'edit') {
                // Navigate to Edit Screen
              } else if (value == 'update') {
                showDialog(
                  context: context,
                  builder: (context) => UploadInventoryDialog(),
                );
              } else if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (context) => DeleteConfirmationDialog(
                    onDelete: () {
                      Navigator.pop(context); // Close the dialog
                    },
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: Text(
                  'Edit',
                  style: AppTextStyles.medium14.copyWith(
                    color: const Color(0xFF374151),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'update',
                child: Text(
                  'Update Stock', // Corrected "Stoke" to "Stock"
                  style: AppTextStyles.medium14.copyWith(
                    color: const Color(0xFF374151),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text(
                  'Delete Medication',
                  style: AppTextStyles.medium14.copyWith(
                    color: const Color(
                      0xFFEF4444,
                    ), // Red color for delete action
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Paracetamol 500mg",
              style: AppTextStyles.bold16.copyWith(
                fontSize: 20.sp,
                color: Colors.black,
              ),
            ),
            4.verticalSpace,
            Text(
              "Tablet - 500mg",
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.neutralDark,
              ),
            ),
            16.verticalSpace,
            Center(
              child: Image.asset(
                'assets/images/pandol.png',
                height: 180.h,
                fit: BoxFit.contain,
              ),
            ),
            24.verticalSpace,

            // Status Badges
            const AvailableStatusBadge(count: 45),
            12.verticalSpace,
            const ExpiryStatusBadge(date: "25 Jun 2025", weeksLeft: 2),
            24.verticalSpace,

            // Action Buttons
            const UpdateStockButton(),
            12.verticalSpace,
            const OutOfStockButton(),
            32.verticalSpace,

            // Drug Information
            const SectionHeader(title: "Drug Information"),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: const [
                  InfoRow(label: "Generic Name:", value: "Paracetamol"),
                  InfoRow(label: "Brand Name:", value: "Panadol"),
                  InfoRow(label: "Category:", value: "Analgesic"),
                  InfoRow(label: "Manufacturer:", value: "GlaxoSmithKline"),
                  InfoRow(label: "Prescription:", value: "No"),
                ],
              ),
            ),
            32.verticalSpace,

            // Usage & Instructions
            const SectionHeader(title: "Usage & Instructions"),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SubHeader(title: "Dosage"),
                  BulletPoint(text: "One tablet every 4–6 hours"),
                  BulletPoint(text: "Do not exceed 4 tablets in 24 hours"),

                  SubHeader(title: "Storage"),
                  BulletPoint(text: "Store at room temperature"),
                  BulletPoint(text: "Away from moisture and heat"),

                  SubHeader(title: "Safety"),
                  BulletPoint(text: "One tablet every 4–6 hours"),
                  BulletPoint(text: "Do not exceed 4 tablets in 24 hours"),

                  SubHeader(title: "Batch Nur"),
                  BulletPoint(text: "PAC-56789-22"),
                  BulletPoint(text: "Store at room temperature"),
                  BulletPoint(text: "Away from moisture and heat"),
                ],
              ),
            ),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}

// --- 1. Section Header ---
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bold16.copyWith(
              color: const Color(0xFF3B5BA9),
              fontSize: 16.sp,
            ),
          ),
          8.verticalSpace,
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
        ],
      ),
    );
  }
}

// --- 2. Info Row (Label: Value) ---
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.medium14.copyWith(
              color: const Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.semiBold14.copyWith(
              color: const Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 3. SubHeader (e.g., Dosage, Storage) ---
class SubHeader extends StatelessWidget {
  final String title;
  const SubHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: Text(
        title,
        style: AppTextStyles.bold16.copyWith(
          fontSize: 14.sp,
          color: const Color(0xFF374151),
        ),
      ),
    );
  }
}

// --- 4. Bullet Point ---
class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, left: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(color: Colors.black54, fontSize: 14.sp),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.medium14.copyWith(
                color: const Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 5. Available Status Badge ---
class AvailableStatusBadge extends StatelessWidget {
  final int count;
  const AvailableStatusBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 20),
          8.horizontalSpace,
          Text(
            "Available ($count in stock)",
            style: AppTextStyles.medium14.copyWith(
              color: const Color(0xFF374151),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// --- 6. Expiry Status Badge ---
class ExpiryStatusBadge extends StatelessWidget {
  final String date;
  final int weeksLeft;
  const ExpiryStatusBadge({
    super.key,
    required this.date,
    required this.weeksLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 24),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Expires soon",
                style: AppTextStyles.bold16.copyWith(
                  fontSize: 16.sp,
                  color: const Color(0xFF1F2937),
                ),
              ),
              4.verticalSpace,
              Text(
                "$weeksLeft weeks left to expiry\n$date",
                style: AppTextStyles.medium14.copyWith(
                  color: const Color(0xFF4B5563),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 7. Update Stock Button ---
class UpdateStockButton extends StatelessWidget {
  const UpdateStockButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B5BA9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          "Update Stock",
          style: AppTextStyles.bold16.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

// --- 8. Out Of Stock Button ---
class OutOfStockButton extends StatelessWidget {
  const OutOfStockButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.neutralLightActive),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          "Mark as out of stock",
          style: AppTextStyles.medium16.copyWith(
            color: const Color(0xFF374151),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
