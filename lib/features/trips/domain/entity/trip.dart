
class Trip {
  final int id;
  final int user;
  final String lineName;
  final DateTime startTime;
  final DateTime? endTime;
  final String boardNumber;
  final int amount;

  Trip({
    required this.id,
    required this.lineName,
    required this.startTime,
    this.endTime,
    required this.boardNumber,
    required this.amount,
    required this.user,
  }) {
    if (endTime != null && endTime!.isBefore(startTime)) {
      throw ArgumentError('End time cannot be before start time');
    }
  }
}

List<Trip> trips = [
  Trip(
    id: 0,
    lineName: "خط حماة ساحة العاصي",
    startTime: DateTime.now().subtract(Duration(days: 2)),
    boardNumber: "113253",
    amount: 2000,
    user: 1,
  ),
  Trip(
    id: 1,
    lineName: "خط حماة الاربعين",
    startTime: DateTime.now().subtract(Duration(days: 8)),
    boardNumber: "113253",
    amount: 2000,
    user: 1,
  ),
  Trip(
    id: 2,
    lineName: "خط حماة السوق",
    startTime: DateTime.now().subtract(Duration(days: 3)),
    boardNumber: "113253",
    amount: 2000,
    user: 1,
  ),
  Trip(
    id: 3,
    lineName: "خط حماة الشريعة",
    startTime: DateTime.now().subtract(Duration(days: 1)),
    boardNumber: "113253",
    amount: 2000,
    user: 1,
  ),
];
