class SaleInfo {
  final int discountPercentage;
  final double originalPrice;
  final double discountedPrice;
  final List<String> recommendations;

  const SaleInfo({
    required this.discountPercentage,
    required this.originalPrice,
    required this.discountedPrice,
    required this.recommendations,
  });
}
