import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_screen.dart';
import 'screens/meal_detail_screen.dart';

void main() {
  runApp(const MealApp());
}

class MealApp extends StatelessWidget {
  const MealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рецепти',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const CategoriesScreen(),
        MealsScreen.routeName: (_) => const MealsScreen(),
        MealDetailScreen.routeName: (_) => const MealDetailScreen(),
      },
    );
  }
}
