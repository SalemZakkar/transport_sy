import '../../../auth/domain/entity/user.dart';
import '../../../auth/domain/enum/user_type.dart';
import '../../../vehicle/data/model/vehicle.dart';

class Trip {
  final String id;
  final Vehicle vehicle;
  final User rider; // Must be a rider
  final String lineName; // Historical line name (snapshot at trip time)
  final DateTime startTime;
  final DateTime? endTime;

  Trip({
    required this.id,
    required this.vehicle,
    required this.rider,
    required this.lineName,
    required this.startTime,
    this.endTime,
  }) {
    if (rider.type != UserType.rider) {
      throw ArgumentError('Trip rider must be of type UserType.rider');
    }
    if (endTime != null && endTime!.isBefore(startTime)) {
      throw ArgumentError('End time cannot be before start time');
    }
  }

  @override
  String toString() => 'Trip on $lineName by ${rider.name}';
}