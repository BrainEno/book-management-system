import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:flutter/material.dart';

typedef AdminModeVerifier =
    Future<AppUser> Function({
      required String username,
      required String password,
    });

typedef AdminErrorMessageBuilder = String Function(Object error);

class AdminSupport {
  const AdminSupport._();

  static String formatTimeoutLabel(Duration duration) {
    if (duration.inMinutes >= 1 && duration.inSeconds % 60 == 0) {
      return '${duration.inMinutes}分钟';
    }
    return '${duration.inSeconds}秒';
  }

  static String defaultErrorMessage(Object error) {
    final raw = error.toString().trim();
    if (raw.isEmpty) {
      return '管理员权限验证失败，请稍后重试。';
    }
    if (raw.startsWith('Exception: ')) {
      final trimmed = raw.substring('Exception: '.length).trim();
      return trimmed.isEmpty ? '管理员权限验证失败，请稍后重试。' : trimmed;
    }
    return raw;
  }
}

class AdminCredentialsDialog extends StatefulWidget {
  const AdminCredentialsDialog({
    super.key,
    required this.verifier,
    required this.modeDescription,
    this.usernameFieldKey,
    this.passwordFieldKey,
    this.confirmButtonLabel = '验证并开启',
    this.auditLogPrefix = 'Admin audit',
    this.errorMessageBuilder = AdminSupport.defaultErrorMessage,
  });

  final AdminModeVerifier verifier;
  final String modeDescription;
  final Key? usernameFieldKey;
  final Key? passwordFieldKey;
  final String confirmButtonLabel;
  final String auditLogPrefix;
  final AdminErrorMessageBuilder errorMessageBuilder;

  @override
  State<AdminCredentialsDialog> createState() => _AdminCredentialsDialogState();
}

class _AdminCredentialsDialogState extends State<AdminCredentialsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSubmitting = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final verifiedUser = await widget.verifier(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(verifiedUser);
    } catch (error, stackTrace) {
      final message = widget.errorMessageBuilder(error);
      AppLogger.logger.w(
        '${widget.auditLogPrefix}: '
        'event=admin-mode.verification-failed, '
        'username=${_usernameController.text.trim()}, '
        'message=$message',
        error: error,
        stackTrace: stackTrace,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _isSubmitting = false;
        _errorMessage = message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.lock_outline),
      title: const Text('验证管理员权限'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.modeDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: widget.usernameFieldKey,
                controller: _usernameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: '管理员账户',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入管理员账户';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                key: widget.passwordFieldKey,
                controller: _passwordController,
                obscureText: _obscurePassword,
                onFieldSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: '管理员密码',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入管理员密码';
                  }
                  return null;
                },
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting
              ? null
              : () => Navigator.of(context).pop<AppUser?>(null),
          child: const Text('取消'),
        ),
        FilledButton.icon(
          onPressed: _isSubmitting ? null : _submit,
          icon: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.verified_user_outlined),
          label: Text(_isSubmitting ? '验证中...' : widget.confirmButtonLabel),
        ),
      ],
    );
  }
}
