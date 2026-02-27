import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/orders_details_cubit.dart';
import '../cubit/orders_details_state.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersDetailsCubit()..fetchDetails(orderId),
      child: Scaffold(
        appBar: AppBar(title: Text('Order #$orderId')),
        body: BlocBuilder<OrdersDetailsCubit, OrdersDetailsState>(
          builder: (context, state) {
            if (state is OrdersDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OrdersDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is OrdersDetailsSuccess) {
              final d = state.details;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Status: ${d.status}'),
                  const SizedBox(height: 8),
                  Text('Total: ${d.totalAmount.toStringAsFixed(2)} ${d.currency}'),
                  const SizedBox(height: 8),
                  Text('Delivery address: ${d.deliveryAddress.addressText}'),
                  const SizedBox(height: 16),

                  const Text(
                    'Pharmacy Orders',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  for (final po in d.pharmacyOrders) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            po.pharmacyName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('Status: ${po.status}'),
                          const SizedBox(height: 4),
                          Text('Subtotal: ${po.subtotal.toStringAsFixed(2)}'),
                          const SizedBox(height: 8),

                          const Text(
                            'Items',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),

                          for (final it in po.items)
                            Text(
                              '- ${it.medicineName} x${it.quantity} = ${it.totalPrice.toStringAsFixed(2)}',
                            ),

                          if (po.rejectionReason.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(
                              'Rejection reason: ${po.rejectionReason}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 14),

                  ElevatedButton(
                    onPressed: () => context.read<OrdersDetailsCubit>().cancelOrder(orderId),
                    child: const Text('Cancel Order'),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}