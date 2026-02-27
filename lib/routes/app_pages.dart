import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/add_medicine_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/navigation/patient_main_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/cart_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/checkout_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/navigation/delivery_main_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/medication_reminder_page.dart';
import '../features/patient/navigation/patient_main_screen.dart';
import '../features/inventory_pharmacy/inventory_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.inventoryScreen,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),

      GoRoute(
        path: AppRoutes.medicationReminder,
        builder: (context, state) => const MedicationReminderPage(),
      ),
      GoRoute(
        path: AppRoutes.deliveryMain,
        builder: (context, state) => const DeliveryMainScreen(),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) {
          final medicine = state.extra as MedicineModel;

          return CartScreen(medicineModel: medicine);
        },
      ),
      GoRoute(
        path: AppRoutes.inventoryScreen,
        builder: (context, state) => InventoryScreen(pharmacy: pharmacies[0]),
      ),
      // GoRoute(
      //   path: AppRoutes.medicineDetails,
      //   builder: (context, state) => const MedicineDetailsScreen(inventoryItem: null,),
      // ),
      GoRoute(
        path: AppRoutes.addMedicine,
        builder: (context, state) => const AddMedicineScreen(),
      ),
    ],
  );
}
