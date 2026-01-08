 import 'address.dart';

class Pharmacy {
  const Pharmacy({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.deliveryFee,
  });

  final String id;
  final String imageUrl;
  final String name;
  final Address address;
  final double rating;
  final int reviewCount;
  final double deliveryFee;
}
