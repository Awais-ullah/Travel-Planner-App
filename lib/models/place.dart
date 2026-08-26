/// A place-to-visit recommendation shown on the Trip Details screen.
class Place {
  const Place({
    required this.name,
    required this.description,
    required this.icon,
  });

  final String name;
  final String description;
  final String icon;
}