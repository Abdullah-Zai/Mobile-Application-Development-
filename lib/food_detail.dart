import 'package:flutter/material.dart';
import 'food_item.dart';

class FoodDetailPage extends StatelessWidget {
  final FoodItem foodItem;

  const FoodDetailPage({super.key, required this.foodItem});

  String get detailedDescription {
    switch (foodItem.name) {
      case 'Spicy Noodles':
        return 'Authentic Asian-style noodles cooked with fresh vegetables, spicy chili sauce, and a blend of special herbs.';
      case 'Pasta':
        return 'Creamy Alfredo pasta made with premium ingredients and Italian herbs.';
      case 'Chicken Biryani':
        return 'Aromatic basmati rice cooked with tender chicken pieces and authentic spices.';
      default:
        return foodItem.des;
    }
  }

  List<String> get ingredients {
    switch (foodItem.name) {
      case 'Spicy Noodles':
        return ['Noodles', 'Vegetables', 'Chili Sauce'];
      case 'Pasta':
        return ['Pasta', 'Cream', 'Cheese'];
      default:
        return ['Fresh Ingredients', 'Special Spices'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: colors.primary,
            iconTheme: IconThemeData(color: colors.onPrimary),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                foodItem.name,
                style: TextStyle(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.asset(
                foodItem.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ⭐ Rating & Price
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: List.generate(
                            4,
                                (_) => Icon(Icons.star,
                                color: colors.primary, size: 18),
                          )..add(
                            Icon(Icons.star_half,
                                color: colors.primary, size: 18),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Rs ${foodItem.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// 📄 Description
                  Text('Description', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(detailedDescription),

                  const SizedBox(height: 25),

                  /// 🧾 Ingredients
                  Text('Ingredients', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: ingredients
                        .map(
                          (item) => Chip(
                        label: Text(item),
                        backgroundColor: colors.secondaryContainer,
                      ),
                    )
                        .toList(),
                  ),

                  const SizedBox(height: 25),

                  /// 🥗 Nutrition
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _nutritionItem(
                          context, 'Calories', '450', Icons.local_fire_department),
                      _nutritionItem(
                          context, 'Carbs', '65g', Icons.energy_savings_leaf),
                      _nutritionItem(
                          context, 'Protein', '25g', Icons.fitness_center),
                      _nutritionItem(
                          context, 'Fat', '12g', Icons.water_drop),
                    ],
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      /// 🛒 ADD TO CART BAR (✅ CORRECT PLACE)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.outlineVariant)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Price',
                        style: theme.textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text(
                      'Rs ${foodItem.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, foodItem); // ✅ WORKS
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ HELPER METHOD (OUTSIDE build)
  Widget _nutritionItem(
      BuildContext context, String label, String value, IconData icon) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: Icon(icon, color: colors.primary),
        ),
        const SizedBox(height: 6),
        Text(value),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
