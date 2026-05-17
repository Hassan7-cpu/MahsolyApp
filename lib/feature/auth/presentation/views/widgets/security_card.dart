import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_cubit.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/change_password_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomButtonAuth(
          buttonText: "Update Password",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<SettingCubit>(),
                  child: const ChangePasswordView(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
