import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/address_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/cart_item_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_offer_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

final now = DateTime.now();
final List<AddressModel> address = [
  AddressModel(
    id: "1",
    street: "123 Main St",
    area: "AlRemal",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00970",
  ),
  AddressModel(
    id: "2",
    street: "456 Central Ave",
    area: "Sheikh Radwan",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00972",
  ),
  AddressModel(
    id: "3",
    street: "789 First Blvd",
    area: "AlTuffah",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00972",
  ),
  AddressModel(
    id: "4",
    street: "1012 Liberty Rd",
    area: "AlNasr",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00970",
  ),
  AddressModel(
    id: "5",
    street: "34 Green St",
    area: "AlZaytoun",
    city: "Gaza",
    country: "Palestine",
    postalCode: "00970",
  ),
  AddressModel(
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

List<ReminderItem> reminders = [
  ReminderItem(
    id: '1',
    medicine: medicineData[0],
    time: const TimeOfDay(hour: 8, minute: 20),
    dose: 1,
    startDate: DateTime(now.year, now.month, now.day),
    endDate: DateTime(now.year, now.month, now.day + 30),
    days: [1, 2, 3, 4, 5, 6, 7],
    done: false,
  ),
  ReminderItem(
    id: '2',
    medicine: medicineData[1],
    time: const TimeOfDay(hour: 10, minute: 0),
    dose: 2,
    startDate: DateTime(now.year, now.month, now.day),
    endDate: DateTime(now.year, now.month, now.day + 30),
    days: [1, 3, 5],
    done: false,
  ),
  ReminderItem(
    id: '3',
    medicine: medicineData[2],
    time: const TimeOfDay(hour: 12, minute: 30),
    dose: 1,
    startDate: DateTime(now.year, now.month, now.day),
    endDate: DateTime(now.year, now.month, now.day + 30),
    days: [2, 4, 6],
    done: true,
  ),
  ReminderItem(
    id: '4',
    medicine: medicineData[3],
    time: const TimeOfDay(hour: 18, minute: 45),
    dose: 3,
    startDate: DateTime(now.year, now.month, now.day),
    endDate: DateTime(now.year, now.month, now.day + 30),
    days: [1, 2, 3, 4, 5],
    done: true,
  ),
];

List<NotificationItem> notifications = [
  NotificationItem(
    id: 'n1',
    category: NotificationCategory.offer,
    title: '20% off at City pharmacy',
    description:
        'Get 20% discount on all prescription medicines valid until Sunday.',
    createdAt: now.subtract(const Duration(hours: 1)),
    isRead: false,
  ),
  NotificationItem(
    id: 'n2',
    category: NotificationCategory.offer,
    title: 'Buy one, get one free',
    description:
        'On select over-the-counter medications, valid through next week.',
    createdAt: now.subtract(const Duration(hours: 2)),
    isRead: false,
  ),
  NotificationItem(
    id: 'n3',
    category: NotificationCategory.medicineReminder,
    title: 'Time to refill your medicine',
    description:
        'Your Omeprazole 20mg prescription is running low. Refill now.',
    createdAt: now.subtract(const Duration(days: 1, hours: 3)),
    isRead: false,
  ),
  NotificationItem(
    id: 'n4',
    category: NotificationCategory.rating,
    title: 'Rate your delivery experience',
    description:
        'How was your order from HealthPlus Pharmacy? Share your feedback.',
    createdAt: now.subtract(const Duration(hours: 3)),
    isRead: false,
  ),
  NotificationItem(
    id: 'n5',
    category: NotificationCategory.offer,
    title: 'New vitamins are in stock',
    description: 'Explore our latest range of health supplements today.',
    createdAt: now.subtract(const Duration(days: 5)),
    isRead: true,
  ),
];
//delivery screen fake data
const pharmacyAddress = AddressModel(
  id: 'addr_1',
  street: '1852, Alkinz St.',
  area: 'Al Naser area',
  city: 'Gaza',
  country: 'Palestine',
  postalCode: '00000',
);

const customerAddress = AddressModel(
  id: 'addr_2',
  street: '2629, Omar AlMukhtar St.',
  area: 'AlRemal area',
  city: 'Gaza',
  country: 'Palestine',
  postalCode: '00000',
);

// Medicine
final medicine = MedicineModel(
  id: 'med_1',
  brandName: 'Pain Relief-X 400 mg',
  genericName: 'Ibuprofen',
  description: 'Pain reliever and fever reducer',
  warnings: ['Do not exceed recommended dose'],
  form: FormType.tablet,
  quantity: 12,
  strength: '400mg',
  requiresPrescription: false,
  imageUrls: ['https://via.placeholder.com/150/0000FF/FFFFFF?text=Med'],
  rating: 4.5,
  brand: 'PharmaCo',
  type: 'Pain Relief',
  details: 'Effective pain relief',
  effects: 'Reduces pain and inflammation',
  directions: 'Take 1-2 tablets every 4-6 hours',
  reviews: [],
);

// Pharmacy
final pharmacy = PharmacyModel(
  id: 'pharm_1',
  name: 'Family Pharmacy',
  image: 'https://via.placeholder.com/150/4CAF50/FFFFFF?text=Pharmacy',
  address: pharmacyAddress,
  rating: 4.2,
  reviewCount: 150,
  deliveryFee: 0.0,
  deliveryTime: '15 minutes',
  distance: 2.55,
);

// Pharmacy Offer
final pharmacyOffer = PharmacyOfferModel(
  id: 'offer_1',
  pharmacy: pharmacy,
  medicine: medicine,
  price: 12.99,
  isAvailable: true,
);

// Cart Items (4 items as in design)
final cartItems = List.generate(
  4,
  (index) => CartItemModel(
    id: 'item_${index + 1}',
    pharmacyOffer: pharmacyOffer,
    quantity: 1,
    requiresPrescription: false,
    status: CartItemStatus.ready,
  ),
);

// Base Order
final order = OrderModel(
  id: 'O325',
  status: OrderStatus.placed,
  items: cartItems,
  deliveryAddress: customerAddress,
  createdAt: DateTime.now(),
  customerName: 'Mohammed Bassam',
  customerPhone: '+970 59-244-9634',
  customerEmail: 'example20@gmail.com',
  estimatedTimeMinutes: 18, // Will format to "15-20 minutes"
  paymentMethod: 'Visa',
  deliveryInstructions: '"Leave at door."',
);

// === Different Delivery States for Testing ===

/// State 1: Accepted, pharmacy preparing (Pickup step)
final deliveryAccepted = DeliveryModel(
  id: 'del_1',
  order: order,
  status: DeliveryStatus.accepted,
  distanceKm: 2.55,
  timeMinutes: 15,
  price: 0.0,
  rating: 0.0,
  statusMessage: "Preparing order's products",
);

/// State 2: Picked up, ready to start (On the way step)
final deliveryPickedUp = DeliveryModel(
  id: 'del_2',
  order: order,
  status: DeliveryStatus.pickedUp,
  distanceKm: 3.63,
  timeMinutes: 20,
  price: 0.0,
  rating: 0.0,
  statusMessage: "Waiting for your accepting",
);

/// State 3: En route to customer (On the way step - active)
final deliveryEnRoute = DeliveryModel(
  id: 'del_3',
  order: order,
  status: DeliveryStatus.enRoute,
  distanceKm: 3.63,
  timeMinutes: 20,
  price: 0.0,
  rating: 0.0,
);

/// State 4: Delivered (Delivered step)
final deliveryCompleted = DeliveryModel(
  id: 'del_4',
  order: order,
  status: DeliveryStatus.delivered,
  distanceKm: 3.63,
  timeMinutes: 20,
  price: 12.0,
  rating: 4.5,
);

// === Available Deliveries for Home Screen ===
final fakeAvailableDeliveries = [
  deliveryAccepted,
  DeliveryModel(
    id: 'del_5',
    order: OrderModel(
      id: 'O326',
      status: OrderStatus.placed,
      items: cartItems,
      deliveryAddress: customerAddress,
      createdAt: DateTime.now(),
      customerName: 'Ahmed Hassan',
      customerPhone: '+970 59-123-4567',
      customerEmail: 'ahmed@example.com',
      estimatedTimeMinutes: 15,
      paymentMethod: 'Cash',
    ),
    status: DeliveryStatus.available,
    distanceKm: 2.55,
    timeMinutes: 15,
    price: 12.0,
    rating: 0.0,
  ),
];
