import 'package:core_package/core_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/features/cards/presentation/cubit/my_cards_cubit.dart';
import 'package:transport_sy/features/line/domain/entity/line.dart';
import 'package:transport_sy/features/trips/domain/entity/trip.dart';
import 'package:transport_sy/features/vehicle/data/model/vehicle.dart';
import 'package:transport_sy/injection.dart';

abstract class PayState {}

class PayedState extends PayState {}

class LoadingPayState extends PayState {}

class FailedPay extends PayState {}

class ErrorPay extends PayState {}

class PayCubit extends Cubit<PayState> {
  PayCubit() : super(LoadingPayState());

  void pay() async {
    try {
      await FlutterNfcKit.poll(androidReaderModeFlags: 0x80 | 0x100 , timeout: Duration(seconds: 4000));
      String selectApdu = "00A4040005F222222222";
      String response = await FlutterNfcKit.transceive(selectApdu);
      String value = _hexToString(response);
      if (kDebugMode) {
        print("Received NFC value: $value");
      }
      String strId = value.split("VEH").first;
      int vId = int.parse(strId);
      Vehicle vehicle = vehicles.where((e) => e.id == vId).first;
      int lineId = vehicle.currentLine;
      Line line = lines.where((e) => e.id == lineId).first;
      for (var e in getIt<MyCardsCubit>().state) {
        if (e.balance < line.amount) {
          emit(FailedPay());
          continue;
        }
        getIt<MyCardsCubit>().deposit(e.number, -line.amount);
        trips.add(
          Trip(
            id: trips.length + 1,
            lineName: line.name,
            startTime: DateTime.now(),
            boardNumber: vehicle.boardNumber,
            amount: line.amount,
            user: getIt<AuthCubit>().state.user.id,
          ),
        );
        emit(PayedState());
        return;
      }
    } catch (e) {
      emit(ErrorPay());
      FlutterNfcKit.finish();
    }
  }

  @override
  Future<void> close() async {
    try {
      await FlutterNfcKit.finish();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return super.close();
  }
}

String _hexToString(String hex) {
  if (hex.isEmpty) return "";

  final bytes = <int>[];

  for (int i = 0; i < hex.length; i += 2) {
    bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
  }

  return String.fromCharCodes(bytes);
}
