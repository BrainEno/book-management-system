import 'dart:io';

import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:file_picker/file_picker.dart';

class ProductQueryExportService {
  const ProductQueryExportService({
    this.pickSavePath,
    this.writeFile,
    this.now,
  });

  final Future<String?> Function(String suggestedName)? pickSavePath;
  final Future<void> Function(String path, String content)? writeFile;
  final DateTime Function()? now;

  Future<String?> exportProducts(
    List<ProductModel> products, {
    required ProductQueryMode queryMode,
    required String query,
  }) async {
    final suggestedName = suggestedProductExportFileName(
      now: now?.call(),
      queryMode: queryMode,
      query: query,
    );
    final path = pickSavePath != null
        ? await pickSavePath!(suggestedName)
        : await FilePicker.platform.saveFile(
            dialogTitle: '导出商品资料',
            fileName: suggestedName,
            type: FileType.custom,
            allowedExtensions: const ['csv'],
          );

    if (path == null || path.trim().isEmpty) {
      return null;
    }

    final normalizedPath = ensureCsvExtension(path.trim());
    final content = buildProductExportCsv(products);

    if (writeFile != null) {
      await writeFile!(normalizedPath, content);
      return normalizedPath;
    }

    final file = File(normalizedPath);
    try {
      await file.parent.create(recursive: true);
      await file.writeAsString(content, flush: true);
      return normalizedPath;
    } on FileSystemException catch (error) {
      throw FileSystemException(
        '无法写入导出文件，请确认选择的位置允许当前应用读写',
        error.path,
        error.osError,
      );
    }
  }
}
