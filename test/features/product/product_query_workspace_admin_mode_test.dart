import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_query/product_query_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class _MockProductBloc extends Mock implements ProductBloc {}

class _MockAuthBloc extends Mock implements AuthBloc {}

class _FakeProductEvent extends Fake implements ProductEvent {}

class _FakeAuthEvent extends Fake implements AuthEvent {}

ProductModel _buildProduct() {
  return ProductModel(
    id: 1,
    productId: 'book-001',
    title: '等待戈多',
    author: '贝克特',
    isbn: '9787540475277',
    price: 36,
    publisher: '上海译文出版社',
    category: '戏剧',
    selfEncoding: '9787540475277',
  );
}

EditableText _editableTextFor(WidgetTester tester, Key key) {
  return tester.widget<EditableText>(
    find.descendant(of: find.byKey(key), matching: find.byType(EditableText)),
  );
}

Future<void> _pumpDialogTransition(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  late _MockProductBloc productBloc;
  late _MockAuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(_FakeProductEvent());
    registerFallbackValue(_FakeAuthEvent());
  });

  setUp(() {
    sl.registerSingleton<Logger>(Logger());

    productBloc = _MockProductBloc();
    when(() => productBloc.state).thenReturn(ProductInitial());
    when(
      () => productBloc.stream,
    ).thenAnswer((_) => const Stream<ProductState>.empty());
    when(() => productBloc.add(any())).thenReturn(null);

    authBloc = _MockAuthBloc();
    when(
      () => authBloc.state,
    ).thenReturn(AuthSuccess(AppUser(id: 2, username: 'clerk', role: 'staff')));
    when(
      () => authBloc.stream,
    ).thenAnswer((_) => const Stream<AuthState>.empty());
    when(() => authBloc.add(any())).thenReturn(null);
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('admin mode unlocks ISBN and price editing after verification', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    String? verifiedUsername;
    String? verifiedPassword;

    Future<AppUser> verifier({
      required String username,
      required String password,
    }) async {
      verifiedUsername = username;
      verifiedPassword = password;
      return AppUser(id: 1, username: 'admin', role: 'admin');
    }

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<ProductBloc>.value(value: productBloc),
          ],
          child: Scaffold(
            body: SizedBox(
              width: 1600,
              height: 1000,
              child: ProductQueryWorkspace(
                initialProducts: [_buildProduct()],
                adminModeVerifier: verifier,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(
      _editableTextFor(
        tester,
        const ValueKey('product-query-isbn-field'),
      ).readOnly,
      isTrue,
    );

    await tester.ensureVisible(
      find.byKey(const ValueKey('product-query-isbn-field')),
    );
    await tester.tap(find.byKey(const ValueKey('product-query-isbn-field')));
    await _pumpDialogTransition(tester);

    expect(find.text('需要管理员权限'), findsOneWidget);
    expect(find.text('进入管理员模式'), findsOneWidget);

    await tester.tap(find.text('进入管理员模式'));
    await _pumpDialogTransition(tester);

    expect(find.text('验证管理员权限'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('product-query-admin-username')),
      'admin',
    );
    await tester.enterText(
      find.byKey(const ValueKey('product-query-admin-password')),
      'secret',
    );
    await tester.tap(find.text('验证并开启'));
    await _pumpDialogTransition(tester);

    expect(verifiedUsername, 'admin');
    expect(verifiedPassword, 'secret');
    expect(
      _editableTextFor(
        tester,
        const ValueKey('product-query-isbn-field'),
      ).readOnly,
      isFalse,
    );
    expect(
      _editableTextFor(
        tester,
        const ValueKey('product-query-price-field'),
      ).readOnly,
      isFalse,
    );
    expect(find.textContaining('管理员模式：admin'), findsOneWidget);
  });

  testWidgets('admin mode auto exits after inactivity timeout', (tester) async {
    tester.view.physicalSize = const Size(1800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    Future<AppUser> verifier({
      required String username,
      required String password,
    }) async {
      return AppUser(id: 1, username: 'admin', role: 'admin');
    }

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<ProductBloc>.value(value: productBloc),
          ],
          child: Scaffold(
            body: SizedBox(
              width: 1600,
              height: 1000,
              child: ProductQueryWorkspace(
                initialProducts: [_buildProduct()],
                adminModeVerifier: verifier,
                adminModeTimeout: const Duration(seconds: 2),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.ensureVisible(
      find.byKey(const ValueKey('product-query-isbn-field')),
    );
    await tester.tap(find.byKey(const ValueKey('product-query-isbn-field')));
    await _pumpDialogTransition(tester);

    await tester.tap(find.text('进入管理员模式'));
    await _pumpDialogTransition(tester);

    await tester.enterText(
      find.byKey(const ValueKey('product-query-admin-username')),
      'admin',
    );
    await tester.enterText(
      find.byKey(const ValueKey('product-query-admin-password')),
      'secret',
    );
    await tester.tap(find.text('验证并开启'));
    await _pumpDialogTransition(tester);

    expect(
      _editableTextFor(
        tester,
        const ValueKey('product-query-isbn-field'),
      ).readOnly,
      isFalse,
    );

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    expect(
      _editableTextFor(
        tester,
        const ValueKey('product-query-isbn-field'),
      ).readOnly,
      isTrue,
    );
    expect(
      _editableTextFor(
        tester,
        const ValueKey('product-query-price-field'),
      ).readOnly,
      isTrue,
    );
    expect(find.textContaining('ISBN 与售价受保护'), findsOneWidget);
  });
}
