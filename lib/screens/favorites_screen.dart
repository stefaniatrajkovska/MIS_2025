import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesService.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Омилени рецепти')),
      body: favorites.isEmpty
          ? const Center(child: Text('Нема омилени рецепти'))
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, i) {
          final meal = favorites[i];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              MealDetailScreen.routeName,
              arguments: meal.idMeal,
            ),
            child: MealCard(meal: meal),
          );
        },
      ),
    );
  }
}
