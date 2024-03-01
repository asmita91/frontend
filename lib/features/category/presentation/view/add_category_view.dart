import 'package:crimson_cycle/features/category/domain/entity/category_entity.dart';
import 'package:crimson_cycle/features/category/presentation/viewmodel/category_view_model.dart';
import 'package:crimson_cycle/features/category/presentation/widget/load_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCategoryView extends ConsumerStatefulWidget {
  const AddCategoryView({super.key});

  @override
  ConsumerState<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends ConsumerState<AddCategoryView> {
  final gap = const SizedBox(height: 8);
  final categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var categoryState = ref.watch(categoryViewModelProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Category Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter category name';
                }
                return null;
              },
            ),
            gap,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String categoryName = categoryController.text.trim();

                  if (categoryName.isNotEmpty) {
                    CategoryEntity newCategory = CategoryEntity(
                      name: categoryName,
                      slug: categoryName.toLowerCase().replaceAll(' ', '-'),
                    );

                    await ref
                        .read(categoryViewModelProvider.notifier)
                        .addCategory(newCategory);

                    categoryController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a category name.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Add Category'),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List of Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (categoryState.isLoading) ...{
              const Center(child: CircularProgressIndicator()),
            } else if (categoryState.error != null) ...{
              Text(categoryState.error.toString()),
            } else if (categoryState.categories.isEmpty) ...{
              const Center(child: Text('No Categories')),
            } else ...{
              Expanded(
                child: LoadCategory(
                  lstCategories: categoryState.categories,
                  ref: ref,
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
