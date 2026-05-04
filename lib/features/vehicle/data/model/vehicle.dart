import '../../../auth/domain/entity/user.dart';
import '../../../line/domain/entity/line.dart';

class Vehicle {
  final String id;
  final String model;
  final User driver;
  final Line? currentLine;

  Vehicle({
    required this.id,
    required this.model,
    required this.driver,
    required this.currentLine,
  });

  @override
  String toString() => 'Vehicle($model, Driver: ${driver.name})';
}
