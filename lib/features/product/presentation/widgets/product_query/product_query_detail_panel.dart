import 'package:bookstore_management_system/core/theme/app_pallete.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_utils.dart';
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
    required this.publisherController,
    required this.categoryController,
    required this.selfEncodingController,
    required this.categoryOptions,
    required this.publisherOptions,
    required this.isSaving,
    required this.onSave,
    required this.onOpenFullEditor,
    required this.formatDate,
  });

  final GlobalKey<FormState> formKey;
  final ProductModel? product;
  final TextEditingController titleController;
  final TextEditingController productIdController;
  final TextEditingController isbnController;
  final TextEditingController authorController;
  final TextEditingController priceController;
  final TextEditingController publisherController;
  final TextEditingController categoryController;
  final TextEditingController selfEncodingController;
  final List<String> categoryOptions;
  final List<String> publisherOptions;
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback? onOpenFullEditor;
  final String Function(DateTime?) formatDate;

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
                                selectedProduct.title,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  BadgeLabel(
                                    label: '商品编码 ${selectedProduct.productId}',
                                  ),
                                  BadgeLabel(
                                    label: '类别 ${selectedProduct.category}',
                                  ),
                                  BadgeLabel(
                                    label:
                                        '库存 ${formatInventory(selectedProduct)}',
                                  ),
                                ],
                              ),
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
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        MetricCard(
                          label: '售价',
                          value:
                              '¥${formatProductPrice(selectedProduct.price)}',
                          color: const Color(0xFF2E5B4E),
                        ),
                        MetricCard(
                          label: '自编码',
                          value: selectedProduct.selfEncoding.isEmpty
                              ? '--'
                              : selectedProduct.selfEncoding,
                          color: const Color(0xFF8A5A2B),
                        ),
                        MetricCard(
                          label: '更新时间',
                          value: formatDate(selectedProduct.updatedAt),
                          color: const Color(0xFF5C6270),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      '关键资料编辑',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '表格里看到的是基础字段，右侧可以快速修改常用资料；导出时会带上完整商品信息。',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppPallete.lightGreyText,
                      ),
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
                                controller: titleController,
                                label: '书名',
                                validator: requiredValidator('书名'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                controller: authorController,
                                label: '作者',
                                validator: requiredValidator('作者'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                controller: productIdController,
                                label: '商品编码',
                                validator: requiredValidator('商品编码'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                controller: isbnController,
                                label: 'ISBN',
                                validator: requiredValidator('ISBN'),
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditDropdownField(
                                controller: publisherController,
                                label: '出版社',
                                options: publisherOptions,
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditDropdownField(
                                controller: categoryController,
                                label: '商品类别',
                                options: categoryOptions,
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                controller: selfEncodingController,
                                label: '自编码',
                              ),
                            ),
                            SizedBox(
                              width: fieldWidth,
                              child: QuickEditTextField(
                                controller: priceController,
                                label: '售价',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: requiredValidator('售价'),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F2EA),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Wrap(
                        spacing: 18,
                        runSpacing: 14,
                        children: [
                          MetaText(
                            label: '内部 ID',
                            value: '${selectedProduct.id}',
                          ),
                          MetaText(
                            label: '出版年',
                            value: '${selectedProduct.publicationYear}',
                          ),
                          MetaText(
                            label: '购销方式',
                            value: selectedProduct.purchaseSaleMode,
                          ),
                          MetaText(
                            label: '包装',
                            value: selectedProduct.packaging,
                          ),
                          MetaText(
                            label: '统计分类',
                            value: selectedProduct.statisticalClass,
                          ),
                          MetaText(
                            label: '创建时间',
                            value: formatDate(selectedProduct.createdAt),
                          ),
                        ],
                      ),
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
      constraints: const BoxConstraints(minWidth: 120),
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
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
    required this.controller,
    required this.label,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF8F3EA),
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
    required this.controller,
    required this.label,
    required this.options,
  });

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
      key: ValueKey('$label:${controller.text}'),
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

class MetaText extends StatelessWidget {
  const MetaText({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: '$label\n',
              style: TextStyle(color: AppPallete.lightGreyText),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDetailState extends StatelessWidget {
  const _EmptyDetailState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.touch_app_outlined,
              size: 52,
              color: Color(0xFFB9A690),
            ),
            const SizedBox(height: 14),
            Text(
              '从表格中选择一条商品记录',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              '点击行可快速编辑关键信息，勾选多条后可按当前查询结果导出。',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppPallete.lightGreyText),
            ),
          ],
        ),
      ),
    );
  }
}
