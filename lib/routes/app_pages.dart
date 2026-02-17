import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/screens/pharmacy_profile_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/report_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/low_stock_trends_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/medicine_usage_insights_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/sales_overview_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/cart_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/checkout_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/navigation/delivery_main_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/medication_reminder_page.dart';
import '../features/patient/navigation/patient_main_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const PharmacyProfileScreen(),
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
        path: AppRoutes.pharmacyReport,
        builder: (context, state) => const ReportScreen(),
      ),
      GoRoute(
        path: AppRoutes.salesOverview,
        builder: (context, state) => const SalesOverviewScreen(),
      ),
      GoRoute(
        path: AppRoutes.lowStockTrends,
        builder: (context, state) => const LowStockTrendsScreen(),
      ),
      GoRoute(
        path: AppRoutes.medicineUsageInsights,
        builder: (context, state) => const MedicineUsageInsightsScreen(),
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
}
