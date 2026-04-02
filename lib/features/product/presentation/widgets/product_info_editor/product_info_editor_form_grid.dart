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
        final crossCount = constraints.maxWidth > 800 ? 4 : 2;
        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: 32,
            mainAxisSpacing: 32,
            childAspectRatio: 3.2,
          ),
          children: [
            _EditorTextField(
              controllers.bookIdController,
              '图书ID',
              required: true,
            ),
            _EditorTextField(
              controllers.idController,
              'ID',
              type: TextInputType.number,
              required: true,
            ),
            _EditorTextField(
              controllers.isbnController,
              'ISBN',
              required: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.qr_code_scanner, color: Colors.blue),
                onPressed: onOpenScanner,
              ),
            ),
            _EditorTextField(controllers.titleController, '书名', required: true),
            _EditorTextField(
              controllers.authorController,
              '作者',
              required: true,
            ),
            _EditorDropdown(
              controller: controllers.categoryController,
              label: '商品分类',
              options: productCategoryOptions,
              onChanged: onDropdownChanged,
            ),
            _EditorDropdown(
              controller: controllers.publisherController,
              label: '出版社',
              options: productPublisherOptions,
              onChanged: onDropdownChanged,
            ),
            _EditorTextField(controllers.selfEncodingController, '自编码'),
            _EditorTextField(
              controllers.priceController,
              '售价',
              type: TextInputType.number,
              required: true,
            ),
            _EditorTextField(
              controllers.internalPricingController,
              '内部定价',
              type: TextInputType.number,
            ),
            _EditorTextField(
              controllers.purchasePriceController,
              '进货价',
              type: TextInputType.number,
            ),
            _EditorTextField(
              controllers.publicationYearController,
              '出版年',
              type: TextInputType.number,
            ),
            _EditorTextField(
              controllers.retailDiscountController,
              '零售折扣',
              type: TextInputType.number,
            ),
            _EditorTextField(
              controllers.wholesaleDiscountController,
              '批发折扣',
              type: TextInputType.number,
            ),
            _EditorTextField(
              controllers.wholesalePriceController,
              '批发价',
              type: TextInputType.number,
            ),
            _EditorTextField(
              controllers.memberDiscountController,
              '会员折扣',
              type: TextInputType.number,
            ),
            _EditorDropdown(
              controller: controllers.purchaseSaleModeController,
              label: '购销方式',
              options: productPurchaseSaleModeOptions,
              onChanged: onDropdownChanged,
            ),
            _EditorTextField(controllers.bookmarkController, '书标'),
            _EditorDropdown(
              controller: controllers.packagingController,
              label: '包装',
              options: productPackagingOptions,
              onChanged: onDropdownChanged,
            ),
            _EditorDropdown(
              controller: controllers.properityController,
              label: '商品属性',
              options: productProperityOptions,
              onChanged: onDropdownChanged,
            ),
            _EditorDropdown(
              controller: controllers.statisticalClassController,
              label: '统计分类',
              options: productStatisticalClassOptions,
              onChanged: onDropdownChanged,
            ),
            _EditorTextField(
              controllers.operatorController,
              '操作人员',
              readOnly: true,
            ),
          ],
        );
      },
    );
  }
}

class _EditorTextField extends StatelessWidget {
  const _EditorTextField(
    this.controller,
    this.label, {
    this.type = TextInputType.text,
    this.required = false,
    this.suffixIcon,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool required;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator:
          required
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
      initialValue:
          options.contains(controller.text) ? controller.text : options.first,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items:
          options
              .map(
                (option) =>
                    DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
      onChanged: (value) {
        if (value == null) return;
        controller.text = value;
        onChanged();
      },
    );
  }
}
