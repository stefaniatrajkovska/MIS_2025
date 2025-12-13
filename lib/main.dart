import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/categories_screen.dart';
import 'screens/meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 1. ИНИЦИЈАЛИЗАЦИЈА НА FIREBASE
  await Firebase.initializeApp();

  // 🔔 2. ИНИЦИЈАЛИЗАЦИЈА НА NOTIFICATIONS
  await NotificationService.init();

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
