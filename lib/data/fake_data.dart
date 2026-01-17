import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/address_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/cart_item_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_offer_model.dart';


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