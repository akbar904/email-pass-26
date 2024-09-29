
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.flutter_cubit_app/models/user.dart';

void main() {
	group('User Model Tests', () {
		test('User model should serialize from JSON correctly', () {
			final Map<String, dynamic> userJson = {
				'id': '123',
				'name': 'John Doe',
				'email': 'john.doe@example.com'
			};

			final user = User.fromJson(userJson);

			expect(user.id, '123');
			expect(user.name, 'John Doe');
			expect(user.email, 'john.doe@example.com');
		});

		test('User model should deserialize to JSON correctly', () {
			final user = User(id: '123', name: 'John Doe', email: 'john.doe@example.com');

			final userJson = user.toJson();

			expect(userJson['id'], '123');
			expect(userJson['name'], 'John Doe');
			expect(userJson['email'], 'john.doe@example.com');
		});
	});
}
