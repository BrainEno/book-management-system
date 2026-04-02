import 'dart:io';

import 'package:bookstore_management_system/features/product/utils/isbn_sender.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient client;
  late IsbnSender sender;

  setUp(() {
    client = MockHttpClient();
    sender = IsbnSender();

    registerFallbackValue(Uri.parse('http://example.com/isbn'));
  });

  test('returns true when http client returns statusCode 200', () async {
    when(
      () => client.post(
        any(that: isA<Uri>()),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => http.Response('OK', 200));

    final result = await sender.sendIsbn(
      '978-3-16-148410-0',
      'http://192.168.1.5:8080',
      client: client,
    );

    expect(result, isTrue);
    verify(
      () => client.post(
        any(that: isA<Uri>()),
        body: '978-3-16-148410-0',
        headers: {'Content-Type': 'text/plain'},
      ),
    ).called(1);
  });

  test(
    'returns false when http client returns statusCode 500 or throws SocketException',
    () async {
      when(
        () => client.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      final result500 = await sender.sendIsbn(
        '978-3-16-148410-0',
        'http://192.168.1.5:8080',
        client: client,
      );
      expect(result500, isFalse);

      when(
        () => client.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(const SocketException('Failed host lookup'));

      final resultException = await sender.sendIsbn(
        '978-3-16-148410-0',
        'http://192.168.1.5:8080',
        client: client,
      );
      expect(resultException, isFalse);
    },
  );
}
