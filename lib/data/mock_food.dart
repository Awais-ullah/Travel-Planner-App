import '../models/food_item.dart';

/// Food recommendations, keyed by destination name (lowercase).
class MockFood {
  MockFood._();

  static const Map<String, List<FoodItem>> _byDestination = {
    'paris': [
      FoodItem(name: 'Croissant & Café', description: 'Classic French breakfast staple.', icon: 'bakery'),
      FoodItem(name: 'Coq au Vin', description: 'Traditional braised chicken in wine.', icon: 'dish'),
      FoodItem(name: 'French Cheese Board', description: 'A selection of regional cheeses.', icon: 'cheese'),
    ],
    'tokyo': [
      FoodItem(name: 'Sushi', description: 'Fresh, expertly prepared sushi.', icon: 'sushi'),
      FoodItem(name: 'Ramen', description: 'Rich broth noodle bowls.', icon: 'noodles'),
      FoodItem(name: 'Wagyu Beef', description: 'Premium marbled Japanese beef.', icon: 'dish'),
    ],
    'bali': [
      FoodItem(name: 'Nasi Goreng', description: 'Indonesian-style fried rice.', icon: 'rice'),
      FoodItem(name: 'Satay Skewers', description: 'Grilled meat skewers with peanut sauce.', icon: 'skewer'),
      FoodItem(name: 'Fresh Tropical Fruit', description: 'Local mango, dragon fruit, and more.', icon: 'fruit'),
    ],
    'new york': [
      FoodItem(name: 'New York Pizza', description: 'Classic thin-crust foldable slice.', icon: 'pizza'),
      FoodItem(name: 'Bagel with Lox', description: 'A NYC breakfast institution.', icon: 'bagel'),
      FoodItem(name: 'Street Hot Dog', description: 'Grab-and-go city classic.', icon: 'hotdog'),
    ],
    'dubai': [
      FoodItem(name: 'Shawarma', description: 'Spiced, spit-roasted wrap.', icon: 'wrap'),
      FoodItem(name: 'Al Machboos', description: 'Spiced rice with meat, a local specialty.', icon: 'rice'),
      FoodItem(name: 'Arabic Mezze', description: 'Assorted small plates and dips.', icon: 'dish'),
    ],
  };

  static const List<FoodItem> _defaultFood = [
    FoodItem(name: 'Local Specialty', description: 'Try the region\'s signature dish.', icon: 'dish'),
    FoodItem(name: 'Street Food', description: 'Explore popular street food stalls.', icon: 'stall'),
    FoodItem(name: 'Traditional Café', description: 'Relax at a local café or tea house.', icon: 'cafe'),
  ];

  static List<FoodItem> forDestination(String destinationName) {
    final key = destinationName.trim().toLowerCase();
    return _byDestination[key] ?? _defaultFood;
  }
}