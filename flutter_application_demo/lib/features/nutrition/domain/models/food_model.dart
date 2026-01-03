
class FoodModel {
  final String id;
  final String name;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final double price; // for expense tracking

  const FoodModel({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.price,
  });

  static List<FoodModel> sampleFoods = [
    const FoodModel(id: '1', name: 'Chicken Breast (100g)', calories: 165, protein: 31, carbs: 0, fat: 3, price: 1.50),
    const FoodModel(id: '2', name: 'Brown Rice (1 cup)', calories: 216, protein: 5, carbs: 45, fat: 2, price: 0.50),
    const FoodModel(id: '3', name: 'Avocado (1 whole)', calories: 322, protein: 4, carbs: 17, fat: 29, price: 2.00),
    const FoodModel(id: '4', name: 'Whey Protein Scoop', calories: 120, protein: 24, carbs: 3, fat: 1, price: 1.00),
  ];
}
