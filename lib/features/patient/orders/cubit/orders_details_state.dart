import '../models/my_order_details_model.dart';

abstract class OrdersDetailsState {
  const OrdersDetailsState();
}

class OrdersDetailsInitial extends OrdersDetailsState {
  const OrdersDetailsInitial();
}

class OrdersDetailsLoading extends OrdersDetailsState {
  const OrdersDetailsLoading();
}

class OrdersDetailsSuccess extends OrdersDetailsState {
  final MyOrderDetailsModel details;
  const OrdersDetailsSuccess(this.details);
}

class OrdersDetailsError extends OrdersDetailsState {
  final String message;
  const OrdersDetailsError(this.message);
}