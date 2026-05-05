import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:transport_sy/features/cards/domain/entity/kcard.dart';
import 'package:transport_sy/features/cards/presentation/cubit/my_cards_cubit.dart';
import 'package:transport_sy/features/cards/presentation/widgets/card_deposit_dialog.dart';
import 'package:transport_sy/features/core/presentation/dialogs/dialog_util.dart';
import 'package:transport_sy/features/core/presentation/widget/bloc/user_builder.dart';
import 'package:transport_sy/themes/app_colors_shema.dart';

class MyCardsWidget extends StatefulWidget {
  const MyCardsWidget({super.key});

  @override
  State<MyCardsWidget> createState() => _MyCardsWidgetState();
}

class _MyCardsWidgetState extends State<MyCardsWidget> {
  var cubit = MyCardsCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return UserBuilder(
      onInit: (v) => cubit.get(v.id),
      builder: (user) => Column(
        children: [
          BlocBuilder<MyCardsCubit, List<KCard>>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                children: [
                  for (var e in state) ...[
                    CustomCardWidget(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Iconsax.card_pos_bold,
                                  color: LightAppColorSchema().secondary,
                                  size: 34,
                                ),
                                IconButton(
                                  onPressed: () {
                                    DialogUtil(
                                      context: context,

                                    ).showConfirmDialog(
                                      message:
                                          "هل تريد الغاء ربط البطاقة ؟ لن تستطيع الاستفادة منها مرة اخرى ! سيتم تحويل رصيد البطاقة لمحفظتك",
                                    );
                                  },
                                  icon: Icon(
                                    OctIcons.unlink,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            8.height(),
                            Text(
                              "بطاقة نقل داخلي",
                              style: TextStyle(fontSize: 24),
                            ),
                            4.height(),
                            Text(
                              e.number,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            16.height(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CardDepositDialog(
                                        onChanged: (a) {
                                          cubit.deposit(e.number, a);
                                          // context.pop();
                                        },
                                      ),
                                    );
                                    // showModalBottomSheet(
                                    //   context: context,
                                    //   useRootNavigator: true,
                                    //   builder: (context) => CardDepositSheet(
                                    //     onChanged: (a, b) {
                                    //       cubit.deposit(e.id, int.parse(b));
                                    //       context.pop();
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  icon: Icon(
                                    Iconsax.wallet_add_1_bold,
                                    size: 32,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    e.balance.toString().formatNum().addSyp,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    16.height(),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
