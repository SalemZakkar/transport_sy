import 'dart:async';

import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:transport_sy/features/core/presentation/cubit/pay_cubit.dart';
import 'package:transport_sy/features/core/presentation/utils/audio_player.dart';
import 'package:transport_sy/generated/generated_assets/assets.gen.dart';
import 'package:transport_sy/themes/app_colors_shema.dart';

class PaySheet extends StatefulWidget {
  const PaySheet({super.key});

  @override
  State<PaySheet> createState() => _PaySheetState();
}

class _PaySheetState extends State<PaySheet> {
  final PayCubit cubit = PayCubit();
  Timer? timer;
  AssetAudioPlayer assetAudioPlayer = AssetAudioPlayer();

  @override
  void dispose() {
    super.dispose();
    cubit.close();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    cubit.pay();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayCubit, PayState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is PayedState) {
          assetAudioPlayer.play(Assets.sounds.success);
        } else {
          assetAudioPlayer.play(Assets.sounds.fail);
        }
        if (state is PayedState || state is FailedPay || state is ErrorPay) {
          timer = Timer(Duration(seconds: 2), () {
            context.pop();
            timer?.cancel();
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<PayCubit, PayState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is LoadingPayState) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.card_pos_outline,
                            color: LightAppColorSchema().white,
                            size: 48,
                          ),
                        ),
                        16.height(),
                        Text(
                          "المس البطاقة بالقارئ",
                          style: TextStyle(
                            fontSize: 24,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is PayedState) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Clarity.success_line,
                            color: LightAppColorSchema().white,
                            size: 48,
                          ),
                        ),
                        16.height(),
                        Text(
                          "تمت العملية بنجاح",
                          style: TextStyle(
                            fontSize: 24,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is FailedPay) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            BoxIcons.bx_error,
                            color: LightAppColorSchema().white,
                            size: 48,
                          ),
                        ),
                        16.height(),
                        Text(
                          "رصيد البطاقة غير كافي",
                          style: TextStyle(
                            fontSize: 24,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is ErrorPay) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            BoxIcons.bx_error,
                            color: LightAppColorSchema().white,
                            size: 48,
                          ),
                        ),
                        16.height(),
                        Text(
                          "حصل خطأ",
                          style: TextStyle(
                            fontSize: 24,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
