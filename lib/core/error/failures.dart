class Failure {
  final String message;
  Failure([this.message = 'An unexpected error happened!']);
}

class CacheFailure extends Failure {
  CacheFailure([super.message = 'Cache Failure']);
}

class AuthFailure extends Failure {
  AuthFailure([super.message = 'Auth Failure']);
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server Failure']);
}
