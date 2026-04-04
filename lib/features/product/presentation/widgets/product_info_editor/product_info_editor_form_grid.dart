import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor/product_info_editor_form_state.dart';
import 'package:flutter/material.dart';

class ProductInfoEditorFormGrid extends StatelessWidget {
  const ProductInfoEditorFormGrid({
    super.key,
    required this.controllers,
    required this.onOpenScanner,
    required this.onDropdownChanged,
  });

  final ProductInfoEditorFormControllers controllers;
  final VoidCallback onOpenScanner;
  final VoidCallback onDropdownChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sectionGap = constraints.maxWidth >= 1000 ? 18.0 : 14.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _EditorSection(
              title: '核心信息',
              subtitle: '优先填写书名、作者、ISBN、商品编码和售价',
              child: _ResponsiveFields(
                minFieldWidth: 240,
                maxColumns: 3,
                children: [
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.titleController,
                      '书名',
                      required: true,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.bookIdController,
                      '商品编码',
                      required: true,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.authorController,
                      '作者',
                      required: true,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.priceController,
                      '售价',
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      required: true,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.selfEncodingController,
                      '自编码',
                      hintText: '不填将自动沿用 ISBN 或商品编码',
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.operatorController,
                      '操作人员',
                      readOnly: true,
                    ),
                  ),
                  _GridFieldSpec(
                    span: 2,
                    child: _EditorTextField(
                      controllers.isbnController,
                      'ISBN',
                      required: true,
                      suffixIcon: TextButton.icon(
                        onPressed: onOpenScanner,
                        icon: const Icon(Icons.qr_code_scanner, size: 18),
                        label: const Text('扫码'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sectionGap),
            _EditorSection(
              title: '商品归类',
              subtitle: '用于分类筛选、统计与标签展示',
              child: _ResponsiveFields(
                minFieldWidth: 240,
                maxColumns: 3,
                children: [
                  _GridFieldSpec(
                    child: _EditorDropdown(
                      controller: controllers.categoryController,
                      label: '商品分类',
                      options: productCategoryOptions,
                      onChanged: onDropdownChanged,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorDropdown(
                      controller: controllers.publisherController,
                      label: '出版社',
                      options: productPublisherOptions,
                      onChanged: onDropdownChanged,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorDropdown(
                      controller: controllers.purchaseSaleModeController,
                      label: '购销方式',
                      options: productPurchaseSaleModeOptions,
                      onChanged: onDropdownChanged,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorDropdown(
                      controller: controllers.packagingController,
                      label: '包装',
                      options: productPackagingOptions,
                      onChanged: onDropdownChanged,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorDropdown(
                      controller: controllers.properityController,
                      label: '商品属性',
                      options: productProperityOptions,
                      onChanged: onDropdownChanged,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorDropdown(
                      controller: controllers.statisticalClassController,
                      label: '统计分类',
                      options: productStatisticalClassOptions,
                      onChanged: onDropdownChanged,
                    ),
                  ),
                  _GridFieldSpec(
                    span: 2,
                    child: _EditorTextField(
                      controllers.bookmarkController,
                      '书标',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sectionGap),
            _EditorSection(
              title: '价格与经营参数',
              subtitle: '用于毛利、折扣和补充录入',
              child: _ResponsiveFields(
                minFieldWidth: 220,
                maxColumns: 3,
                children: [
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.internalPricingController,
                      '内部定价',
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.purchasePriceController,
                      '进货价',
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.publicationYearController,
                      '出版年',
                      type: TextInputType.number,
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.retailDiscountController,
                      '零售折扣',
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.wholesaleDiscountController,
                      '批发折扣',
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.wholesalePriceController,
                      '批发价',
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  _GridFieldSpec(
                    child: _EditorTextField(
                      controllers.memberDiscountController,
                      '会员折扣',
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EditorSection extends StatelessWidget {
  const _EditorSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7DED2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF6F6B65),
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _ResponsiveFields extends StatelessWidget {
  const _ResponsiveFields({
    required this.minFieldWidth,
    required this.maxColumns,
    required this.children,
  });

  final double minFieldWidth;
  final int maxColumns;
  final List<_GridFieldSpec> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final columns = (availableWidth / minFieldWidth).floor().clamp(
          1,
          maxColumns,
        );
        const spacing = 14.0;
        final fieldWidth = columns == 1
            ? availableWidth
            : (availableWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children)
              Builder(
                builder: (_) {
                  final effectiveSpan = child.span.clamp(1, columns).toDouble();
                  return SizedBox(
                    width:
                        fieldWidth * effectiveSpan +
                        spacing * (effectiveSpan - 1),
                    child: child.child,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _GridFieldSpec {
  const _GridFieldSpec({required this.child, this.span = 1});

  final Widget child;
  final int span;
}

class _EditorTextField extends StatelessWidget {
  const _EditorTextField(
    this.controller,
    this.label, {
    this.type = TextInputType.text,
    this.required = false,
    this.readOnly = false,
    this.suffixIcon,
    this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool required;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      readOnly: readOnly,
      showCursor: !readOnly,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: const Color(0xFFF8F3EA),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      validator: required
          ? (value) => value == null || value.isEmpty ? '$label 不能为空' : null
          : null,
    );
  }
}

class _EditorDropdown extends StatelessWidget {
  const _EditorDropdown({
    required this.controller,
    required this.label,
    required this.options,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final List<String> options;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      key: ValueKey('$label:${controller.text}'),
      initialValue: options.contains(controller.text)
          ? controller.text
          : options.first,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: const Color(0xFFF8F3EA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      items: options
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        controller.text = value;
        onChanged();
      },
    );
  }
}
