class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return 'AuthException: $message';
  }
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(super.message);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException(super.message);
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException(super.message);
}

class AuthServerException extends AuthException {
  AuthServerException(super.message);
}
