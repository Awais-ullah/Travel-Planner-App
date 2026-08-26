import 'package:flutter/material.dart';

/// Maps the plain-string icon keys stored in models (Place, FoodItem, etc.)
/// to real Flutter IconData. Keeping this mapping in the widget layer keeps
/// models free of Flutter imports (per the clean architecture separation).
class IconMapper {
  IconMapper._();

  static const Map<String, IconData> _icons = {
    'landmark': Icons.account_balance_outlined,
    'museum': Icons.museum_outlined,
    'hill': Icons.terrain_outlined,
    'boat': Icons.directions_boat_outlined,
    'temple': Icons.temple_buddhist_outlined,
    'city': Icons.location_city_outlined,
    'tower': Icons.cell_tower_outlined,
    'store': Icons.storefront_outlined,
    'terrace': Icons.landscape_outlined,
    'beach': Icons.beach_access_outlined,
    'park': Icons.park_outlined,
    'bridge': Icons.alt_route_outlined,
    'desert': Icons.wb_sunny_outlined,
    'island': Icons.waves_outlined,
    'skyline': Icons.apartment_outlined,
    'globe': Icons.public,
    'bakery': Icons.bakery_dining_outlined,
    'dish': Icons.restaurant_menu_outlined,
    'cheese': Icons.lunch_dining_outlined,
    'sushi': Icons.set_meal_outlined,
    'noodles': Icons.ramen_dining_outlined,
    'rice': Icons.rice_bowl_outlined,
    'skewer': Icons.kebab_dining_outlined,
    'fruit': Icons.apple,
    'pizza': Icons.local_pizza_outlined,
    'bagel': Icons.bakery_dining_outlined,
    'hotdog': Icons.lunch_dining_outlined,
    'wrap': Icons.fastfood_outlined,
    'stall': Icons.storefront_outlined,
    'cafe': Icons.local_cafe_outlined,
  };

  static IconData resolve(String key) => _icons[key] ?? Icons.place_outlined;
}