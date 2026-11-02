import 'package:flutter_test/flutter_test.dart';
import 'package:ticketing_project/main.dart';

void main() {
  testWidgets('Login page renders correctly smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify header and brand texts
    expect(find.text('FN Online Ticketing'), findsOneWidget);
    expect(find.text('Selamat datang kembali'), findsOneWidget);

    // Verify card texts
    expect(find.text('Masuk ke akun Anda'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);

    // Verify social login options
    expect(find.text('Lanjutkan dengan Google'), findsOneWidget);
    expect(find.text('Lanjutkan dengan Apple'), findsOneWidget);
    expect(find.text('Lanjutkan dengan Nomor HP'), findsOneWidget);

    // Verify footer text
    expect(find.text('Belum punya akun? Daftar sekarang'), findsOneWidget);
  });
}
