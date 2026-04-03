import 'package:bookstore_management_system/app/navigation/app_window_destination.dart';
import 'package:bookstore_management_system/core/common/logger/app_logger.dart';
import 'package:bookstore_management_system/core/window/sub_window_launch_data.dart';
import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:bookstore_management_system/features/product/data/mappers/product_entity_mapper.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract interface class WindowPopOutService {
  Future<String> openSubWindow(SubWindowLaunchData launchData);

  Future<void> hideSubWindow(String windowId);

  Future<void> closeSubWindow(String windowId);
}

class DesktopWindowPopOutService implements WindowPopOutService {
  const DesktopWindowPopOutService();

  @override
  Future<String> openSubWindow(SubWindowLaunchData launchData) async {
    AppLogger.logger.i(
      'Opening floating sub-window: page=${launchData.page}, host=${launchData.hostWindowId}, title=${launchData.title}',
    );
    final controller = await WindowController.create(
      WindowConfiguration(hiddenAtLaunch: true, arguments: launchData.encode()),
    );
    await controller.show();
    AppLogger.logger.i(
      'Floating sub-window opened: page=${launchData.page}, host=${launchData.hostWindowId}, child=${controller.windowId}',
    );
    return controller.windowId;
  }

  @override
  Future<void> hideSubWindow(String windowId) async {
    AppLogger.logger.i('Hiding floating sub-window: child=$windowId');
    final controller = WindowController.fromWindowId(windowId);
    await controller.hide();
  }

  @override
  Future<void> closeSubWindow(String windowId) async {
    AppLogger.logger.i('Closing floating sub-window: child=$windowId');
    final controller = WindowController.fromWindowId(windowId);
    await controller.invokeMethod<void>('window_close');
  }
}

SubWindowLaunchData createLaunchDataForWindow({
  required BuildContext context,
  required WindowInfo windowInfo,
  required Rect globalBounds,
}) {
  var payload = windowInfo.payload;
  if (windowInfo.popOutPageKey == 'product') {
    final currentState = context.read<ProductBloc>().state;
    if (currentState is ProductsLoaded) {
      payload = AppWindowPayload(
        initialProducts: currentState.products
            .map(ensureProductModel)
            .toList(),
      );
    }
  }

  return SubWindowLaunchData(
    page: windowInfo.popOutPageKey,
    title: windowInfo.title,
    hostWindowId: windowInfo.id,
    state: payload.toJson(),
    bounds: SubWindowBounds.fromRect(globalBounds),
  );
}
