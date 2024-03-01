import 'package:crimson_cycle/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderView extends ConsumerStatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends ConsumerState<OrderView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(orderViewModelProvider.notifier).getOrders());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderViewModelProvider);

    print(state.orders);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                ref.read(orderViewModelProvider.notifier).getOrders();
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Container(
                      child: Stack(
                    children: [
                      Column(
                        children: [
                          Text("${order.orderId}"),
                          const Text("Items"),
                          Stack(
                              children:
                                  List.from(order.items?.map((item) => Stack(
                                            children: [
                                              Column(children: [
                                                Text(
                                                    "Name : ${item.productName}"),
                                                Text(
                                                    "Description :${item.description}"),
                                                Text(
                                                    'Category : ${item.category}'),
                                                // Text('Quantity : ${item.quantity}'),
                                                // Text('Price : ${item.price}'),
                                              ])
                                            ],
                                          )) ??
                                      [])),
                          Text('Status : ${order.status}')
                        ],
                      )
                    ],
                  ));
                },
              ),
            ),
    );
  }
}
