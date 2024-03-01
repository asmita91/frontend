import 'package:crimson_cycle/core/common/snackbar/my_snackbar.dart';
import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:crimson_cycle/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:crimson_cycle/features/product/domain/entity/product_entity.dart';
import 'package:crimson_cycle/features/product/presentation/view_model/product_view_model.dart';
import 'package:crimson_cycle/features/product/presentation/widget/load_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductAddView extends ConsumerStatefulWidget {
  const ProductAddView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends ConsumerState<ProductAddView> {
  // final ImagePicker _picker = ImagePicker();
  // File? _img;
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  CategoryEntity? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // _checkCameraPermission();
  }

  // _checkCameraPermission() async {
  //   var cameraStatus = await Permission.camera.status;
  //   if (!cameraStatus.isGranted) {
  //     await Permission.camera.request();
  //   }
  // }

  // Future<void> _pickImage(ImageSource source) async {
  //   final XFile? image = await _picker.pickImage(source: source);
  //   if (image != null) {
  //     setState(() {
  //       _img = File(image.path);
  //     });
  //   }
  // }

  Future<void> _submitProduct() async {
    if (_selectedCategory == null) {
      showSnackBar(
          message: 'Please select a category',
          context: context,
          color: Colors.red);
      return;
    }
    // if (_img == null) {
    //   showSnackBar(
    //       message: 'Please pick an image', context: context, color: Colors.red);
    //   return;
    // }
    final num? price = num.tryParse(_productPrice.text);
    if (price == null) {
      showSnackBar(
          message: 'Please enter a valid price',
          context: context,
          color: Colors.red);
      return;
    }

    // Assuming you have a function to upload the image and get back a URL
    // String imageUrl = await uploadImage(_img);

    var product = ProductEntity(
      productName: _productName.text,
      productDescription: _productDescription.text,
      // Assuming the function returns the URL of the uploaded image
      // productImageUrl: '', // Replace with actual image URL
      productPrice: price,
      category: _selectedCategory!,
      createdAt: DateTime.now(),
    );

    // Assuming you have a method in your product view model to add a product
    await ref.read(productViewModelProvider.notifier).addProduct(product);
  }

//   @override
//   Widget build(BuildContext context) {
//     var productState = ref.watch(productViewModelProvider);

//     final categories = ref
//         .watch(categoryViewModelProvider.select((value) => value.categories));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               child: Column(
//                 children: [
//                   // if (_img != null)
//                   //   CircleAvatar(
//                   //     radius: 60,
//                   //     backgroundImage: FileImage(_img!),
//                   //   ),
//                   // TextButton.icon(
//                   //   onPressed: () => _pickImage(ImageSource.gallery),
//                   //   icon: const Icon(Icons.image),
//                   //   label: const Text('Select Image from Gallery'),
//                   // ),
//                   TextFormField(
//                     controller: _productName,
//                     decoration:
//                         const InputDecoration(labelText: 'Product Name'),
//                   ),
//                   TextFormField(
//                     controller: _productDescription,
//                     decoration:
//                         const InputDecoration(labelText: 'Product Description'),
//                   ),
//                   TextFormField(
//                     controller: _productPrice,
//                     decoration:
//                         const InputDecoration(labelText: 'Product Price'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   DropdownButtonFormField<CategoryEntity>(
//                     value: _selectedCategory,
//                     onChanged: (newValue) =>
//                         setState(() => _selectedCategory = newValue),
//                     items: categories.map<DropdownMenuItem<CategoryEntity>>(
//                         (CategoryEntity category) {
//                       return DropdownMenuItem<CategoryEntity>(
//                         value: category,
//                         child: Text(category.name),
//                       );
//                     }).toList(),
//                     decoration: const InputDecoration(labelText: 'Category'),
//                   ),
//                   ElevatedButton(
//                     onPressed: _submitProduct,
//                     child: const Text('Submit Product'),
//                   ),
//                   const Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'List of Products',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   if (productState.isLoading) ...{
//                     const Center(child: CircularProgressIndicator()),
//                   } else if (productState.error != null) ...{
//                     Text(productState.error.toString()),
//                   } else if (productState.products.isEmpty) ...{
//                     const Center(child: Text('No Products')),
//                   } else ...{
//                     Expanded(
//                       child: LoadProducts(
//                         lstProducts: productState.products,
//                         ref: ref,
//                       ),
//                     ),
//                   }
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    var productState = ref.watch(productViewModelProvider);
    final categories = ref
        .watch(categoryViewModelProvider.select((value) => value.categories));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _productName,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextFormField(
                  controller: _productDescription,
                  decoration:
                      const InputDecoration(labelText: 'Product Description'),
                ),
                TextFormField(
                  controller: _productPrice,
                  decoration: const InputDecoration(labelText: 'Product Price'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<CategoryEntity>(
                  value: _selectedCategory,
                  onChanged: (newValue) =>
                      setState(() => _selectedCategory = newValue),
                  items: categories.map<DropdownMenuItem<CategoryEntity>>(
                      (CategoryEntity category) {
                    return DropdownMenuItem<CategoryEntity>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                ElevatedButton(
                  onPressed: _submitProduct,
                  child: const Text('Submit Product'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'List of Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Check for loading, error, or empty states before attempting to display products
                if (productState.isLoading) ...{
                  const Center(child: CircularProgressIndicator()),
                } else if (productState.error != null) ...{
                  Text(productState.error.toString()),
                } else if (productState.products.isEmpty) ...{
                  const Center(child: Text('No Products')),
                } else ...{
                  LoadProducts(
                    lstProducts: productState.products,
                    ref: ref,
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
