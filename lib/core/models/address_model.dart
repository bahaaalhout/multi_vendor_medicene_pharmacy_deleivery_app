class AddressModel {
  const AddressModel({
    required this.id,
    required this.street,
    required this.area,
    required this.city,
    required this.country,
    required this.postalCode,
  });

  final String id;
  final String street;
  final String area;
  final String city;
  final String country;
  final String postalCode;

  @override
  String toString() => [street, area, city, postalCode, country].where((s) => s.isNotEmpty).join(', ');
}
