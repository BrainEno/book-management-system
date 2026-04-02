String? resolveDesktopUrl(Map<String, dynamic> attributes, int port, bool isAndroid) {
  if (port <= 0) {
    return null;
  }

  final dynamic rawIp = attributes['ip'];
  if (rawIp is! String || rawIp.isEmpty) {
    return null;
  }

  if (rawIp == '127.0.0.1' && isAndroid) {
    return 'http://10.0.2.2:$port';
  }

  return 'http://$rawIp:$port';
}
