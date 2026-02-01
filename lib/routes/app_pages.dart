import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/help/screens/location_access_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/add_reminder_page.dart';
import '../features/patient/navigation/patient_main_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const LocationAccessScreen(),
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
}
