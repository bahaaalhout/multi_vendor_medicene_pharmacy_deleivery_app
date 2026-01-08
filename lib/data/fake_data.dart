import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/address.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy.dart';

final address = Address(
  id: "0",
  street: "str 8",
  area: "Somewhere",
  city: "Gaza",
  country: "Palestine",
  postalCode: "00970",
);
final pharmacies = [
  Pharmacy(
    id: "0",
    name: 'City Pharmacy',
    imageUrl:
        "",
    address: address,
    rating: 4.5,
    reviewCount: 500,
    deliveryFee: 5,
  ),
  Pharmacy(
    id: "1",
    name: 'Central Pharmacy',
    imageUrl: "https://images.unsplash.com/photo-1576602976047-174e57a47881?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGhhcm1hY3l8ZW58MHx8MHx8fDA%3D",
    address: address,
    rating: 4.3,
    reviewCount: 120,
    deliveryFee: 6,
  ),
  Pharmacy(
    id: "1",
    name: 'Central Pharmacy',
    imageUrl: "",
    address: address,
    rating: 4.3,
    reviewCount: 120,
    deliveryFee: 6,
  ),
  Pharmacy(
    id: "1",
    name: 'Central Pharmacy',
    imageUrl: "",
    address: address,
    rating: 4.3,
    reviewCount: 120,
    deliveryFee: 6,
  ),
  Pharmacy(
    id: "1",
    name: 'Central Pharmacy',
    imageUrl: "",
    address: address,
    rating: 4.3,
    reviewCount: 120,
    deliveryFee: 6,
  ),
  Pharmacy(
    id: "1",
    name: 'Central Pharmacy',
    imageUrl: "",
    address: address,
    rating: 4.3,
    reviewCount: 120,
    deliveryFee: 6,
  ),
];
