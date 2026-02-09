import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_offer_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

class SavedState {
  final List<PharmacyOfferModel> savedProducts;
  final bool isLoading;

  SavedState({
    List<PharmacyOfferModel>? savedProducts,
    this.isLoading = false,
  }) : savedProducts = savedProducts ?? [];

  SavedState copyWith({
    List<PharmacyOfferModel>? savedProducts,
    bool? isLoading,
  }) {
    return SavedState(
      savedProducts: savedProducts ?? this.savedProducts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedState()) {
    loadSavedProducts();
  }

  void loadSavedProducts() {
    emit(state.copyWith(isLoading: true));
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      // Load saved products from fake_data
      final loadedProducts = savedProducts;
      emit(state.copyWith(savedProducts: loadedProducts, isLoading: false));
    });
  }

  void removeProduct(String productId) {
    final updatedProducts = state.savedProducts
        .where((product) => product.id != productId)
        .toList();
    emit(state.copyWith(savedProducts: updatedProducts));
  }

  void addToCart(String productId) {
    // Handle add to cart logic here
    // This can be connected to a cart cubit or service
  }
}

