import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_workspace_support.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formatProductQueryDateTime keeps day precision only', () {
    final value = DateTime(2026, 4, 4, 15, 30, 45);

    expect(formatProductQueryDateTime(value), '2026-04-04');
  });
}
