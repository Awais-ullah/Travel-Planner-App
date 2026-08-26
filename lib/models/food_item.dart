/// A food/cuisine recommendation shown on the Trip Details screen.
class FoodItem {
  const FoodItem({
    required this.name,
    required this.description,
    required this.icon,
  });

  final String name;
  final String description;
  final String icon;
}