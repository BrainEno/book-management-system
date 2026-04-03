import 'dart:ui';

import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/window_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppWindowManager', () {
    test('opens multiple windows for the same page key by default', () {
      final manager = AppWindowManager();

      final first = manager.openWindow(
        title: '商品资料',
        popOutPageKey: 'product',
      );
      final second = manager.openWindow(
        title: '商品资料',
        popOutPageKey: 'product',
      );

      expect(manager.windows, hasLength(2));
      expect(first.id, isNot(second.id));
      expect(manager.embeddedWindows, hasLength(2));
    });

    test('minimize and restore keep window instance and bounds', () {
      final manager = AppWindowManager();
      final window = manager.openWindow(
        title: '库存',
        popOutPageKey: 'inventory',
        bounds: const Rect.fromLTWH(40, 50, 880, 620),
      );

      manager.minimizeWindow(window.id);
      expect(manager.minimizedWindows.single.id, window.id);

      manager.restoreMinimizedWindow(
        window.id,
        bounds: const Rect.fromLTWH(60, 80, 900, 640),
      );

      final restored = manager.windowById(window.id)!;
      expect(restored.displayMode, AppWindowDisplayMode.embedded);
      expect(restored.bounds, const Rect.fromLTWH(60, 80, 900, 640));
    });

    test('floating window can dock back and keep latest bounds', () {
      final manager = AppWindowManager();
      final window = manager.openWindow(
        title: '商品编辑',
        popOutPageKey: 'product-editor',
      );

      manager.markWindowFloating(window.id, floatingWindowId: 'child-1');
      expect(manager.floatingWindows.single.floatingWindowId, 'child-1');

      manager.dockWindow(
        window.id,
        bounds: const Rect.fromLTWH(120, 140, 760, 540),
      );

      final docked = manager.windowById(window.id)!;
      expect(docked.displayMode, AppWindowDisplayMode.embedded);
      expect(docked.floatingWindowId, isNull);
      expect(docked.bounds, const Rect.fromLTWH(120, 140, 760, 540));
    });

    test('dock window as minimized returns it to embedded task area', () {
      final manager = AppWindowManager();
      final window = manager.openWindow(
        title: '主控台',
        popOutPageKey: 'dashboard',
      );

      manager.markWindowFloating(window.id, floatingWindowId: 'child-2');
      manager.dockWindow(
        window.id,
        bounds: const Rect.fromLTWH(24, 36, 1000, 700),
        minimized: true,
      );

      expect(manager.minimizedWindows.single.id, window.id);
      expect(manager.windowById(window.id)!.displayMode,
          AppWindowDisplayMode.minimized);
    });

    test('restoring a docked minimized window keeps it embedded and detached from old floating child', () {
      final manager = AppWindowManager();
      final window = manager.openWindow(
        title: '新建商品资料',
        popOutPageKey: 'product-editor',
        bounds: const Rect.fromLTWH(0, 0, 1480, 920),
      );

      manager.markWindowFloating(window.id, floatingWindowId: 'child-editor');
      manager.dockWindow(
        window.id,
        bounds: const Rect.fromLTWH(0, 0, 1480, 920),
        minimized: true,
      );
      manager.restoreMinimizedWindow(window.id);

      final restored = manager.windowById(window.id)!;
      expect(restored.displayMode, AppWindowDisplayMode.embedded);
      expect(restored.floatingWindowId, isNull);
      expect(restored.bounds, const Rect.fromLTWH(0, 0, 1480, 920));
    });

    test('focus raises z-order and keeps window embedded', () {
      final manager = AppWindowManager();
      final first = manager.openWindow(
        title: 'A',
        popOutPageKey: 'dashboard',
      );
      final second = manager.openWindow(
        title: 'B',
        popOutPageKey: 'inventory',
      );

      manager.focusWindow(first.id);

      expect(manager.activeWindow!.id, first.id);
      expect(manager.activeWindow!.zIndex, greaterThan(second.zIndex));
    });

    test('close removes tracked window regardless of current mode', () {
      final manager = AppWindowManager();
      final window = manager.openWindow(
        title: '商品资料',
        popOutPageKey: 'product',
      );
      manager.markWindowFloating(window.id, floatingWindowId: 'child-3');

      manager.closeWindow(window.id);

      expect(manager.windows, isEmpty);
    });

    test('updateWindowPayload keeps tracked draft for later dock restore', () {
      final manager = AppWindowManager();
      final window = manager.openWindow(
        title: '商品编辑',
        popOutPageKey: 'product-editor',
      );

      manager.updateWindowPayload(
        window.id,
        window.payload.copyWith(
          productEditorDraft: const {'title': '未保存书名', 'isbn': '9787'},
        ),
      );

      final updated = manager.windowById(window.id)!;
      expect(updated.payload.productEditorDraft?['title'], '未保存书名');
      expect(updated.payload.productEditorDraft?['isbn'], '9787');
    });
  });
}
