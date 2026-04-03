import 'dart:convert';

import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:bookstore_management_system/features/product/data/mappers/product_entity_mapper.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> floatWindow({
  required BuildContext context,
  required WindowInfo windowInfo,
  required Size availableSize,
}) async {
  final productBloc = context.read<ProductBloc>();
  final currentState = productBloc.state;
  Map<String, dynamic> windowState = {};

  if (currentState is ProductsLoaded) {
    windowState = {
      'products': currentState.products
          .map((product) => ensureProductModel(product).toJson())
          .toList(),
    };
  }

  final arguments = {
    'page': windowInfo.popOutPageKey,
    'title': windowInfo.title,
    'width': availableSize.width,
    'height': availableSize.height,
    'state': jsonEncode(windowState),
  };

  final controller = await WindowController.create(
    WindowConfiguration(arguments: jsonEncode(arguments)),
  );
  await controller.show();
}
