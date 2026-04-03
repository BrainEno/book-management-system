// test/features/product/desktop_server_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'dart:io';
import 'package:shelf_router/shelf_router.dart';

void main() {
  group('Desktop HTTP Server Reception', () {
    late String? receivedIsbn;
    late Uri serverUrl;
    late HttpServer server;
    late http.Client httpClient;

    setUp(() async {
      receivedIsbn = null;
      httpClient = http.Client(); // 每个测试使用独立的 client

      final router = Router();
      router.post('/isbn', (Request request) async {
        receivedIsbn = await request.readAsString();
        return Response.ok('Received!');
      });

      final handler = const Pipeline()
          .addMiddleware(logRequests())
          .addHandler(router.call);

      // 使用 127.0.0.1 避免 Windows 上的 localhost (IPv6) 解析延迟或冲突
      server = await shelf_io.serve(handler, '127.0.0.1', 0);
      serverUrl = Uri.parse('http://127.0.0.1:${server.port}');
    });

    tearDown(() async {
      httpClient.close();
      await server.close(force: true);
    });

    test('should receive the correct ISBN via POST request', () async {
      const mockIsbn = '978-3-16-148410-0';

      final response = await httpClient.post(
        serverUrl.resolve('/isbn'),
        body: mockIsbn,
        headers: {'Content-Type': 'text/plain'},
      );

      expect(response.statusCode, 200);
      expect(response.body, 'Received!');
      expect(receivedIsbn, mockIsbn);
    });
  });
}
