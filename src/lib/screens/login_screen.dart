
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final _emailController = TextEditingController();
		final _passwordController = TextEditingController();

		return BlocListener<AuthCubit, AuthState>(
			listener: (context, state) {
				if (state is AuthError) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(content: Text(state.message)),
					);
				}
			},
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						TextFormField(
							controller: _emailController,
							decoration: InputDecoration(labelText: 'Email'),
						),
						SizedBox(height: 16.0),
						TextFormField(
							controller: _passwordController,
							decoration: InputDecoration(labelText: 'Password'),
							obscureText: true,
						),
						SizedBox(height: 16.0),
						ElevatedButton(
							onPressed: () {
								final email = _emailController.text;
								final password = _passwordController.text;
								context.read<AuthCubit>().login(email, password);
							},
							child: Text('Login'),
						),
					],
				),
			),
		);
	}
}
