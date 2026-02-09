import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';

class ProductMatch {
  final MedicineModel medicine;
  final PharmacyModel pharmacy;

  ProductMatch({required this.medicine, required this.pharmacy});
}

abstract class SearchState {}

class OnSearchInitial extends SearchState {}

class OnSearchLoading extends SearchState {}

class OnSearchError extends SearchState {
  final String message;
  OnSearchError(this.message);
}

enum SearchMode { typing, submitted }

class OnSearchResult extends SearchState {
  final List<ProductMatch> results;
  final SearchMode mode;
  final FilterModel? activeFilters;

  OnSearchResult({
    required this.results,
    required this.mode,
    this.activeFilters,
  });
}
