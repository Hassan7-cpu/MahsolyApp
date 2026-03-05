import 'package:flutter/material.dart';
import 'package:save_plant/core/constants/app_colors.dart';
import 'package:save_plant/core/theme/text_style.dart';
import 'package:save_plant/core/functions/validators.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_textformfield.dart';
import 'package:save_plant/feature/auth/presentation/views/widgets/custom_button_auth.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      /// 👇 هنا تحط API call الحقيقي
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update password")),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change Password',
          style: AppTextStyle.giloryBold24(context)
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              CustomTextformfield(
                hintText: "Current Password",
                controller: currentPasswordController,
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter current password";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// New Password
              CustomTextformfield(
                hintText: "New Password",
                controller: newPasswordController,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.visibility,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: Validators.passwordValidator,
              ),

              const SizedBox(height: 20),

              /// Confirm Password
              CustomTextformfield(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                prefixIcon: Icons.lock_reset,
                suffixIcon: Icons.visibility,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: Validators.passwordValidator,
              ),

              const SizedBox(height: 35),

              /// Updated Button
              CustomButtonAuth(
                buttonText: "Update Password",
                onPressed: changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
