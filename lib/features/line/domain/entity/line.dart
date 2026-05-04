import 'package:transport_sy/features/points/domain/entity/points.dart';
import 'package:transport_sy/features/vehicle/data/model/vehicle.dart';

class Line {
  final String id;
  final String name;
  final List<Point> points; // Ordered stops on this line
  final List<Vehicle> vehicles; // Vehicles currently operating on this line

  Line({
    required this.id,
    required this.name,
    this.points = const [],
    this.vehicles = const [],
  });

  @override
  String toString() =>
      'Line($name, ${points.length} stops, ${vehicles.length} vehicles)';
}
