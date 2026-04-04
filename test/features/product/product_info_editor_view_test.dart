import 'package:bookstore_management_system/app/bootstrap/app_runtime.dart';
import 'package:bookstore_management_system/core/di/service_locator.dart';
import 'package:bookstore_management_system/core/domain/entities/app_user.dart';
import 'package:bookstore_management_system/core/error/failures.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/product/data/models/product_model.dart';
import 'package:bookstore_management_system/features/product/domain/entities/product.dart';
import 'package:bookstore_management_system/features/product/domain/repositories/product_repository.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/add_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/delete_product_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/get_all_products_usecase.dart';
import 'package:bookstore_management_system/features/product/domain/usecase/update_product_usecase.dart';
import 'package:bookstore_management_system/features/product/presentation/blocs/product_bloc.dart';
import 'package:bookstore_management_system/features/product/presentation/widgets/product_info_editor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

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

Finder _fieldByLabel(String label) {
  return find.ancestor(
    of: find.text(label),
    matching: find.byType(TextFormField),
  );
}

Finder _editableFieldByLabel(String label) {
  return find.descendant(
    of: _fieldByLabel(label),
    matching: find.byType(EditableText),
  );
}

void main() {
  late ProductBloc productBloc;
  late FakeProductRepository productRepository;
  late MockAuthBloc authBloc;

  Widget buildSubject({String? initialOperatorUsername = 'tester'}) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<ProductBloc>.value(value: productBloc),
        ],
        child: ProductInfoEditorView(
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

    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('新建商品资料'), findsOneWidget);
  });

  testWidgets('hides draft action and shows operator in a read-only field', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildSubject());
    await tester.pumpAndSettle();

    expect(find.widgetWithText(OutlinedButton, '保存草稿'), findsNothing);

    final operatorField = tester.widget<EditableText>(
      _editableFieldByLabel('操作人员'),
    );
    expect(operatorField.readOnly, isTrue);
    expect(operatorField.controller.text, 'tester');

    final selfEncodingPosition = tester.getTopLeft(find.text('自编码'));
    final operatorPosition = tester.getTopLeft(find.text('操作人员'));
    expect(operatorPosition.dy, closeTo(selfEncodingPosition.dy, 2));
    expect(operatorPosition.dx, greaterThan(selfEncodingPosition.dx));
  });

  testWidgets(
    'saving a new product submits data without window-channel crashes',
    (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      await tester.enterText(_fieldByLabel('书名 *'), '保存成功测试图书');
      await tester.enterText(_fieldByLabel('商品编码 *'), 'BOOK-002');
      await tester.enterText(_fieldByLabel('作者 *'), '测试作者');
      await tester.enterText(_fieldByLabel('售价 *'), '66');
      await tester.enterText(_fieldByLabel('ISBN *'), '9787300001002');

      await tester.tap(find.widgetWithText(FilledButton, '保存资料'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(productRepository.lastCreatedProduct?.title, '保存成功测试图书');
      expect(productRepository.lastCreatedProduct?.isbn, '9787300001002');
      expect(productRepository.lastCreatedProduct?.operator, 'tester');
      expect(tester.takeException(), isNull);
    },
  );
}
