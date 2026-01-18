class CategoryModel {
  final String name;
  final String description;
  final String imageUrl;

  CategoryModel({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

List<CategoryModel> categories = [
  CategoryModel(
    name: 'Cold & Flu medicine',
    description: 'Flu, cough, sore throat',
    imageUrl: 'assets/images/snooze.png',
  ),
  CategoryModel(
    name: 'Pain Relief',
    description: 'Headache, muscle pain',
    imageUrl: 'assets/images/snooze.png',
  ),
  CategoryModel(
    name: 'Vitamins & Supplements',
    description: 'Daily vitamins, minerals',
    imageUrl: 'assets/images/snooze.png',
  ),
  CategoryModel(
    name: 'Allergy Medicine',
    description: 'Allergy relief',
    imageUrl: 'assets/images/snooze.png',
  ),
];
