
class Vehicle {
  final int id;
  final String model;
  final String driver;
  final String boardNumber;
  final int currentLine;

  Vehicle({
    required this.id,
    required this.model,
    required this.driver,
    required this.currentLine,
    required this.boardNumber,
  });
}

List<Vehicle> vehicles = [
  Vehicle(
    id: 0,
    model: "SUZUKI",
    driver: "ALI",
    currentLine: 0,
    boardNumber: "123456",
  ),
];
