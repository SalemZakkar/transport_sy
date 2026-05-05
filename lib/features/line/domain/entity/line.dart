import 'package:transport_sy/features/points/domain/entity/points.dart';
import 'package:transport_sy/features/vehicle/data/model/vehicle.dart';

class Line {
  final int id;
  final String name;
  final int amount;
  final List<Point> points; // Ordered stops on this line
  final List<Vehicle> vehicles; // Vehicles currently operating on this line

  Line({
    required this.id,
    required this.name,
    this.points = const [],
    this.vehicles = const [],
    required this.amount,
  });

  @override
  String toString() =>
      'Line($name, ${points.length} stops, ${vehicles.length} vehicles)';
}

List<Line> lines = [Line(id: 0, name: "name", amount: 1000)];
