import '../models/meal_summary.dart';

class FavoritesService {
  static final List<MealSummary> _favorites = [];

  static List<MealSummary> get favorites => _favorites;

  static bool isFavorite(String idMeal) {
    return _favorites.any((m) => m.idMeal == idMeal);
  }

  static void toggleFavorite(MealSummary meal) {
    final index = _favorites.indexWhere((m) => m.idMeal == meal.idMeal);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(meal);
    }
  }
}
