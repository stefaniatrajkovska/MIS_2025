import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_screen.dart';
import 'meal_detail_screen.dart';
import '../models/meal_detail.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Category>> _future;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchCategories();
  }

  void _openRandom() async {
    try {
      final meal = await ApiService.fetchRandomMeal();
      if (!mounted) return;
      Navigator.pushNamed(context, MealDetailScreen.routeName, arguments: meal.idMeal);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Грешка при повлекување рандом рецепти: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
        actions: [
          TextButton.icon(
            onPressed: _openRandom,
            icon: const Icon(Icons.shuffle, color: Colors.black),
            label: const Text(
              'Рандом рецепт',
              style: TextStyle(color: Colors.black),
            ),
          ),

        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Пребарај категории',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Category>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Грешка: ${snapshot.error}'));
                }
                final categories = snapshot.data ?? [];
                final filtered = _query.isEmpty
                    ? categories
                    : categories.where((c) => c.strCategory.toLowerCase().contains(_query.toLowerCase())).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('Нема категории'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final cat = filtered[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        MealsScreen.routeName,
                        arguments: cat.strCategory,
                      ),
                      child: CategoryCard(category: cat),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
