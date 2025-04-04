import 'package:bookstore_management_system/core/common/widgets/destination_view.dart';
import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/auth/presentation/pages/signup_page.dart';
import 'package:bookstore_management_system/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  final Destination? destination;
  const LoginPage({super.key, this.destination});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark; // Check for dark mode

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode
                ? AppPallete.blackColor
                : Colors.white, // Dark AppBar background in dark mode
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ), // Light back arrow in dark mode
      ),
      backgroundColor:
          isDarkMode
              ? AppPallete.blackColor
              : Colors.white, // Dark background for Scaffold in dark mode
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  '登录',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode
                            ? Colors.white
                            : Colors.black87, // Light title text in dark mode
                  ),
                ),
                const SizedBox(height: 40),
                AuthField(
                  hintText: "邮箱",
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ), // Light input text in dark mode
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ), // Lighter hint text in dark mode
                  borderColor:
                      isDarkMode
                          ? Colors.grey[700]
                          : Colors.grey[400], // Darker border in dark mode
                  focusedBorderColor: AppPallete.gradient2,
                ),
                const SizedBox(height: 20),
                AuthField(
                  hintText: "密码",
                  controller: passwordController,
                  isObscureText: true,
                  prefixIcon: Icons.lock_outline,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ), // Light input text in dark mode
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ), // Lighter hint text in dark mode
                  borderColor:
                      isDarkMode
                          ? Colors.grey[700]
                          : Colors.grey[400], // Darker border in dark mode
                  focusedBorderColor: AppPallete.gradient2,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: Text("登录"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, SignUpPage.route()),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "没有账号？",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[700],
                        ), // Lighter "No account?" text in dark mode
                        children: [
                          TextSpan(
                            text: '注册',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppPallete.gradient2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
