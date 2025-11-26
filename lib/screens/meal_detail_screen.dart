import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/mealDetail';
  const MealDetailScreen({super.key});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  late String mealId;
  late Future<MealDetail> _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    mealId = arg is String ? arg : '';
    _future = ApiService.fetchMealDetailById(mealId);
  }

  void _launchYoutubeIfExists(String url) async {
    if (url.isEmpty) return;
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Не може да се отвори YouTube')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали за рецепт'),
      ),
      body: FutureBuilder<MealDetail>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Грешка: ${snap.error}'));
          }
          final meal = snap.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(meal.strMealThumb, width: double.infinity, height: 220, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                Text(meal.strMeal, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text('Категорија: ${meal.strCategory} • Регион: ${meal.strArea}'),
                const SizedBox(height: 12),
                const Text('Упатства', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(meal.strInstructions),
                const SizedBox(height: 12),
                const Text('Состојки', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                ...meal.ingredients.entries.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('${e.key} — ${e.value}'),
                )),
                const SizedBox(height: 12),
                if (meal.strYoutube.isNotEmpty)
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _launchYoutubeIfExists(meal.strYoutube),
                      icon: const Icon(Icons.video_library),
                      label: const Text('Отвори YouTube'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
