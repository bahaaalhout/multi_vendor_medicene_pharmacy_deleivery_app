import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/availability_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/medicine_name_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/prescription_category_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/pricing_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/stock_expiry_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/usage_instructions_section.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _expiryController = TextEditingController();
  final _basePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();

  String _selectedType = 'Tablet';
  String _selectedCategory = 'Analgesic';
  bool _requiresPrescription = false;
  bool _isVisibleToCustomer = true;
  String _stockStatus = 'In Stock';

  final List<String> _dosages = ["one tablet every 4-6 hours"];
  final List<String> _storage = ["Store at room temperature"];
  final Map<String, bool> _safetyChecks = {
    "Not suitable for children under 6": true,
    "Avoid away from moisture and heat": true,
    "Not safe for pregnant women": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Add Medicine",
          style: AppTextStyles.semiBold18.copyWith(
            color: AppColors.neutralDarkActive,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            MedicineNameSection(
              nameController: _nameController,
              selectedType: _selectedType,
              onTypeChanged: (val) => setState(() => _selectedType = val!),
            ),
            24.verticalSpace,

            StockExpirySection(
              stockController: _stockController,
              expiryController: _expiryController,
            ),
            24.verticalSpace,

            PricingSection(
              basePriceController: _basePriceController,
              sellingPriceController: _sellingPriceController,
            ),
            24.verticalSpace,

            PrescriptionCategorySection(
              selectedCategory: _selectedCategory,
              requiresPrescription: _requiresPrescription,
              onCategoryChanged: (val) =>
                  setState(() => _selectedCategory = val!),
              onPrescriptionChanged: (val) =>
                  setState(() => _requiresPrescription = val),
            ),
            24.verticalSpace,

            UsageInstructionsSection(
              dosages: _dosages,
              storage: _storage,
              safetyChecks: _safetyChecks,
              onSafetyChanged: (key, val) =>
                  setState(() => _safetyChecks[key] = val),
            ),
            24.verticalSpace,

            AvailabilitySection(
              isVisible: _isVisibleToCustomer,
              currentStatus: _stockStatus,
              onVisibleChanged: (val) =>
                  setState(() => _isVisibleToCustomer = val),
              onStatusChanged: (val) => setState(() => _stockStatus = val),
            ),
            125.verticalSpace,
          ],
        ),
      ),
    );
  }
}
