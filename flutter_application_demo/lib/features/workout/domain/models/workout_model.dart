
enum ExerciseDifficulty { beginner, intermediate, advanced }

class WorkoutModel {
  final String id;
  final String title;
  final String imageUrl;
  final int durationMinutes;
  final int caloriesBurned;
  final ExerciseDifficulty difficulty;

  const WorkoutModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.difficulty,
  });
  
  // Example data
  static List<WorkoutModel> sampleWorkouts = [
    const WorkoutModel(
      id: '1', 
      title: 'Morning HIIT Ignite', 
      imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438', 
      durationMinutes: 20, 
      caloriesBurned: 250, 
      difficulty: ExerciseDifficulty.intermediate
    ),
    const WorkoutModel(
      id: '2', 
      title: 'Full Body Power', 
      imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e', 
      durationMinutes: 45, 
      caloriesBurned: 400, 
      difficulty: ExerciseDifficulty.advanced
    ),
    const WorkoutModel(
      id: '3', 
      title: 'Yoga Flow & Stretch', 
      imageUrl: 'https://images.unsplash.com/photo-1544367563-12123d8965cd', 
      durationMinutes: 30, 
      caloriesBurned: 120, 
      difficulty: ExerciseDifficulty.beginner
    ),
  ];
}
