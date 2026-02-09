import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/async_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/cubit/delivery_profile_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/models/review_data.dart';

class DeliveryProfileCubit extends Cubit<AsyncState<DeliveryProfileState>> {
  DeliveryProfileCubit() : super(const AsyncState.initial());

  void loadProfileData() {
    emit(const AsyncState.loading());
    
    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 2000), () {
      emit(AsyncState.success(
        DeliveryProfileState(
          name: 'Mohammed Bassam',
          email: 'mhmd26@email.com',
          location: 'Gaza',
          phone: '(+970) 59-244-9634',
          status: 'Online',
          carType: 'Car',
          totalDeliveries: 67,
          totalEarnings: 847.50,
          reviews: [
            ReviewData(
              name: 'Alex',
              time: '15:48 PM',
              comment: 'Your delivery skills are impressive and truly reliable.',
              imageUrl: 'https://via.placeholder.com/48x48/FFDCB9/000000?text=A',
            ),
            ReviewData(
              name: 'John',
              time: '14:30 PM',
              comment: 'Fast and professional service. Highly recommended!',
              imageUrl: 'https://via.placeholder.com/48x48/DCFFDF/000000?text=J',
            ),
            ReviewData(
              name: 'Sarah',
              time: '13:15 PM',
              comment: 'Great communication and on-time delivery.',
              imageUrl: 'https://via.placeholder.com/48x48/E0F7FA/000000?text=S',
            ),
          ],
        ),
      ));
    });
  }

  void refreshProfileData() {
    loadProfileData();
  }
}
