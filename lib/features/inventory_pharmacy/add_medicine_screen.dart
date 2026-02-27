import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/inventory_services.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/provider/addmedicine_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/provider/addmedicine_state.dart';
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
  final _formKey = GlobalKey<FormState>();

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
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _expiryController.dispose();
    _basePriceController.dispose();
    _sellingPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddMedicineCubit>(
      create: (context) => AddMedicineCubit(InventoryApiService()),
      child: Scaffold(
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
        body: BlocConsumer<AddMedicineCubit, AddMedicineState>(
          listener: (context, state) {
            if (state is AddMedicineSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Medicine added successfully!'),
                  backgroundColor: AppColors.primaryNormal,
                ),
              );
              Navigator.pop(context);
            } else if (state is AddMedicineError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MedicineNameSection(
                      nameController: _nameController,
                      selectedType: _selectedType,
                      onTypeChanged: (val) =>
                          setState(() => _selectedType = val!),
                      nameValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    24.verticalSpace,

                    StockExpirySection(
                      stockController: _stockController,
                      expiryController: _expiryController,
                      stockValidator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (int.tryParse(value) == null) {
                          return 'Must be a valid number';
                        }
                        return null;
                      },
                      expiryValidator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    24.verticalSpace,

                    PricingSection(
                      basePriceController: _basePriceController,
                      sellingPriceController: _sellingPriceController,
                      basePriceValidator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (double.tryParse(value) == null) {
                          return 'Must be a valid price';
                        }
                        return null;
                      },
                      sellingPriceValidator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (double.tryParse(value) == null) {
                          return 'Must be a valid price';
                        }
                        return null;
                      },
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
                      onStatusChanged: (val) =>
                          setState(() => _stockStatus = val),
                    ),

                    24.verticalSpace,

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNormal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: state is AddMedicineLoading
                            ? null
                            : () {
                                // Trigger UI Validation
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AddMedicineCubit>()
                                      .submitMedicine(
                                        medicineId: 0,
                                        stockQuantity: _stockController.text,
                                        costPrice: _basePriceController.text,
                                        sellPrice: _sellingPriceController.text,
                                        expiryDate:
                                            _expiryController.text.isNotEmpty
                                            ? _expiryController.text
                                            : "2026-01-01",
                                      );
                                }
                              },
                        child: state is AddMedicineLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Add Medicine",
                                style: AppTextStyles.semiBold16.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    125.verticalSpace,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
