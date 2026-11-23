import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketing_project/date_picker_page.dart';
import 'package:ticketing_project/departure_city_page.dart';
import 'package:ticketing_project/destination_city_page.dart';
import 'package:ticketing_project/main.dart';
import 'package:ticketing_project/trip_tickets_page.dart';

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
    expect(find.text('Salatiga'), findsOneWidget);
    expect(find.text('Pickup Point'), findsOneWidget);
    expect(find.text('Taman Cerdas Salatiga'), findsOneWidget);
    expect(find.text('Kota Tujuan'), findsOneWidget);
    expect(find.text('Denpasar'), findsOneWidget);
    expect(find.text('Drop Off Point'), findsOneWidget);
    expect(find.text('Pulau Moyo'), findsOneWidget);
    expect(find.text('Tanggal Keberangkatan'), findsOneWidget);
    expect(find.text('Kamis, 22 Oktober 2026'), findsOneWidget);
    expect(find.text('Cari Tiket'), findsOneWidget);

    // Verify Support note
    expect(find.text('Butuh bantuan? Hubungi Support'), findsOneWidget);

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

  testWidgets('DepartureCityPage renders correctly and matches UI', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: DepartureCityPage(selectedCity: 'Malang'),
      ),
    );

    // Verify Header
    expect(find.text('Kota Keberangkatan'), findsOneWidget);
    expect(find.text('Mulai perjalanan Anda dari sini'), findsOneWidget);
    expect(find.text('FN'), findsOneWidget);

    // Verify Search
    expect(find.text('Cari kota keberangkatan'), findsOneWidget);

    // Verify Section Label
    expect(find.text('PILIH KOTA KEBERANGKATAN'), findsOneWidget);

    // Verify Cities visible on screen
    expect(find.widgetWithText(InkWell, 'Malang'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Semarang'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Solo'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Bekasi'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Tangerang'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Blitar'), findsOneWidget);

    // Verify Bottom Note
    expect(find.text('Pickup point dapat dipilih setelah Anda menentukan kota'), findsOneWidget);

    // Verify Bottom Navigation
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Tiket Saya'), findsOneWidget);
    expect(find.text('Booking Saya'), findsOneWidget);
    expect(find.text('Akun'), findsOneWidget);
  });

  testWidgets('DestinationCityPage renders correctly matching uploaded UI', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: DestinationCityPage(
          departureCity: 'Salatiga',
          selectedDestination: 'Tangerang',
        ),
      ),
    );

    // Verify Header
    expect(find.text('Kota Tujuan'), findsOneWidget);
    expect(find.text('Tentukan tujuan perjalanan Anda'), findsOneWidget);

    // Verify Search
    expect(find.text('Cari kota tujuan'), findsOneWidget);

    // Verify Departure Summary Card
    expect(find.text('Berangkat dari'), findsOneWidget);
    expect(find.text('Salatiga'), findsOneWidget);

    // Verify Section Header
    expect(find.text('PILIH KOTA TUJUAN'), findsOneWidget);

    // Verify Cities shown in the design
    expect(find.widgetWithText(InkWell, 'Tangerang'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Bekasi Timur'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Depok'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Bandung'), findsOneWidget);

    // Test Search filter
    await tester.enterText(find.byType(TextField), 'Depok');
    await tester.pump();

    // Verify card is found and other cities are filtered out
    expect(find.widgetWithText(InkWell, 'Depok'), findsOneWidget);
    expect(find.text('Bandung'), findsNothing);

    // Reset filter
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    // Scroll to bottom to verify info card
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pump();

    // Verify Bottom Info Card
    expect(
      find.text('Drop off point dapat dipilih setelah Anda menentukan kota tujuan.'),
      findsOneWidget,
    );
  });

  testWidgets('DatePickerPage renders correctly matching uploaded UI', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        home: DatePickerPage(
          initialDate: DateTime(2026, 10, 22),
          currentDate: DateTime(2026, 10, 19),
        ),
      ),
    );

    // Verify Background elements
    expect(find.text('FN Online Ticketing'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Mau ke mana hari ini?'), findsOneWidget);
    expect(find.text('Perjalanan nyaman bersama Mtrans'), findsOneWidget);

    // Verify Modal Card Header
    expect(find.text('Pilih Tanggal'), findsNWidgets(2)); // Header title and button
    expect(find.byIcon(Icons.close_rounded), findsOneWidget);

    // Verify Selected Departure Date Card
    expect(find.text('TANGGAL KEBERANGKATAN'), findsOneWidget);
    expect(find.text('Kamis, 22 Oktober 2026'), findsOneWidget);

    // Verify Month Selector
    expect(find.text('Oktober 2026'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_left_rounded), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);

    // Verify Weekday Headers
    expect(find.text('Min'), findsOneWidget);
    expect(find.text('Sen'), findsOneWidget);
    expect(find.text('Sel'), findsOneWidget);
    expect(find.text('Rab'), findsOneWidget);
    expect(find.text('Kam'), findsOneWidget);
    expect(find.text('Jum'), findsOneWidget);
    expect(find.text('Sab'), findsOneWidget);

    // Verify Specific Days in October 2026
    expect(find.text('19'), findsOneWidget); // Hari ini
    expect(find.text('22'), findsOneWidget); // Selected

    // Verify Today Legend
    expect(find.text('Hari ini · 19 Oktober 2026'), findsOneWidget);

    // Verify Bottom Navigation items
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Tiket Saya'), findsOneWidget);
    expect(find.text('Booking Saya'), findsOneWidget);
    expect(find.text('Akun'), findsOneWidget);

    // Test tapping another date (e.g. 23 October 2026)
    await tester.tap(find.text('23'));
    await tester.pump();

    // Verify that the top departure date card updates to Jumat, 23 Oktober 2026
    expect(find.text('Jumat, 23 Oktober 2026'), findsOneWidget);
  });

  testWidgets('Dashboard opens custom DatePicker and updates date', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());

    // Tap on Tanggal Keberangkatan card
    await tester.tap(find.text('Tanggal Keberangkatan'));
    await tester.pumpAndSettle();

    // Verify custom date picker modal opens
    expect(find.text('Pilih Tanggal'), findsNWidgets(2));
    expect(find.text('TANGGAL KEBERANGKATAN'), findsOneWidget);
    expect(find.text('Kamis, 22 Oktober 2026'), findsNWidgets(2)); // Dashboard + Modal

    // Tap day 23 to select a different date
    await tester.tap(find.text('23'));
    await tester.pump();

    // Verify modal top card updates to Jumat, 23 Oktober 2026
    expect(find.text('Jumat, 23 Oktober 2026'), findsOneWidget);

    // Tap "Pilih Tanggal" button inside modal
    final selectButton = find.widgetWithText(InkWell, 'Pilih Tanggal');
    await tester.tap(selectButton);
    await tester.pumpAndSettle();

    // Verify modal dismissed and dashboard updated to Jumat, 23 Oktober 2026
    expect(find.text('Jumat, 23 Oktober 2026'), findsOneWidget);
  });

  testWidgets('TripTicketsPage renders correctly matching uploaded UI', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: TripTicketsPage(
          departureCity: 'Salatiga',
          destinationCity: 'Denpasar',
          departureDate: 'Kamis, 22 Oktober 2026',
        ),
      ),
    );

    // Verify Header Bar
    expect(find.text('Tiket Perjalanan'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verify Route & Filter
    expect(find.text('Salatiga'), findsNWidgets(2)); // in route title and in card
    expect(find.text('Denpasar'), findsNWidgets(2)); // in route title and in card
    expect(find.byIcon(Icons.arrow_forward_rounded), findsNWidgets(2)); // in route title and in seat button
    expect(find.byIcon(Icons.tune_rounded), findsOneWidget);

    // Verify Date
    expect(find.text('Kamis, 22 Oktober 2026'), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month_outlined), findsOneWidget);

    // Verify Sorting Section
    expect(find.text('Urutkan berdasarkan'), findsOneWidget);
    expect(find.text('Harga ↑'), findsOneWidget);
    expect(find.text('Keberangkatan'), findsOneWidget);
    expect(find.text('Durasi'), findsOneWidget);

    // Verify Available Trips Section
    expect(find.text('Perjalanan tersedia'), findsOneWidget);

    // Verify Ticket Card
    expect(find.text('SMG'), findsOneWidget);
    expect(find.text('STADIUM SLEEPER I'), findsOneWidget);
    expect(find.text('SEMARANG–SALATIGA–DENPASAR I'), findsOneWidget);
    expect(find.text('13:43'), findsOneWidget);
    expect(find.text('16j 30m'), findsOneWidget);
    expect(find.text('06:13'), findsOneWidget);
    expect(find.text('+1 hari'), findsOneWidget);

    // Verify Price and Seat Button
    expect(find.textContaining('Rp600.000'), findsOneWidget);
    expect(find.textContaining('/seat'), findsOneWidget);
    expect(find.text('Seat Tersedia'), findsOneWidget);

    // Verify Disclaimer and Support Note
    expect(
      find.text('Waktu tiba merupakan estimasi. Lihat fasilitas dan titik keberangkatan pada detail perjalanan.'),
      findsOneWidget,
    );
    expect(find.text('Butuh bantuan? Hubungi Support'), findsOneWidget);

    // Test sort button interaction
    await tester.tap(find.text('Keberangkatan'));
    await tester.pump();
    expect(find.text('Harga'), findsOneWidget); // Inactive state without arrow
  });

  testWidgets('Dashboard navigates to TripTicketsPage when tapping Cari Tiket', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());

    // Tap "Cari Tiket" button on Dashboard
    await tester.tap(find.text('Cari Tiket'));
    await tester.pumpAndSettle();

    // Verify on TripTicketsPage
    expect(find.text('Tiket Perjalanan'), findsOneWidget);
    expect(find.text('STADIUM SLEEPER I'), findsOneWidget);
    expect(find.text('Seat Tersedia'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify back on DashboardPage
    expect(find.text('Mau ke mana hari ini?'), findsOneWidget);
    expect(find.text('Pesan tiket bus'), findsOneWidget);
  });
}
