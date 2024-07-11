import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:uas_rezza/screens/login_screen.dart';
import 'package:uas_rezza/providers/auth_provider.dart';

void main() {
  testWidgets('Login screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Verify that the login screen is displayed
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Don\'t have an account? Register'), findsOneWidget);

    // Enter text into the username and password fields
    await tester.enterText(find.byType(TextField).at(0), 'user');
    await tester.enterText(find.byType(TextField).at(1), 'password');

    // Tap the login button and trigger a frame
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that the home screen is displayed
    expect(find.text('Welcome, user!'), findsOneWidget);
  });

  testWidgets('Register screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Navigate to the register screen
    await tester.tap(find.text('Don\'t have an account? Register'));
    await tester.pumpAndSettle();

    // Verify that the register screen is displayed
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Enter text into the username and password fields
    await tester.enterText(find.byType(TextField).at(0), 'newuser');
    await tester.enterText(find.byType(TextField).at(1), 'newpassword');

    // Tap the register button and trigger a frame
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    // Verify that the home screen is displayed
    expect(find.text('Welcome, newuser!'), findsOneWidget);
  });
}
