import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/domain/entity/user.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/injection.dart';

class UserBuilder extends StatefulWidget {
  final Widget Function(User) builder;

  const UserBuilder({super.key, required this.builder});

  @override
  State<UserBuilder> createState() => _UserBuilderState();
}

class _UserBuilderState extends State<UserBuilder> {
  final cubit = getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.authenticated) {
          return widget.builder(state.user);
        }
        return const SizedBox.shrink();
      },
      bloc: cubit,
    );
  }
}
