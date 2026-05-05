import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/core/presentation/widget/bloc/user_builder.dart';
import 'package:transport_sy/features/trips/domain/entity/trip.dart';

class TripLogsPage extends StatefulWidget {
  static String path = "/TripLogsPage";

  const TripLogsPage({super.key});

  @override
  State<TripLogsPage> createState() => _TripLogsPageState();
}

class _TripLogsPageState extends State<TripLogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("رحلاتي")),
      body: UserBuilder(
        builder: (user) {
          final userTrips = trips.where((e) => e.user == user.id).toList();

          if (userTrips.isEmpty) {
            return const Center(child: Text("لا يوجد رحلات حالياً"));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: userTrips.length,
            separatorBuilder: (context, index) => 16.height(),
            itemBuilder: (context, index) {
              final trip = userTrips[index];
              return CustomCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trip.lineName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          trip.amount.toString().formatNum().addSyp,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    8.height(),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, size: 16),
                        4.width(),
                        Text(
                          trip.startTime.formateDateLocaled(
                            dateTimePattern: DateTimePattern.ddMmmmYyyy,
                            context: context,
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    4.height(),
                    Row(
                      children: [
                        const Icon(Icons.directions_bus, size: 16),
                        4.width(),
                        Text(
                          "رقم المركبة: ${trip.boardNumber}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
