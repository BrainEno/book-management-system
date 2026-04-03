import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
import 'package:flutter/material.dart';

class ProductQueryHeader extends StatelessWidget {
  const ProductQueryHeader({
    super.key,
    required this.searchController,
    required this.queryMode,
    required this.totalCount,
    required this.visibleCount,
    required this.selectedCount,
    required this.isBusy,
    required this.exportButtonLabel,
    required this.onQueryModeChanged,
    required this.onCreatePressed,
    required this.onRefreshPressed,
    required this.onExportPressed,
  });

  final TextEditingController searchController;
  final ProductQueryMode queryMode;
  final int totalCount;
  final int visibleCount;
  final int selectedCount;
  final bool isBusy;
  final String exportButtonLabel;
  final ValueChanged<ProductQueryMode?> onQueryModeChanged;
  final VoidCallback onCreatePressed;
  final VoidCallback onRefreshPressed;
  final VoidCallback? onExportPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2D7C8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '商品查询',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '上方切换查询方式，下方使用表格浏览、勾选并导出商品资料。',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppPallete.lightGreyText,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: onCreatePressed,
                    icon: const Icon(Icons.add),
                    label: const Text('新增商品'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onRefreshPressed,
                    icon: const Icon(Icons.refresh),
                    label: const Text('刷新'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: onExportPressed,
                    icon: isBusy && onExportPressed != null
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.download_rounded),
                    label: Text(exportButtonLabel),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 220,
                child: DropdownButtonFormField<ProductQueryMode>(
                  initialValue: queryMode,
                  decoration: InputDecoration(
                    labelText: '查询方式',
                    filled: true,
                    fillColor: const Color(0xFFF8F3EA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: [
                    for (final mode in ProductQueryMode.values)
                      DropdownMenuItem<ProductQueryMode>(
                        value: mode,
                        child: Text(mode.label),
                      ),
                  ],
                  onChanged: onQueryModeChanged,
                ),
              ),
              SizedBox(
                width: 420,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: queryMode.hintText,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: '清空搜索',
                            onPressed: searchController.clear,
                            icon: const Icon(Icons.close),
                          ),
                    filled: true,
                    fillColor: const Color(0xFFF8F3EA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _CountBadge(
                label: '已录入商品',
                value: totalCount.toString(),
                color: const Color(0xFF2E5B4E),
              ),
              _CountBadge(
                label: '当前结果',
                value: visibleCount.toString(),
                color: const Color(0xFF9B6A34),
              ),
              _CountBadge(
                label: '已勾选',
                value: selectedCount.toString(),
                color: const Color(0xFF5C6270),
              ),
              _CountBadge(
                label: '默认导出',
                value: selectedCount > 0
                    ? '选中结果'
                    : searchController.text.trim().isEmpty
                    ? '全部商品'
                    : '查询结果',
                color: const Color(0xFF7B5E83),
              ),
            ],
          ),
          if (isBusy) ...[
            const SizedBox(height: 14),
            const LinearProgressIndicator(minHeight: 4),
          ],
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: '$label  ',
              style: TextStyle(color: color.withValues(alpha: 0.9)),
            ),
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.w700, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
