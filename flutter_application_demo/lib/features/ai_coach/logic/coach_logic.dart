enum FitnessGoal { loseWeight, maintain, gainMuscle }

enum ActivityLevel { sedentary, lightlyActive, moderatelyActive, veryActive }

enum Gender { male, female }

class UserProfile {
  final int age;
  final double weightKg;
  final double heightCm;
  final Gender gender;
  final FitnessGoal goal;
  final ActivityLevel activityLevel;
  final double dailyBudget;

  UserProfile({
    required this.age,
    required this.weightKg,
    required this.heightCm,
    required this.gender,
    required this.goal,
    required this.activityLevel,
    required this.dailyBudget,
  });
}

class DailyPlan {
  final int targetCalories;
  final int proteinGrams;
  final int carbsGrams;
  final int fatGrams;
  final double estimatedCost;
  final List<String> workoutSuggestions;

  DailyPlan({
    required this.targetCalories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.estimatedCost,
    required this.workoutSuggestions,
  });
}

class AICoachLogic {
  /// Calculates recommendations based on user stats (Rule-based AI)
  static DailyPlan generatePlan(UserProfile user) {
    // 1. Calculate BMR (Mifflin-St Jeor Equation)
    double bmr;
    if (user.gender == Gender.male) {
      bmr = (10 * user.weightKg) + (6.25 * user.heightCm) - (5 * user.age) + 5;
    } else {
      bmr =
          (10 * user.weightKg) + (6.25 * user.heightCm) - (5 * user.age) - 161;
    }

    // 2. Adjust for Activity Level (TDEE)
    double tdee;
    switch (user.activityLevel) {
      case ActivityLevel.sedentary:
        tdee = bmr * 1.2;
        break;
      case ActivityLevel.lightlyActive:
        tdee = bmr * 1.375;
        break;
      case ActivityLevel.moderatelyActive:
        tdee = bmr * 1.55;
        break;
      case ActivityLevel.veryActive:
        tdee = bmr * 1.725;
        break;
    }

    // 3. Adjust for Goal
    double targetCalories = tdee;
    switch (user.goal) {
      case FitnessGoal.loseWeight:
        targetCalories -= 500; // Deficit
        break;
      case FitnessGoal.gainMuscle:
        targetCalories += 300; // Surplus
        break;
      case FitnessGoal.maintain:
        break;
    }

    // 4. Macro Calculation
    // Protein: 2g per kg (High protein for fitness)
    int protein = (user.weightKg * 2.0).round();

    // Fat: 0.8g per kg
    int fat = (user.weightKg * 0.8).round();

    // Carbs: Remaining calories
    // 1g Protein = 4 kcal, 1g Fat = 9 kcal, 1g Carb = 4 kcal
    int caloriesFromProteinAndFat = (protein * 4) + (fat * 9);
    int remainingCalories =
        (targetCalories - caloriesFromProteinAndFat).round();
    int carbs = (remainingCalories / 4).round();

    // Safety checks
    if (carbs < 50) carbs = 50;

    // 5. Workout Suggestions
    List<String> workouts = [];
    if (user.goal == FitnessGoal.gainMuscle) {
      workouts = [
        'Hypertrophy Training (45 mins)',
        'Compound Lifts (Squat, Bench)',
        'Protein loading'
      ];
    } else if (user.goal == FitnessGoal.loseWeight) {
      workouts = [
        'HIIT Cardio (20 mins)',
        'Strength Circuit (30 mins)',
        '10k Steps'
      ];
    } else {
      workouts = [
        'Yoga / Mobility',
        'Steady State Cardio',
        'Maintenance Lifting'
      ];
    }

    // 6. Cost Estimation (Heuristic based on protein requirements)
    // Assuming higher protein needs = higher cost
    double costFactor = protein * 0.15; // Arbitrary currency unit multiplier
    if (costFactor > user.dailyBudget) {
      // Logic to suggest cheaper alternatives would go here
      // For now, we return the estimated base cost
    }

    return DailyPlan(
      targetCalories: targetCalories.round(),
      proteinGrams: protein,
      carbsGrams: carbs,
      fatGrams: fat,
      estimatedCost: costFactor,
      workoutSuggestions: workouts,
    );
  }
}
