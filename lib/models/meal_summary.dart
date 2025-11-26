class MealSummary {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strCategory; // optional (present in search results)

  MealSummary({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strCategory,
  });

  // from filter.php (we know the category separately)
  factory MealSummary.fromFilterJson(Map<String, dynamic> json, String category) {
    return MealSummary(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strCategory: category,
    );
  }

  // from search.php or lookup.php (they include category)
  factory MealSummary.fromSearchJson(Map<String, dynamic> json) {
    return MealSummary(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strCategory: json['strCategory'],
    );
  }
}
