import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketing_project/main.dart';

void main() {
  testWidgets('Dashboard page renders correctly smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify Dashboard Top Bar elements
    expect(find.text('FN Online Ticketing'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);

    // Verify Dashboard Headlines
    expect(find.text('Mau ke mana hari ini?'), findsOneWidget);
    expect(find.text('Perjalanan nyaman bersama Mtrans.'), findsOneWidget);

    // Verify Bus ticket booking card
    expect(find.text('Pesan tiket bus'), findsOneWidget);
    expect(find.text('Kota Keberangkatan'), findsOneWidget);
    expect(find.text('Pickup Point'), findsOneWidget);
    expect(find.text('Kota Tujuan'), findsOneWidget);
    expect(find.text('Drop Off Point'), findsOneWidget);
    expect(find.text('Tanggal Keberangkatan'), findsOneWidget);
    expect(find.text('Cari Tiket'), findsOneWidget);

    // Verify Bottom Navigation items
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Tiket Saya'), findsOneWidget);
    expect(find.text('Booking Saya'), findsOneWidget);
    expect(find.text('Akun'), findsOneWidget);
  });

  testWidgets('Login page renders correctly smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.text('FN Online Ticketing'), findsOneWidget);
    expect(find.text('Selamat datang kembali'), findsOneWidget);
    expect(find.text('Masuk ke akun Anda'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
