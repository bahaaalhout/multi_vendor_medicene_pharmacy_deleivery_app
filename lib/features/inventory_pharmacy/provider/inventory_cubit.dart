import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/inventory_services.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/provider/inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final InventoryApiService apiService;

  InventoryCubit(this.apiService) : super(InventoryInitial());

  Future<void> fetchInventory() async {
    emit(InventoryLoading());
    try {
      final items = await apiService.getInventoryList();
      emit(InventoryLoaded(items));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }
}
