import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/address.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/pharmacy_offer_model.dart';

final List<Address> address = [
  Address(
    id: "1",
    street: "123 Main St",
    area: "AlRemal",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00970",
  ),
  Address(
    id: "2",
    street: "456 Central Ave",
    area: "Sheikh Radwan",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00972",
  ),
  Address(
    id: "3",
    street: "789 First Blvd",
    area: "AlTuffah",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00972",
  ),
  Address(
    id: "4",
    street: "1012 Liberty Rd",
    area: "AlNasr",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00970",
  ),
  Address(
    id: "5",
    street: "34 Green St",
    area: "AlZaytoun",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00970",
  ),
  Address(
    id: "6",
    street: "56 Blue Ln",
    area: "AlShati",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00970",
  ),
];

final pharmacies = [
  PharmacyModel(
    id: "0",
    name: 'City Pharmacy',
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    address: address[0],
    rating: 4.5,
    reviewCount: 500,
    deliveryFee: 0,
    deliveryTime: "15 minutes",
    distance: 2.5,
  ),
  PharmacyModel(
    id: "1",
    name: 'Central Pharmacy',
    image:
        "https://images.unsplash.com/photo-1576602976047-174e57a47881?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGhhcm1hY3l8ZW58MHx8MHx8fDA%3D",
    address: address[1],
    rating: 4.3,
    reviewCount: 120,
    deliveryFee: 6,
    deliveryTime: "20 minutes",
    distance: 3.0,
  ),
  PharmacyModel(
    id: "2",
    name: 'AlFaris Pharmacy',
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    address: address[2],
    rating: 4.2,
    reviewCount: 180,
    deliveryFee: 4.5,
    deliveryTime: "25 minutes",
    distance: 4.0,
  ),
  PharmacyModel(
    id: "3",
    name: 'AlHayat Pharmacy',
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    address: address[3],
    rating: 4.7,
    reviewCount: 300,
    deliveryFee: 7,
    deliveryTime: "10 minutes",
    distance: 1.8,
  ),
  PharmacyModel(
    id: "4",
    name: 'AlShifa Pharmacy',
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    address: address[4],
    rating: 4.6,
    reviewCount: 150,
    deliveryFee: 3,
    deliveryTime: "30 minutes",
    distance: 5.2,
  ),
];

final List<MedicineModel> medicineData = [
  MedicineModel(
    id: "1",
    brandName: "Panadol Extra",
    genericName: "Paracetamol",
    description: "Used to relieve pain and reduce fever.",
    warnings: [
      "Do not exceed 4000mg per day",
      "Consult doctor before use in case of liver issues",
    ],
    type: "Analgesic",
    brand: "GSK",
    strength: "500mg",
    form: FormType.tablet,
    quantity: 20,
    requiresPrescription: false,
    imageUrls: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    ],
    rating: 4.5,
    details:
        "Panadol Extra contains paracetamol, a trusted pain reliever that works quickly to reduce fever and relieve pain.",
    effects:
        "Relieves mild to moderate pain such as headaches, menstrual pain, and toothaches.",
    directions:
        "Take 1-2 tablets every 4 to 6 hours as needed. Do not exceed 8 tablets in 24 hours.",
    reviews: ["Great for headaches!", "I rely on this for my pain relief."],
  ),
  MedicineModel(
    id: "2",
    brandName: "Voltaren",
    genericName: "Diclofenac Sodium",
    description: "Used to treat inflammation and pain.",
    warnings: [
      "Not recommended for those with heart disease",
      "May cause dizziness",
    ],
    type: "Anti-inflammatory",
    brand: "Novartis",
    strength: "75mg",
    form: FormType.ointment,
    quantity: 30,
    requiresPrescription: true,
    imageUrls: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    ],
    rating: 4.8,
    details:
        "Voltaren contains diclofenac sodium, a nonsteroidal anti-inflammatory drug (NSAID) that reduces pain, swelling, and inflammation.",
    effects:
        "Treats pain and inflammation caused by osteoarthritis, rheumatoid arthritis, and musculoskeletal conditions.",
    directions:
        "Apply a thin layer to the affected area 2-3 times a day, depending on your doctor’s recommendations.",
    reviews: [
      "Works wonders for my joint pain!",
      "Effective, but can be a bit greasy.",
    ],
  ),
  MedicineModel(
    id: "3",
    brandName: "Benadryl",
    genericName: "Diphenhydramine",
    description: "Used as an antihistamine to relieve allergy symptoms.",
    warnings: [
      "May cause drowsiness",
      "Not suitable for children under 6 years old",
    ],
    type: "Antihistamine",
    brand: "Johnson & Johnson",
    strength: "25mg",
    form: FormType.capsule,
    quantity: 50,
    requiresPrescription: false,
    imageUrls: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    ],
    rating: 4.2,
    details:
        "Benadryl is an antihistamine that relieves symptoms of allergy, hay fever, and the common cold, such as sneezing, runny nose, and itching.",
    effects:
        "Relieves symptoms caused by seasonal allergies or allergic reactions.",
    directions:
        "Take 1-2 capsules every 4-6 hours as needed. Do not exceed 6 capsules in 24 hours.",
    reviews: ["Helps with my seasonal allergies.", "It makes me very drowsy."],
  ),
  MedicineModel(
    id: "4",
    brandName: "Amoxil",
    genericName: "Amoxicillin",
    description:
        "An antibiotic used to treat a variety of bacterial infections.",
    warnings: ["Complete the full course", "May cause stomach upset"],
    type: "Antibiotic",
    brand: "GlaxoSmithKline",
    strength: "250mg",
    form: FormType.syrup,
    quantity: 100,
    requiresPrescription: true,
    imageUrls: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    ],
    rating: 4.0,
    details:
        "Amoxil is a broad-spectrum antibiotic that is used to treat a variety of infections including ear infections, bronchitis, pneumonia, and urinary tract infections.",
    effects: "Treats bacterial infections by stopping the growth of bacteria.",
    directions:
        "Take as prescribed by your doctor. Complete the full course of treatment even if symptoms disappear.",
    reviews: [
      "Great for treating infections.",
      "I felt better within a few days.",
    ],
  ),
  MedicineModel(
    id: "5",
    brandName: "Vicks VapoRub",
    genericName: "Camphor and Menthol",
    description: "Used to relieve cough and muscular pain.",
    warnings: [
      "Avoid contact with eyes",
      "Not suitable for children under 2 years",
    ],
    type: "Cough Suppressant",
    brand: "Procter & Gamble",
    strength: "50g",
    form: FormType.ointment,
    quantity: 1,
    requiresPrescription: false,
    imageUrls: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    ],
    rating: 4.6,
    details:
        "Vicks VapoRub is a topical ointment that provides relief for cough and muscle pain by inhalation of menthol vapors or through skin absorption.",
    effects:
        "Soothes coughs, relieves muscle aches, and provides comfort during cold and flu symptoms.",
    directions:
        "Apply on chest, back, and throat for cough relief. Use as directed for muscle pain.",
    reviews: ["Works wonders for colds.", "A great product for a sore throat."],
  ),
  MedicineModel(
    id: "6",
    brandName: "Dove Soap",
    genericName: "Sodium Lauryl Sulfate",
    description: "Used for cleansing and moisturizing the skin.",
    warnings: ["For external use only", "Avoid contact with eyes"],
    type: "Skin Care",
    brand: "Unilever",
    strength: "100g",
    form: FormType.cream,
    quantity: 3,
    requiresPrescription: false,
    imageUrls: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReqT59ijEJcjQ8BgJvkPAhqeXayWD2lRXP4Q&s",
    ],
    rating: 4.7,
    details:
        "Dove Soap is a gentle cleanser that moisturizes and softens the skin, leaving it feeling smooth and hydrated.",
    effects: "Cleanses, moisturizes, and nourishes the skin.",
    directions:
        "Apply to wet skin, lather, and rinse. Use daily for best results.",
    reviews: ["Love how smooth my skin feels.", "Perfect for sensitive skin."],
  ),
];

List<PharmacyOfferModel> offers = [
  PharmacyOfferModel(
    id: '1',
    isAvailable: true,
    price: 12.0,
    discountedPrice: 9.0,
    discountPercent: 25,
    pharmacy: pharmacies[0],
    medicine: medicineData[0],
  ),
  PharmacyOfferModel(
    id: '1',
    isAvailable: true,
    price: 12.0,
    discountedPrice: 9.0,
    discountPercent: 25,
    pharmacy: pharmacies[1],
    medicine: medicineData[1],
  ),
];
