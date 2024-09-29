
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/login_screen.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('renders email, password fields and login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(home: Scaffold(body: LoginScreen())),
			);

			expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
			expect(find.byType(ElevatedButton), findsOneWidget); // Login button
		});

		testWidgets('shows error message on invalid login', (WidgetTester tester) async {
			final authCubit = MockAuthCubit();
			whenListen(
				authCubit,
				Stream.fromIterable([AuthState.error('Invalid credentials')]),
				initialState: AuthState.initial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: Scaffold(body: LoginScreen()),
					),
				),
			);

			await tester.pump(); // Wait for the state to be reflected in the UI

			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});

	group('AuthCubit Login Tests', () {
		blocTest<AuthCubit, AuthState>(
			'emits [loading, authenticated] when login is successful',
			build: () => MockAuthCubit(),
			act: (cubit) => cubit.login('email@example.com', 'password'),
			expect: () => [
				AuthState.loading(),
				AuthState.authenticated(User(id: '1', name: 'Test User', email: 'email@example.com')),
			],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [loading, error] when login fails',
			build: () => MockAuthCubit(),
			act: (cubit) => cubit.login('wrong_email@example.com', 'wrong_password'),
			expect: () => [
				AuthState.loading(),
				AuthState.error('Invalid credentials'),
			],
		);
	});
}
