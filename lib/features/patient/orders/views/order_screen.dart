import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/widgets/cards/order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/widgets/tabs/order_tabs.dart';

import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersCubit()..fetchOrders(),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView extends StatelessWidget {
  const _OrdersView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoadingState && state.allOrders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrdersErrorState) {
            return Center(child: Text(state.message));
          }

          return Column(
            children: [
              const SizedBox(height: 50),
              OrderTabs(
                current: state.tab,
                allOrders: state.allOrders,
                onChanged: context.read<OrdersCubit>().changeTab,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => context.read<OrdersCubit>().fetchOrders(),
                  child: state.visibleOrders.isEmpty
                      ? ListView(
                          children: const [
                            SizedBox(height: 160),
                            Center(child: Text('No orders found')),
                          ],
                        )
                      : ListView.builder(
                          itemCount: state.visibleOrders.length,
                          itemBuilder: (_, i) {
                            final o = state.visibleOrders[i];

                            return OrderCard(
                              order: o,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderDetailsScreen(orderId: o.id),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}