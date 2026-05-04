class Point {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Point({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => 'Point($name, $latitude, $longitude)';
}