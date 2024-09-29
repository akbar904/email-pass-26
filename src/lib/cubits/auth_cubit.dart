
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		emit(AuthLoading());
		try {
			// Simulating network call
			await Future.delayed(Duration(seconds: 1));
			if (email == 'test@example.com' && password == 'password') {
				User user = User(id: '1', name: 'Test User', email: email);
				emit(AuthAuthenticated(user));
			} else {
				emit(AuthError('Login failed'));
			}
		} catch (e) {
			emit(AuthError('An error occurred'));
		}
	}

	void logout() {
		emit(AuthInitial());
	}
}

abstract class AuthState extends Equatable {
	@override
	List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
	final User user;

	AuthAuthenticated(this.user);

	@override
	List<Object> get props => [user];
}

class AuthError extends AuthState {
	final String message;

	AuthError(this.message);

	@override
	List<Object> get props => [message];
}
