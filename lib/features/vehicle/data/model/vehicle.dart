
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
    currentLine: 1,
    boardNumber: "34562",
  ),
  Vehicle(
    id: 1,
    model: "BMW",
    driver: "Salem",
    currentLine: 2,
    boardNumber: "766980",
  ),
  Vehicle(
    id: 2,
    model: "honk",
    driver: "John",
    currentLine: 3,
    boardNumber: "223645",
  ),
];
