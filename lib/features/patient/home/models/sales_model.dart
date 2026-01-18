class SalesModel {
  final String name;
  final String description;
  final String imageUrl;
  final int discountPercentage;
  final double originalPrice;
  final double discountedPrice;
  final List<String> tags;

  SalesModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.discountPercentage,
    required this.originalPrice,
    required this.discountedPrice,
    required this.tags,
  });
}

final List<SalesModel> sales = [
  SalesModel(
    name: 'Paracetamol',
    description: 'Pain reliever and fever reducer',
    imageUrl: 'assets/images/panadol.png',
    discountPercentage: 10,
    originalPrice: 20.0,
    discountedPrice: 18.0,
    tags: ['OTC', '12 tablets'],
  ),
  SalesModel(
    name: 'Ibuprofen',
    description: 'Anti-inflammatory drug',
    imageUrl: 'assets/images/panadol.png',
    discountPercentage: 15,
    originalPrice: 25.0,
    discountedPrice: 21.25,
    tags: ['Anti', 'Pain'],
  ),
  SalesModel(
    name: 'Amoxicillin',
    description: 'Antibiotic for bacterial infections',
    imageUrl: 'assets/images/panadol.png',
    discountPercentage: 5,
    originalPrice: 30.0,
    discountedPrice: 28.5,
    tags: ['Antibiotic', 'Infections'],
  ),
];
