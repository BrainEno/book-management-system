import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.style,
    this.hintStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.keyboardType,
    this.validator,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderColor =
        widget.borderColor ??
        theme.inputDecorationTheme.border?.borderSide.color ??
        theme.colorScheme.onSurface.withAlpha(51);
    final defaultFocusedColor =
        widget.focusedBorderColor ?? theme.colorScheme.primary;

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      style: widget.style ?? theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle:
            widget.hintStyle ??
            theme.textTheme.bodySmall?.copyWith(fontSize: 16),
        prefixIcon:
            widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: theme.iconTheme.color)
                : null,
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
                : null,
        filled: true,
        fillColor:
            theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
        contentPadding:
            theme.inputDecorationTheme.contentPadding ??
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: _buildBorder(defaultBorderColor),
        enabledBorder: _buildBorder(defaultBorderColor),
        focusedBorder: _buildBorder(defaultFocusedColor),
        errorBorder: _buildBorder(Colors.redAccent),
        focusedErrorBorder: _buildBorder(Colors.redAccent),
      ),
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return '请输入${widget.hintText}';
            }
            if (widget.hintText == '用户名' && value.length < 3) {
              return '用户名必须至少包含 3 个字符';
            }
            if (widget.hintText == '密码' && value.length < 6) {
              return '密码必须至少包含 6 个字符';
            }
            return null;
          },
    );
  }
}
