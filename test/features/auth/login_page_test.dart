import 'package:bookstore_management_system/core/theme/theme.dart';
import 'package:bookstore_management_system/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookstore_management_system/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late MockAuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();
    when(() => authBloc.stream).thenAnswer((_) => const Stream<AuthState>.empty());
  });

  Future<void> pumpLoginPage(
    WidgetTester tester, {
    required AuthState state,
  }) async {
    when(() => authBloc.state).thenReturn(state);

    await tester.pumpWidget(
      BlocProvider<AuthBloc>.value(
        value: authBloc,
        child: MaterialApp(
          theme: AppTheme.lightThemeMode,
          home: const LoginPage(),
        ),
      ),
    );
  }

  testWidgets('shows progress feedback while login is loading', (tester) async {
    await pumpLoginPage(tester, state: const AuthLoading());

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('正在登录...'), findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('shows normal login button when idle', (tester) async {
    await pumpLoginPage(tester, state: const AuthInitial());

    expect(find.byType(LinearProgressIndicator), findsNothing);
    expect(find.byKey(const ValueKey('login-idle')), findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });
}
