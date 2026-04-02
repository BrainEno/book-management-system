import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:intl/intl.dart';

enum ProductQueryMode {
  title,
  productId,
  isbn,
  author,
  selfEncoding,
  category,
  publisher,
}

extension ProductQueryModeX on ProductQueryMode {
  String get label {
    switch (this) {
      case ProductQueryMode.title:
        return '商品名';
      case ProductQueryMode.productId:
        return '商品编码';
      case ProductQueryMode.isbn:
        return 'ISBN';
      case ProductQueryMode.author:
        return '作者';
      case ProductQueryMode.selfEncoding:
        return '自编码';
      case ProductQueryMode.category:
        return '商品种类';
      case ProductQueryMode.publisher:
        return '出版社';
    }
  }

  String get hintText {
    switch (this) {
      case ProductQueryMode.title:
        return '输入商品名进行模糊查询';
      case ProductQueryMode.productId:
        return '输入商品编码进行模糊查询';
      case ProductQueryMode.isbn:
        return '输入 ISBN 进行模糊查询';
      case ProductQueryMode.author:
        return '输入作者进行模糊查询';
      case ProductQueryMode.selfEncoding:
        return '输入自编码进行模糊查询';
      case ProductQueryMode.category:
        return '输入商品种类进行模糊查询';
      case ProductQueryMode.publisher:
        return '输入出版社进行模糊查询';
    }
  }
}

const int defaultInventoryCount = 0;

List<ProductModel> filterAndSortProducts(
  List<ProductModel> products, {
  required ProductQueryMode mode,
  required String query,
}) {
  final needle = query.trim().toLowerCase();
  final filtered =
      needle.isEmpty
          ? List<ProductModel>.from(products)
          : products
              .where(
                (product) => _queryValueForMode(product, mode).contains(needle),
              )
              .toList();

  filtered.sort((a, b) {
    final primary = _productSortKey(a).compareTo(_productSortKey(b));
    if (primary != 0) {
      return primary;
    }

    final secondary = a.title.toLowerCase().compareTo(b.title.toLowerCase());
    if (secondary != 0) {
      return secondary;
    }

    return a.id.compareTo(b.id);
  });

  return filtered;
}

List<ProductModel> resolveProductsForExport({
  required List<ProductModel> visibleProducts,
  required Set<int> selectedProductIds,
}) {
  if (selectedProductIds.isEmpty) {
    return List<ProductModel>.from(visibleProducts);
  }

  return [
    for (final product in visibleProducts)
      if (selectedProductIds.contains(product.id)) product,
  ];
}

String suggestedProductExportFileName({
  DateTime? now,
  required ProductQueryMode queryMode,
  required String query,
}) {
  final dateText = DateFormat('yyyyMMdd').format(now ?? DateTime.now());
  final queryDescriptor = buildProductExportQueryDescriptor(
    queryMode: queryMode,
    query: query,
  );
  return '商品信息导出_${dateText}_$queryDescriptor.csv';
}

String ensureCsvExtension(String path) {
  return path.toLowerCase().endsWith('.csv') ? path : '$path.csv';
}

String buildProductExportQueryDescriptor({
  required ProductQueryMode queryMode,
  required String query,
}) {
  final trimmedQuery = query.trim();
  if (trimmedQuery.isEmpty) {
    return '全部商品';
  }

  final normalizedLabel = _sanitizeFileNameSegment(queryMode.label);
  final normalizedQuery = _sanitizeFileNameSegment(trimmedQuery);
  return '${normalizedLabel}_$normalizedQuery';
}

List<String> buildProductExportHeaders() {
  return const [
    '记录ID',
    '商品名',
    '商品编码',
    'ISBN码',
    '作者',
    '售价',
    '商品种类',
    '库存',
    '出版社',
    '自编码',
    '内部定价',
    '进货价',
    '出版年',
    '零售折扣',
    '批发折扣',
    '批发价',
    '会员折扣',
    '购销方式',
    '书标',
    '包装',
    '商品属性',
    '统计分类',
    '操作员',
    '创建时间',
    '更新时间',
    '附加信息',
  ];
}

List<List<String>> buildProductExportDataRows(List<ProductModel> products) {
  return [for (final product in products) _buildProductExportRow(product)];
}

String buildProductExportCsv(List<ProductModel> products) {
  final rows = [
    buildProductExportHeaders(),
    ...buildProductExportDataRows(products),
  ];

  final buffer = StringBuffer('\uFEFF');
  for (final row in rows) {
    buffer.writeln(row.map(_escapeCsvValue).join(','));
  }
  return buffer.toString();
}

String formatInventory(ProductModel product) {
  return defaultInventoryCount.toString();
}

String formatProductPrice(double value) {
  return _formatNumber(value);
}

String _queryValueForMode(ProductModel product, ProductQueryMode mode) {
  switch (mode) {
    case ProductQueryMode.title:
      return product.title.toLowerCase();
    case ProductQueryMode.productId:
      return product.productId.toLowerCase();
    case ProductQueryMode.isbn:
      return product.isbn.toLowerCase();
    case ProductQueryMode.author:
      return product.author.toLowerCase();
    case ProductQueryMode.selfEncoding:
      return product.selfEncoding.toLowerCase();
    case ProductQueryMode.category:
      return product.category.toLowerCase();
    case ProductQueryMode.publisher:
      return product.publisher.toLowerCase();
  }
}

String _productSortKey(ProductModel product) {
  final keys = [
    product.productId.trim(),
    product.selfEncoding.trim(),
    product.title.trim(),
    product.isbn.trim(),
  ];

  for (final key in keys) {
    if (key.isNotEmpty) {
      return key.toUpperCase();
    }
  }

  return '';
}

List<String> _buildProductExportRow(ProductModel product) {
  return [
    '${product.id}',
    product.title,
    product.productId,
    product.isbn,
    product.author,
    _formatNumber(product.price),
    product.category,
    formatInventory(product),
    product.publisher,
    product.selfEncoding,
    _formatNumber(product.internalPricing),
    _formatNumber(product.purchasePrice),
    '${product.publicationYear}',
    _formatNumber(product.retailDiscount),
    _formatNumber(product.wholesaleDiscount),
    _formatNumber(product.wholesalePrice),
    _formatNumber(product.memberDiscount),
    product.purchaseSaleMode,
    product.bookmark,
    product.packaging,
    product.properity,
    product.statisticalClass,
    product.operator,
    _formatDateTime(product.createdAt),
    _formatDateTime(product.updatedAt),
    product.additionalField,
  ];
}

String _formatNumber(num? value) {
  final safeValue = (value ?? 0).toDouble();
  if (safeValue == safeValue.roundToDouble()) {
    return safeValue.toStringAsFixed(0);
  }

  return safeValue
      .toStringAsFixed(2)
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
}

String _formatDateTime(DateTime? value) {
  if (value == null) {
    return '';
  }
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(value);
}

String _escapeCsvValue(String value) {
  final normalized = value.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  final escaped = normalized.replaceAll('"', '""');
  final shouldQuote =
      escaped.contains(',') || escaped.contains('"') || escaped.contains('\n');
  return shouldQuote ? '"$escaped"' : escaped;
}

String _sanitizeFileNameSegment(String value) {
  final sanitized = value
      .replaceAll(RegExp(r'[\\/:*?"<>|]+'), '_')
      .replaceAll(RegExp(r'\s+'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .trim()
      .replaceAll(RegExp(r'^_+|_+$'), '');

  return sanitized.isEmpty ? '未命名' : sanitized;
}
