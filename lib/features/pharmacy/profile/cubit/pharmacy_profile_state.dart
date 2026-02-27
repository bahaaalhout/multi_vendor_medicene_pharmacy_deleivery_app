class PharmacyProfileState {
  final bool acceptNewOrder;
  final String pharmacyName;
  final String address;
  final String workingHoursFrom;
  final String workingHoursTo;
  final String phoneCode;
  final String phoneNumber;

  PharmacyProfileState({
    this.acceptNewOrder = true,
    this.pharmacyName = 'Pharmacy Name',
    this.address = 'Al-Rimal, Gaza',
    this.workingHoursFrom = '9:00AM',
    this.workingHoursTo = '12:00AM',
    this.phoneCode = '+970',
    this.phoneNumber = '2655712',
  });

  PharmacyProfileState copyWith({
    bool? acceptNewOrder,
    String? pharmacyName,
    String? address,
    String? workingHoursFrom,
    String? workingHoursTo,
    String? phoneCode,
    String? phoneNumber,
  }) {
    return PharmacyProfileState(
      acceptNewOrder: acceptNewOrder ?? this.acceptNewOrder,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      address: address ?? this.address,
      workingHoursFrom: workingHoursFrom ?? this.workingHoursFrom,
      workingHoursTo: workingHoursTo ?? this.workingHoursTo,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
