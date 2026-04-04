import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductQueryDetailPanel extends StatelessWidget {
  const ProductQueryDetailPanel({
    super.key,
    required this.formKey,
    required this.product,
    required this.titleController,
    required this.productIdController,
    required this.isbnController,
    required this.authorController,
    required this.priceController,
    required this.publicationYearController,
    required this.purchaseSaleModeController,
    required this.packagingController,
    required this.statisticalClassController,
    required this.publisherController,
    required this.categoryController,
    required this.selfEncodingController,
    required this.categoryOptions,
    required this.publisherOptions,
    required this.isAdminModeEnabled,
    required this.adminModeTimeoutLabel,
    required this.isSaving,
    required this.onSave,
    required this.onRequestAdminMode,
    required this.onOpenFullEditor,
    required this.formatDate,
    this.onDisableAdminMode,
    this.adminModeUserLabel,
  });

  final GlobalKey<FormState> formKey;
  final ProductModel? product;
  final TextEditingController titleController;
  final TextEditingController productIdController;
  final TextEditingController isbnController;
  final TextEditingController authorController;
  final TextEditingController priceController;
  final TextEditingController publicationYearController;
  final TextEditingController purchaseSaleModeController;
  final TextEditingController packagingController;
  final TextEditingController statisticalClassController;
  final TextEditingController publisherController;
  final TextEditingController categoryController;
  final TextEditingController selfEncodingController;
  final List<String> categoryOptions;
  final List<String> publisherOptions;
  final bool isAdminModeEnabled;
  final String adminModeTimeoutLabel;
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback onRequestAdminMode;
  final VoidCallback? onDisableAdminMode;
  final VoidCallback? onOpenFullEditor;
  final String Function(DateTime?) formatDate;
  final String? adminModeUserLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedProduct = product;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5DED1)),
      ),
      child: selectedProduct == null
          ? const _EmptyDetailState()
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '基本信息',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        FilledButton.icon(
                          onPressed: onOpenFullEditor,
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('完整编辑'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: MetricCard(
                            key: const ValueKey('product-query-metric-isbn'),
                            label: 'ISBN',
                            value: selectedProduct.isbn ?? '--',
                            color: const Color(0xFF8A5A2B),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            key: const ValueKey(
                              'product-query-metric-operator',
                            ),
                            label: '操作人',
                            value: selectedProduct.operator ?? '--',
                            color: const Color(0xFF8A5A2B),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            key: const ValueKey(
                              'product-query-metric-created-at',
                            ),
                            label: '创建时间',
                            value: formatDate(selectedProduct.createdAt),
                            color: const Color(0xFF5C6270),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            key: const ValueKey(
                              'product-query-metric-updated-at',
                            ),
                            label: '更新时间',
                            value: formatDate(selectedProduct.updatedAt),
                            color: const Color(0xFF5C6270),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '关键资料编辑',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                isAdminModeEnabled
                                    ? '管理员模式已开启，可直接编辑 ISBN 与售价；关键字段修改会记录审计日志，$adminModeTimeoutLabel无操作会自动退出。'
                                    : '右侧可以快速修改常用资料；ISBN 与售价需要管理员模式后才能编辑。',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppPallete.lightGreyText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (isAdminModeEnabled)
                          TextButton.icon(
                            onPressed: onDisableAdminMode,
                            icon: const Icon(Icons.lock_open_outlined),
                            label: const Text('退出管理员模式'),
                          )
                        else
                          OutlinedButton.icon(
                            onPressed: onRequestAdminMode,
                            icon: const Icon(
                              Icons.admin_panel_settings_outlined,
                            ),
                            label: const Text('管理员模式'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        BadgeLabel(
                          label: isAdminModeEnabled
                              ? '管理员模式：${adminModeUserLabel ?? '已开启'} · $adminModeTimeoutLabel自动退出'
                              : 'ISBN 与售价受保护',
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final wide = constraints.maxWidth >= 560;
                        final fieldWidth = wide
                            ? (constraints.maxWidth - 12) / 2
                            : constraints.maxWidth;

                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-title-field',
                                ),
                                controller: titleController,
                                label: '书名',
                                validator: requiredValidator('书名'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-author-field',
                                ),
                                controller: authorController,
                                label: '作者',
                                validator: requiredValidator('作者'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-product-id-field',
                                ),
                                controller: productIdController,
                                label: '商品编码',
                                validator: requiredValidator('商品编码'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-isbn-field',
                                ),
                                controller: isbnController,
                                label: 'ISBN',
                                readOnly: !isAdminModeEnabled,
                                onTap: isAdminModeEnabled
                                    ? null
                                    : onRequestAdminMode,
                                suffixIcon: isAdminModeEnabled
                                    ? const Icon(Icons.lock_open_outlined)
                                    : const Icon(Icons.lock_outline),
                                validator: isAdminModeEnabled
                                    ? requiredValidator('ISBN')
                                    : null,
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditDropdownField(
                                fieldKey: const ValueKey(
                                  'product-query-publisher-field',
                                ),
                                controller: publisherController,
                                label: '出版社',
                                options: publisherOptions,
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditDropdownField(
                                fieldKey: const ValueKey(
                                  'product-query-category-field',
                                ),
                                controller: categoryController,
                                label: '商品类别',
                                options: categoryOptions,
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-self-encoding-field',
                                ),
                                controller: selfEncodingController,
                                label: '自编码',
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-price-field',
                                ),
                                controller: priceController,
                                label: '售价',
                                readOnly: !isAdminModeEnabled,
                                onTap: isAdminModeEnabled
                                    ? null
                                    : onRequestAdminMode,
                                suffixIcon: isAdminModeEnabled
                                    ? const Icon(Icons.lock_open_outlined)
                                    : const Icon(Icons.lock_outline),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: isAdminModeEnabled
                                    ? requiredValidator('售价')
                                    : null,
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-publication-year-field',
                                ),
                                controller: publicationYearController,
                                label: '出版年',
                                keyboardType: TextInputType.number,
                                validator: optionalIntegerValidator('出版年'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-purchase-sale-mode-field',
                                ),
                                controller: purchaseSaleModeController,
                                label: '购销方式',
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-packaging-field',
                                ),
                                controller: packagingController,
                                label: '包装',
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                fieldKey: const ValueKey(
                                  'product-query-statistical-class-field',
                                ),
                                controller: statisticalClassController,
                                label: '统计分类',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: isSaving ? null : onSave,
                            icon: isSaving
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.save_outlined),
                            label: Text(isSaving ? '保存中...' : '保存关键修改'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

String? Function(String?) requiredValidator(String label) {
  return (value) {
    if (value == null || value.trim().isEmpty) {
      return '$label不能为空';
    }
    return null;
  };
}

String? Function(String?) optionalIntegerValidator(String label) {
  return (value) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty) {
      return null;
    }
    if (int.tryParse(normalized) == null) {
      return '$label格式不正确';
    }
    return null;
  };
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class BadgeLabel extends StatelessWidget {
  const BadgeLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3ECE0),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class QuickEditTextField extends StatelessWidget {
  const QuickEditTextField({
    super.key,
    this.fieldKey,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  final Key? fieldKey;
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      showCursor: !readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: readOnly ? const Color(0xFFF1ECE3) : const Color(0xFFF8F3EA),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class QuickEditDropdownField extends StatelessWidget {
  const QuickEditDropdownField({
    super.key,
    this.fieldKey,
    required this.controller,
    required this.label,
    required this.options,
  });

  final Key? fieldKey;
  final TextEditingController controller;
  final String label;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    final selectedValue =
        controller.text.isEmpty || !options.contains(controller.text)
        ? (options.isEmpty ? null : options.first)
        : controller.text;

    return DropdownButtonFormField<String>(
      key: fieldKey ?? ValueKey('$label:${controller.text}'),
      initialValue: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8F3EA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      items: [
        for (final option in options)
          DropdownMenuItem<String>(value: option, child: Text(option)),
      ],
      onChanged: (value) {
        if (value == null) {
          return;
        }
        controller.text = value;
      },
    );
  }
}

class _EmptyDetailState extends StatelessWidget {
  const _EmptyDetailState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 42,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            '请选择左侧商品查看详情',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            '选中商品后，这里会显示基础信息、快速编辑表单以及导出入口。',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppPallete.lightGreyText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
