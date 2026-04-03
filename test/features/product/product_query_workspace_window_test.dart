import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/window/app_window_manager.dart';
import 'package:bookstore_management_system/core/window/sub_window_launch_data.dart';
import 'package:bookstore_management_system/core/window/window_pop_out_service.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockProductBloc extends Mock implements ProductBloc {}

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeProductEvent extends Fake implements ProductEvent {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeWindowPopOutService implements WindowPopOutService {
  final List<SubWindowLaunchData> launches = [];
  final List<String> hiddenWindowIds = [];
  final List<String> closedWindowIds = [];
  String nextWindowId = 'floating-child';
  Object? error;

  @override
  Future<String> openSubWindow(SubWindowLaunchData launchData) async {
    launches.add(launchData);
    if (error != null) {
      throw error!;
    }
    return nextWindowId;
  }

  @override
  Future<void> hideSubWindow(String windowId) async {
    hiddenWindowIds.add(windowId);
  }

  @override
  Future<void> closeSubWindow(String windowId) async {
    closedWindowIds.add(windowId);
  }
}

void main() {
  late MockProductBloc productBloc;
  late MockAuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(FakeProductEvent());
    registerFallbackValue(FakeAuthEvent());
  });

  setUp(() async {
    await sl.reset();
    sl.registerSingleton<Logger>(Logger());
    sl.registerSingleton<AppRuntime>(
      const AppRuntime(isSubWindow: true, windowId: 'test-sub-window'),
    );

    productBloc = MockProductBloc();
    when(() => productBloc.state).thenReturn(ProductInitial());
    when(
      () => productBloc.stream,
    ).thenAnswer((_) => const Stream<ProductState>.empty());
    when(() => productBloc.add(any())).thenReturn(null);

    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(
      AuthSuccess(AppUser(id: 1, username: 'tester', role: 'admin')),
    );
    when(
      () => authBloc.stream,
    ).thenAnswer((_) => const Stream<AuthState>.empty());
    when(() => authBloc.add(any())).thenReturn(null);
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets(
    'clicking create product opens a floating product editor window',
    (tester) async {
      tester.view.physicalSize = const Size(1800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final manager = AppWindowManager();
      final popOutService = FakeWindowPopOutService();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: manager,
            child: BlocProvider<AuthBloc>.value(
              value: authBloc,
              child: BlocProvider<ProductBloc>.value(
                value: productBloc,
                child: Scaffold(
                  body: SizedBox(
                    width: 1600,
                    height: 1000,
                    child: ProductQueryWorkspace(
                      windowPopOutService: popOutService,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('新增商品'));
      await tester.pump();

      expect(popOutService.launches, hasLength(1));
      expect(popOutService.launches.single.page, 'product-editor');
      expect(popOutService.launches.single.title, '新建商品资料');
      expect(popOutService.launches.single.bounds, isNotNull);
      expect(popOutService.launches.single.bounds?.width, greaterThan(900));
      expect(popOutService.launches.single.bounds?.height, greaterThan(760));
      expect(
        popOutService.launches.single.state['currentOperatorUsername'],
        'tester',
      );
      expect(manager.floatingWindows, hasLength(1));
      expect(manager.floatingWindows.single.floatingWindowId, 'floating-child');
    },
  );

  testWidgets(
    'failed product editor launch does not leave broken managed window behind',
    (tester) async {
      tester.view.physicalSize = const Size(1800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final manager = AppWindowManager();
      final popOutService = FakeWindowPopOutService()
        ..error = Exception('launch failed');

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: manager,
            child: BlocProvider<AuthBloc>.value(
              value: authBloc,
              child: BlocProvider<ProductBloc>.value(
                value: productBloc,
                child: Scaffold(
                  body: SizedBox(
                    width: 1600,
                    height: 1000,
                    child: ProductQueryWorkspace(
                      windowPopOutService: popOutService,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('新增商品'));
      await tester.pump();

      expect(popOutService.launches, hasLength(1));
      expect(manager.windows, isEmpty);
      expect(find.textContaining('打开子窗口失败'), findsOneWidget);
    },
  );
}
