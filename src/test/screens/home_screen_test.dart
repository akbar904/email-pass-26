
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display a logout button', (WidgetTester tester) async {
			// Arrange
			await tester.pumpWidget(MaterialApp(home: HomeScreen()));

			// Act & Assert
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('should call logout when logout button is tapped', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>.value(
						value: mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			// Act
			await tester.tap(find.text('Logout'));
			await tester.pump();

			// Assert
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
