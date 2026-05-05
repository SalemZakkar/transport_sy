import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/domain/entity/auth_transaction.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_wallet_cubit.dart';
import 'package:transport_sy/features/auth/presentation/page/widget/auth_card_deposit_dialog.dart';
import 'package:transport_sy/features/core/presentation/widget/bloc/user_builder.dart';
import 'package:transport_sy/injection.dart';

class AuthWalletPage extends StatefulWidget {
  static String path = "/AuthWalletPage";

  const AuthWalletPage({super.key});

  @override
  State<AuthWalletPage> createState() => _AuthWalletPageState();
}

class _AuthWalletPageState extends State<AuthWalletPage> {
  AuthWalletCubit cubit = AuthWalletCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المحفظة")),
      body: UserBuilder(
        onInit: (user) => cubit.get(user.id),
        builder: (user) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height(),
                CustomCardWidget(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Text(
                          "الرصيد",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        16.height(),
                        Text(
                          user.balance.toString().formatNum().addSyp,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        16.height(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => CardDepositDialog(
                                  onChanged: (amount) {
                                    getIt<AuthCubit>().balance(amount);
                                    cubit.addTransaction(
                                      amount: amount,
                                      type: AuthTransactionType.deposit,
                                      notes: "شحن رصيد المحفظة",
                                      userId: user.id,
                                    );
                                  },
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("إيداع رصيد"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                24.height(),

                BlocBuilder<AuthWalletCubit, List<AuthTransaction>>(
                  builder: (context, state) {
                    if (state.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text("لا توجد معاملات حالياً"),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "المعاملات الأخيرة",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        16.height(),
                        for (var e in state) ...[
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black.withOpacity(0.05),
                              //     blurRadius: 4,
                              //     offset: const Offset(0, 2),
                              //   ),
                              // ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    e.type == AuthTransactionType.deposit
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                child: Icon(
                                  e.type == AuthTransactionType.deposit
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: e.type == AuthTransactionType.deposit
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              title: Text(
                                e.notes ??
                                    (e.type == AuthTransactionType.deposit
                                        ? "إيداع"
                                        : "سحب"),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${e.createdAt.year}-${e.createdAt.month}-${e.createdAt.day} ${e.createdAt.hour}:${e.createdAt.minute}",
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: Text(
                                "${e.type == AuthTransactionType.deposit ? '+' : '-'}${e.amount.toString().formatNum().addSyp}",
                                style: TextStyle(
                                  color: e.type == AuthTransactionType.deposit
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                  bloc: cubit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
