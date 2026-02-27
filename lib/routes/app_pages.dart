import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/forget_password_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/login_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/new_password_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/otp_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/sign_up_pharmacy_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/sign_up_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/add_medicine_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/inventory_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/view/onboarding.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/view/select_type_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/view/splash_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/cart_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/screens/checkout_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/navigation/delivery_main_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/navigation/patient_main_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/medication_reminder_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/screens/pharmacy_orders_list_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/screens/pharmacy_profile_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/low_stock_trends_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/medicine_usage_insights_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/report_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/screens/sales_overview_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUpPharmacy,
        builder: (context, state) => const SignUpPharmacyScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final email = state.extra as String;
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.newPasswordScreen,
        builder: (context, state) => const NewPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.select,
        builder: (context, state) => const SelectTypeScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => OnboardingScreen(),
      ),
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
      GoRoute(
        path: AppRoutes.pharmacyOrders,
        builder: (context, state) => const PharmacyOrdersListScreen(),
      ),
      GoRoute(
        path: AppRoutes.pharmacyOrders,
        builder: (context, state) => const PharmacyOrdersListScreen(),
      ),
    ],
  );
}
