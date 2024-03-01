import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:crimson_cycle/features/product/presentation/view/product_detail_page.dart';
import 'package:crimson_cycle/features/product/presentation/view_model/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadProducts extends StatelessWidget {
  final WidgetRef ref;
  final List<ProductEntity> lstProducts;

  const LoadProducts({Key? key, required this.lstProducts, required this.ref})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the MediaQuery data
    var size = MediaQuery.of(context).size;

    double containerHeight = size.height * 0.7;
    double containerWidth = size.width;

    return Container(
      height: containerHeight,
      width: containerWidth,
      child: ListView.builder(
        shrinkWrap:
            true, // This is still useful if the list doesn't fill the container
        physics:
            NeverScrollableScrollPhysics(), // Prevents scrolling within the ListView itself
        itemCount: lstProducts.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(lstProducts[index].productName),
          subtitle: Text(lstProducts[index].productDescription),
          trailing: IconButton(
            onPressed: () => _showDeleteDialog(context, lstProducts[index]),
            icon: const Icon(Icons.delete),
          ),
          onTap: () {
            // Action to perform on tap
            // For example, navigate to a detail page for the product
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  product: lstProducts[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ProductEntity product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to delete ${product.productName}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(productViewModelProvider.notifier)
                  .deleteProduct(context, product);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
