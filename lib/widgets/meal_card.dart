import 'package:flutter/material.dart';
import '../models/meal_summary.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MealCard extends StatelessWidget {
  final MealSummary meal;
  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: meal.strMealThumb,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (c, s) => const Center(child: CircularProgressIndicator()),
                errorWidget: (c, s, e) => const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              meal.strMeal,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
