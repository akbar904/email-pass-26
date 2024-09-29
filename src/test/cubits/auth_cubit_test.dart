
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:your_package_name/cubits/auth_cubit.dart';
import 'package:your_package_name/models/user.dart';

// Mocking dependencies if any exist in AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, equals(AuthInitial()));
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthAuthenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthLoading(), AuthAuthenticated(User(id: '1', name: 'Test User', email: 'test@example.com'))],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthError] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'password'),
			expect: () => [AuthLoading(), AuthError('Login failed')],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthInitial] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [AuthInitial()],
		);
	});
}
