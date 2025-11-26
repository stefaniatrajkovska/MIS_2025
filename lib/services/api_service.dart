import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal_summary.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String base = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Category>> fetchCategories() async {
    final res = await http.get(Uri.parse('$base/categories.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List cats = data['categories'] ?? [];
      return cats.map((c) => Category.fromJson(c)).toList();
    } else {
      throw Exception('Грешка при вчитување категории');
    }
  }

  static Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('$base/filter.php?c=${Uri.encodeComponent(category)}'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => MealSummary.fromFilterJson(m, category)).toList();
    } else {
      throw Exception('Грешка при вчитување јадења');
    }
  }

  // search.php?s={query}
  static Future<List<MealSummary>> searchMeals(String query) async {
    final res = await http.get(Uri.parse('$base/search.php?s=${Uri.encodeComponent(query)}'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List? meals = data['meals'];
      if (meals == null) return [];
      return meals.map((m) => MealSummary.fromSearchJson(m)).toList();
    } else {
      throw Exception('Грешка при пребарување');
    }
  }

  static Future<MealDetail> fetchMealDetailById(String id) async {
    final res = await http.get(Uri.parse('$base/lookup.php?i=${Uri.encodeComponent(id)}'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      if (meals.isEmpty) throw Exception('Рецепт не е најден');
      return MealDetail.fromJson(meals.first);
    } else {
      throw Exception('Грешка при вчитување детали');
    }
  }

  static Future<MealDetail> fetchRandomMeal() async {
    final res = await http.get(Uri.parse('$base/random.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      if (meals.isEmpty) throw Exception('Нема рандом рецепт');
      return MealDetail.fromJson(meals.first);
    } else {
      throw Exception('Грешка при вчитување рандом рецепти');
    }
  }
}
