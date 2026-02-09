import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/cart_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/checkout_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/navigation/delivery_main_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/add_reminder_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/screens/change_password_screen.dart';
import '../features/patient/navigation/patient_main_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.checkout,
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
        path: AppRoutes.reminders,
        builder: (context, state) => const AddReminderPage(),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) {
          final medicine = state.extra as MedicineModel;

          return CartScreen(medicineModel: medicine);
        },
      ),
    ],
  );

  static final GoRouter deliveryRouter = GoRouter(
    initialLocation: AppRoutes.deliveryMain,
    routes: [
      GoRoute(
        path: AppRoutes.deliveryMain,
        builder: (context, state) => const DeliveryMainScreen(),
      ),
    ],
  );
}
