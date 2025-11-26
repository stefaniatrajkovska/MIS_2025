import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_summary.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late String category;
  late Future<List<MealSummary>> _futureMeals;
  String _query = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    category = arg is String ? arg : '';
    _futureMeals = ApiService.fetchMealsByCategory(category);
  }

  void _doSearch(String q) {
    setState(() {
      _query = q;
      if (q.trim().isEmpty) {
        _futureMeals = ApiService.fetchMealsByCategory(category);
      } else {
        // search globally, then filter by category (search.php returns strCategory)
        _futureMeals = ApiService.searchMeals(q).then((list) {
          return list.where((m) => (m.strCategory ?? '').toLowerCase() == category.toLowerCase()).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Јадења: $category'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Пребарај јадења во категоријата',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _doSearch,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<MealSummary>>(
              future: _futureMeals,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Грешка: ${snapshot.error}'));
                }
                final meals = snapshot.data ?? [];
                if (meals.isEmpty) return const Center(child: Text('Нема јадења'));
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        MealDetailScreen.routeName,
                        arguments: meal.idMeal,
                      ),
                      child: MealCard(meal: meal),
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
