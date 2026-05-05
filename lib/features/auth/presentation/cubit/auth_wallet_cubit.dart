import 'package:core_package/core_package.dart';
import 'package:transport_sy/features/auth/domain/entity/auth_transaction.dart';

class AuthWalletCubit extends Cubit<List<AuthTransaction>> {
  AuthWalletCubit() : super([]);

  void get(int userId) {
    emit(authTransactions.where((e) => e.userId == userId).toList().reversed.toList());
  }

  void addTransaction({
    required int amount,
    required AuthTransactionType type,
    String? notes,
    required int userId,
  }) {
    final newTransaction = AuthTransaction(
      id: authTransactions.length + 1,
      type: type,
      amount: amount,
      notes: notes,
      createdAt: DateTime.now(),
      userId: userId,
    );
    
    authTransactions.add(newTransaction);
    get(userId);
  }
}
