import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/navigation/delivery_main_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/add_reminder_page.dart';
import '../features/patient/navigation/patient_main_screen.dart';
import '../features/pharmacy/orders/screens/pharmacy_orders_list_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.reminders,
        builder: (context, state) => const AddReminderPage(),
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
      GoRoute(
        path: AppRoutes.pharmacyOrders,
        builder: (context, state) => const PharmacyOrdersListScreen(),
      ),
    ],
  );

  static final GoRouter pharmacyRouter = GoRouter(
    initialLocation: AppRoutes.pharmacyOrders,
    routes: [
      GoRoute(
        path: AppRoutes.pharmacyOrders,
        builder: (context, state) => const PharmacyOrdersListScreen(),
      ),
    ],
  );
}
