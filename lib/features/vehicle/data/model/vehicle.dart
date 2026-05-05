import '../../../auth/domain/entity/user.dart';
import '../../../line/domain/entity/line.dart';

class Vehicle {
  final String id;
  final String model;
  final User driver;
  final String boardNumber;
  final Line? currentLine;

  Vehicle({
    required this.id,
    required this.model,
    required this.driver,
    required this.currentLine,
    required this.boardNumber,
  });

  @override
  String toString() => 'Vehicle($model, Driver: ${driver.name})';
}
