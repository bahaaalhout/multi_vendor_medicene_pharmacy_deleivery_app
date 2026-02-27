import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/inventory_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/inventory_services.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/provider/addmedicine_state.dart';

class AddMedicineCubit extends Cubit<AddMedicineState> {
  final InventoryApiService apiService;

  AddMedicineCubit(this.apiService) : super(AddMedicineInitial());

  Future<void> submitMedicine({
    required int medicineId,
    required String stockQuantity,
    required String sellPrice,
    required String costPrice,
    required String expiryDate,
    String batchNumber = "BATCH-DEFAULT",
    String shelfLocation = "A1",
    int minStock = 5,
    String notes = "",
  }) async {
    emit(AddMedicineLoading());

    try {
      final request = InventoryModel(
        medicineId: medicineId,
        stockQuantity: int.parse(stockQuantity),
        sellPrice: double.parse(sellPrice),
        costPrice: double.parse(costPrice),
        minStock: minStock,
        batchNumber: batchNumber,
        expiryDate: expiryDate,
        shelfLocation: shelfLocation,
        notes: notes,
      );

      await apiService.addMedicineToInventory(request);
      emit(AddMedicineSuccess());
    } catch (e) {
      emit(AddMedicineError(e.toString()));
    }
  }
}
