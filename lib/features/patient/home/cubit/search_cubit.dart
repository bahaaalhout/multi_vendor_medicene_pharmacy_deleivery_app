import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final List<PharmacyModel> pharmacies;
  String lastSearchInput = '';

  SearchCubit({required this.pharmacies}) : super(OnSearchInitial());

  List<ProductMatch> _getMatches(String input, [FilterModel? filters]) {
    //this logic is the heart of our search functionality. It takes the user's input and optional filters, and returns a list of ProductMatch objects that represent medicines matching the search criteria along with their respective pharmacies.

    //it filled with comments to explain the logic step by step, and also includes logging statements to help us understand how the search is progressing and why certain items are being included or excluded from the results written by Bahaa :).

    log("--- SEARCHING ---");
    log("Input: '$input'");
    if (filters != null) {
      log(
        "Filters: Price=${filters.priceRange}, Dist=${filters.distanceRange}, Rating=${filters.rating}",
      );
    }

    List<ProductMatch> matches = [];
    final query = input.toLowerCase();

    for (var pharmacy in pharmacies) {
      // Check Pharmacy Filters
      if (filters != null) {
        if (pharmacy.distance > filters.distanceRange.end) {
          log(
            "Dropped Pharmacy '${pharmacy.name}': Distance ${pharmacy.distance} outside range",
          );
          continue;
        }
        if (pharmacy.rating < filters.rating) {
          log(
            "Dropped Pharmacy '${pharmacy.name}': Rating ${pharmacy.rating} too low",
          );
          continue;
        }
      }

      // Check Medicines inside this Pharmacy
      for (var medicine in pharmacy.medicines) {
        bool nameMatches = medicine.brandName.toLowerCase().contains(query);
        if (!nameMatches) {
          if (input.isNotEmpty) {
            log(
              "Dropped Med '${medicine.brandName}' in ${pharmacy.name}: Name doesn't match '$input'",
            );
          }
        }

        bool filterMatches = true;

        if (filters != null) {
          if (filters.category != null && medicine.type != filters.category) {
            log(
              "Dropped Med '${medicine.brandName}': Type '${medicine.type}' != '${filters.category}'",
            );
            filterMatches = false;
          }

          // Brand Filter
          if (filters.brand != null && medicine.brand != filters.brand) {
            log(
              "Dropped Med '${medicine.brandName}': Brand '${medicine.brand}' != '${filters.brand}'",
            );
            filterMatches = false;
          }
          // Price
          final price =
              medicine.salesInfo?.discountedPrice ??
              medicine.salesInfo?.originalPrice ??
              0.0;
          double priceRangeStart = filters.priceRange.start == 0
              ? 0.0
              : filters.priceRange.start;

          if (price < priceRangeStart || price > filters.priceRange.end) {
            log(
              "Dropped Med '${medicine.brandName}' (${pharmacy.name}): Price $price outside range",
            );
            filterMatches = false;
          }

          // Stock
          if (filters.inStockOnly && medicine.quantity <= 0) {
            log(
              "Dropped Med '${medicine.brandName}' (${pharmacy.name}): Out of stock",
            );
            filterMatches = false;
          }

          // Sale
          if (filters.onSale && medicine.salesInfo?.discountedPrice == null) {
            log(
              "Dropped Med '${medicine.brandName}' (${pharmacy.name}): Not on sale",
            );
            filterMatches = false;
          }

          // Prescription
          if (filters.prescriptionType == 'Requires Prescription' &&
              !medicine.requiresPrescription) {
            log(
              "Dropped Med '${medicine.brandName}' (${pharmacy.name}): Needs prescription but has none",
            );
            filterMatches = false;
          }
          if (filters.prescriptionType == 'No Prescription Needed' &&
              medicine.requiresPrescription) {
            log(
              "Dropped Med '${medicine.brandName}' (${pharmacy.name}): Has prescription but user doesnt want one",
            );
            filterMatches = false;
          }
        }

        // If both matches pass, add to our list!
        if (nameMatches && filterMatches) {
          log(">>> MATCH FOUND: ${medicine.brandName} at ${pharmacy.name}");
          matches.add(ProductMatch(medicine: medicine, pharmacy: pharmacy));
        }
      }
    }

    log("Total Matches Found: ${matches.length}");
    return matches;
  }

  void updateFilter(FilterModel newFilters) {
    applyFilters(newFilters, lastSearchInput);
  }

  //onTyping method
  void onTyping(String input) {
    if (input.isEmpty) {
      emit(OnSearchInitial());
      return;
    }
    emit(OnSearchResult(results: _getMatches(input), mode: SearchMode.typing));
  }

  // onsubmit result method
  void onSubmit(String input) {
    if (input.isEmpty) return;
    lastSearchInput = input;
    emit(OnSearchLoading());
    try {
      emit(
        OnSearchResult(
          results: _getMatches(input),
          mode: SearchMode.submitted,
          activeFilters: null,
        ),
      );
    } catch (e) {
      emit(OnSearchError(e.toString()));
    }
  }

  // apply filters method
  void applyFilters(FilterModel filters, String currentSearchInput) {
    emit(OnSearchLoading());
    lastSearchInput = currentSearchInput;

    final results = _getMatches(currentSearchInput, filters);

    emit(
      OnSearchResult(
        results: results,
        mode: SearchMode.submitted,
        activeFilters: filters,
      ),
    );
  }
}
