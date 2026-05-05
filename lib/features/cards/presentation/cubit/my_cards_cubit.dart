import 'dart:math';

import 'package:core_package/core_package.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/features/cards/domain/entity/kcard.dart';
import 'package:transport_sy/injection.dart';

class MyCardsCubit extends Cubit<List<KCard>> {
  MyCardsCubit() : super([]);

  void get(int user) {
    emit(List.from(cards.where((e) => e.userId == user)));
  }

  bool withDraw(int id, int amount) {
    final index = cards.indexWhere((e) => e.id == id);
    if (index != -1) {
      final card = cards[index];
      if (card.balance >= amount) {
        cards[index] = KCard(
          id: card.id,
          userId: card.userId,
          number: card.number,
          balance: card.balance - amount,
          deletable: card.deletable,
        );
        emit(List.from(cards));
        return true;
      }
    }
    return false;
  }

  void deposit(String cardNumber, int amount) {
    final index = cards.indexWhere((e) => e.number == cardNumber);
    if (index != -1) {
      final card = cards[index];
      cards[index] = KCard(
        userId: card.userId,
        id: card.id,
        number: card.number,
        balance: card.balance + amount,
        deletable: card.deletable,
      );
      emit(List.from(cards));
    }
  }

  void delete(int id) {
    emit(List.from(state.where((e) => e.id != id)));
  }

  bool exists(String number) {
    return state.any((e) => e.number == number);
  }

  void add(String number) {
    emit(
      List.from([
        KCard(
          id: state.length,
          number: number,
          balance: Random(DateTime.now().microsecond).nextInt(200000) + 10000,
          userId: getIt<AuthCubit>().state.user.id,
          deletable: true,
        ),
        ...state,
      ]),
    );
  }
}
