
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('should display LoginScreen initially', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'should emit Authenticated when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [isA<Authenticated>()],
		);

		blocTest<AuthCubit, AuthState>(
			'should emit Unauthenticated when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}
