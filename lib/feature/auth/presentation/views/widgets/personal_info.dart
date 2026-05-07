// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_plant/core/cache/cache_helper.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/functions/snackbar_message.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/app_decoration.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_cubit.dart';
import 'package:save_plant/feature/auth/presentation/cubit/setting_state.dart';
import 'package:save_plant/feature/auth/presentation/views/confirm_email_view.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/profile_edit_tablefield.dart';

class PersonalInfoCard extends StatefulWidget {
  PersonalInfoCard({super.key});

  @override
  State<PersonalInfoCard> createState() => _PersonalInfoCardState();
}

class _PersonalInfoCardState extends State<PersonalInfoCard> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.text = CacheHelper().getData(key: 'email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingCubit, SettingState>(
      listener: (context, state) {
        if (state is ChangeEmailSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConfirmEmailView(email: state.email),
            ),
          );
        }
        if (state is ChangeEmailFailure) {
          snackBarMessage(context, state.error, color: Colors.red);
        }
      },
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state is ChangeEmailLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ProfileEditTablefield(
                      focus: emailFocus,
                      text: 'Email',
                      controller: emailController,
                      isEmail: true,
                    ),
            ],
          );
        },
      ),
    );
  }
}
