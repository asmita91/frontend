import 'package:crimson_cycle/core/shared_prefs/user_shared_prefs.dart';
import 'package:crimson_cycle/features/order/domain/entity/order_entity.dart';
import 'package:crimson_cycle/features/order/presentation/viewmodel/order_view_model.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final ProductEntity product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  bool isFavorite = false;
  int quantity = 1; // Initial quantity
  static const double discountPercentage = 20; // Static discount for display

  double get discountedPrice =>
      widget.product.productPrice! * (1 - discountPercentage / 100);
  double get totalPrice => discountedPrice * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Product Image
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 2.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              "https://www.getrael.com/cdn/shop/products/Pads_ListingImage_Petite.jpg?v=1697565445&width=2048"),
                        ),
                      ),
                    ),
                  ),
                  // Back Button
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.1,
                    left: MediaQuery.of(context).size.width * 0.04,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child:
                          Icon(Icons.arrow_back, size: 24, color: Colors.black),
                    ),
                  ),
                  // Scrollable Product Details
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: MediaQuery.of(context).size.height / 2.5,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product.productName,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(height: 10),
                            ExpandableTextWidget(
                                Des_text: widget.product.productDescription ??
                                    "No description provided"),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Selector
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.blue.shade100),
                          onPressed: () => setState(() {
                            if (quantity > 1) quantity--;
                          }),
                        ),
                        Text('$quantity',
                            style: TextStyle(fontSize: 18, color: Colors.blue)),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.blue.shade100),
                          onPressed: () => setState(() {
                            quantity++;
                          }),
                        ),
                      ],
                    ),
                  ),

                  // Price with "20% off" label
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "\Rs ${widget.product.productPrice!.toStringAsFixed(2)} ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        TextSpan(
                          text: "\Rs ${discountedPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: " 20% OFF",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10, // Adds shadow for a subtle elevated effect
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Total: ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade300),
                  ),
                  TextSpan(
                    text: '\Rs ${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade300),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final item = OrderItemEntity(
                  productId: widget.product.id!,
                  quantity: quantity,
                );
                String? userId;
                var userData =
                    await ref.read(userSharedPrefsProvider).getUser();
                if (userData != null) {
                  userId = userData['_id']?.toString();
                  final order = OrderEntity(
                    userId: userId,
                    items: [item],
                  );
                  ref
                      .read(orderViewModelProvider.notifier)
                      .createOrder(order, context);
                }
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableTextWidget extends StatefulWidget {
  final String Des_text;
  const ExpandableTextWidget({Key? key, required this.Des_text})
      : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 350; // Adjust based on your UI needs

  @override
  void initState() {
    super.initState();
    if (widget.Des_text.length > textHeight) {
      firstHalf = widget.Des_text.substring(0, textHeight.toInt());
      secondHalf = widget.Des_text.substring(
          textHeight.toInt() + 1, widget.Des_text.length);
    } else {
      firstHalf = widget.Des_text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf,
              style: TextStyle(fontSize: 15, height: 1.8, color: Colors.black))
          : Column(
              children: [
                Text(
                  hiddenText ? "$firstHalf..." : "$firstHalf$secondHalf",
                  style:
                      TextStyle(fontSize: 15, height: 1.8, color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        hiddenText ? "Show more" : "Show less",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
