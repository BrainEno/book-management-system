import 'dart:async';

import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/add_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/delete_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/get_all_products_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/update_product_usecase.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class MockDraftBox extends Mock implements Box<Map<String, String>> {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeProductRepository implements ProductRepository {
  ProductModel? lastCreatedProduct;

  @override
  Future<Either<Failure, Product>> newProduct(ProductModel product) async {
    lastCreatedProduct = product.copyWith(id: 101);
    return right(lastCreatedProduct!);
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    return right(
      lastCreatedProduct == null
          ? const <ProductModel>[]
          : [lastCreatedProduct!],
    );
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductModel productModel) async {
    return right(null);
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    return right(null);
  }

  @override
  Future<Either<Failure, Product>> searchByISBN(String isbn) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> searchByTitle(String title) async {
    throw UnimplementedError();
  }
}

void main() {
  late ProductBloc productBloc;
  late FakeProductRepository productRepository;
  late MockAuthBloc authBloc;
  late MockDraftBox draftBox;

  Widget buildSubject({
    Map<String, String>? initialDraft,
    String? initialOperatorUsername = 'tester',
  }) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<ProductBloc>.value(value: productBloc),
        ],
        child: ProductInfoEditorView(
          initialDraft: initialDraft,
          initialOperatorUsername: initialOperatorUsername,
        ),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
  });

  setUp(() async {
    await sl.reset();
    sl.registerSingleton<Logger>(Logger());
    sl.registerSingleton<AppRuntime>(
      const AppRuntime(
        isSubWindow: true,
        windowId: 'child-window',
        hostWindowId: 'host-window',
      ),
    );

    draftBox = MockDraftBox();
    when(() => draftBox.put(any(), any())).thenAnswer((_) async {});
    when(() => draftBox.delete(any())).thenAnswer((_) async {});
    sl.registerSingleton<Box<Map<String, String>>>(draftBox);

    productRepository = FakeProductRepository();
    productBloc = ProductBloc(
      addProductUsecase: AddProductUsecase(productRepository),
      updateProductUsecase: UpdateProductUsecase(productRepository),
      deleteProductUsecase: DeleteProductUsecase(productRepository),
      getAllProductsUsecase: GetAllProductsUsecase(productRepository),
    );

    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(
      AuthSuccess(const AppUser(id: 1, username: 'tester', role: 'admin')),
    );
    when(
      () => authBloc.stream,
    ).thenAnswer((_) => const Stream<AuthState>.empty());
    when(() => authBloc.add(any())).thenReturn(null);
  });

  tearDown(() async {
    await productBloc.close();
    await sl.reset();
  });

  testWidgets('renders without layout exceptions in a very short window', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 180);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      buildSubject(
        initialDraft: const {
          'title': '布局验证图书',
          'productId': 'BOOK-001',
          'author': '测试作者',
          'price': '58',
          'isbn': '9787300001001',
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('新建商品资料'), findsOneWidget);
  });

  testWidgets(
    'saving a new product submits data without window-channel crashes',
    (tester) async {
      await tester.pumpWidget(
        buildSubject(
          initialDraft: const {
            'title': '保存成功测试图书',
            'productId': 'BOOK-002',
            'author': '测试作者',
            'price': '66',
            'isbn': '9787300001002',
            'operator': 'tester',
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('保存成功测试图书'), findsOneWidget);
      expect(find.text('9787300001002'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, '保存资料'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(productRepository.lastCreatedProduct?.title, '保存成功测试图书');
      expect(productRepository.lastCreatedProduct?.isbn, '9787300001002');
      expect(tester.takeException(), isNull);
    },
  );
}
