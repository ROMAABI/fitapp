import 'package:flutter/material.dart';
import '../../domain/models/workout_model.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Today\'s Workout')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: WorkoutModel.sampleWorkouts.length,
        itemBuilder: (context, index) {
          final workout = WorkoutModel.sampleWorkouts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Image.network(
                  workout.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) =>
                      Container(color: Colors.grey[800], height: 180),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.9),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.timer,
                                size: 16,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 4),
                            Text('${workout.durationMinutes} mins',
                                style: const TextStyle(color: Colors.white70)),
                            const SizedBox(width: 16),
                            Icon(Icons.local_fire_department,
                                size: 16, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text('${workout.caloriesBurned} kcal',
                                style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
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
