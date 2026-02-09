import 'package:flutter/material.dart';

class FilterModel {
  final RangeValues priceRange;
  final RangeValues distanceRange;
  final String prescriptionType;
  final int rating;
  final bool inStockOnly;
  final bool onSale;
  final String? category;
  final String? brand;

  FilterModel({
    required this.priceRange,
    required this.distanceRange,
    required this.prescriptionType,
    required this.rating,
    required this.inStockOnly,
    required this.onSale,
    this.category,
    this.brand,
  });

  factory FilterModel.initial() => FilterModel(
    priceRange: const RangeValues(1, 1000),
    distanceRange: const RangeValues(1, 20),
    prescriptionType: '',
    rating: 0,
    inStockOnly: false,
    onSale: false,
  );

  FilterModel copyWith({
    RangeValues? priceRange,
    RangeValues? distanceRange,
    String? prescriptionType,
    int? rating,
    bool? inStockOnly,
    bool? onSale,
    String? category,
    String? brand,
  }) {
    return FilterModel(
      priceRange: priceRange ?? this.priceRange,
      distanceRange: distanceRange ?? this.distanceRange,
      prescriptionType: prescriptionType ?? this.prescriptionType,
      rating: rating ?? this.rating,
      inStockOnly: inStockOnly ?? this.inStockOnly,
      onSale: onSale ?? this.onSale,
      category: category ?? this.category,
      brand: brand ?? this.brand,
    );
  }

  int get activeFilterCount {
    int count = 0;

    if (priceRange.start > 1 || priceRange.end < 1000) count++;
    if (distanceRange.end < 20) count++;
    if (rating > 0) count++;
    if (inStockOnly) count++;
    if (onSale) count++;
    if (prescriptionType.isNotEmpty &&
        prescriptionType != 'No Prescription Needed') {
      count++;
    }
    if (category != null) count++;
    if (brand != null) count++;

    return count;
  }
}
