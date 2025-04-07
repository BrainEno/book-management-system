class Failure {
  final String message;
  final StackTrace? stackTrace;
  Failure({
    this.message = 'An unexpected error happened!',
    this.stackTrace = StackTrace.empty,
  });
}

class CacheFailure extends Failure {
  CacheFailure({super.message = 'Cache Failure'});
}

class AuthFailure extends Failure {
  AuthFailure({super.message = 'Auth Failure'});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = 'Server Failure'});
}
