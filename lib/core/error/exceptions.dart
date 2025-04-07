import 'dart:core';

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class CacheException implements Exception {
  CacheException({this.message = 'Cache Failure'});
  final String message;
}
