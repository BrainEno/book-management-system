import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/widgets/auth_field.dart';

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
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SingleChildScrollView(
            child: Padding(
              padding: AppTheme.responsivePadding(context),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isLoading) ...[
                      const LinearProgressIndicator(),
                      const SizedBox(height: 20),
                    ],
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
                    ElevatedButton(
                      onPressed: isLoading ? null : _onLoginPressed,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        child: isLoading
                            ? const Row(
                                key: ValueKey('login-loading'),
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text("正在登录..."),
                                ],
                              )
                            : const Text(
                                "登录",
                                key: ValueKey('login-idle'),
                              ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 180),
                      opacity: isLoading ? 1 : 0.72,
                      child: Text(
                        isLoading ? '正在校验账号并准备主界面...' : '输入账号密码后进入系统',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
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
