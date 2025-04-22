import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:bookstore_management_system/core/utils/set_window_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/widgets/auth_field.dart';
import 'package:go_router/go_router.dart';

const String loginSuccessMessage = '登录成功';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Handle login button press
  void _onLoginPressed() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text(loginSuccessMessage)));
            setWindowSize(1920, 1080);
            context.go('/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: AppTheme.responsivePadding(context),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '登录',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            32, // Optionally: AppTheme.responsiveFontSize(context, 32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Username field
                    AuthField(
                      hintText: "用户名",
                      controller: usernameController,
                      prefixIcon: Icons.person_2_outlined,
                    ),
                    const SizedBox(height: 20),
                    // Password field
                    AuthField(
                      hintText: "密码",
                      controller: passwordController,
                      isPassword: true,
                      prefixIcon: Icons.lock_outline,
                    ),
                    const SizedBox(height: 30),
                    // Login button or loading indicator
                    ElevatedButton(
                      onPressed: _onLoginPressed,
                      child: const Text("登录"),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
