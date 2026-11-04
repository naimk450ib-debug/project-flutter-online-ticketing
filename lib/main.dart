import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashboard_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FN Online Ticketing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        fontFamilyFallback: const [
          '-apple-system',
          'BlinkMacSystemFont',
          'Segoe UI',
          'Roboto',
          'Plus Jakarta Sans',
          'Inter',
          'Helvetica Neue',
          'sans-serif',
        ],
      ),
      home: const DashboardPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.28, 0.29, 1.0],
            colors: [
              Color(0xFFFFF7F7),
              Color(0xFFFFF7F7),
              Color(0xFFF6F7FB),
              Color(0xFFF6F7FB),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),

                  // Header: Bus Badge & App Title
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFF0F1F5),
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.directions_bus_rounded,
                            color: Color(0xFFFF383C),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'FN Online Ticketing',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Headline: Selamat datang kembali
                  const Text(
                    'Selamat datang kembali',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'Masuk untuk melanjutkan ke dashboard\nperjalanan Anda.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Floating White Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 26, 20, 22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 24,
                          spreadRadius: 0,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Card Title
                        const Text(
                          'Masuk ke akun Anda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            letterSpacing: -0.3,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Card Subtitle
                        const Text(
                          'Gunakan email atau lanjutkan dengan akun\nlain.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Email Input Field
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontSize: 14.5,
                            color: Color(0xFF111827),
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'email@domain.com',
                            hintStyle: const TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F8FC),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF383C),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Red LOGIN Button
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x59FF383C),
                                blurRadius: 14,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Login berhasil sebagai: ${_emailController.text.isNotEmpty ? _emailController.text : "user@domain.com"}',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DashboardPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF383C),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // "atau" divider
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color(0xFFE5E7EB),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text(
                                'atau',
                                style: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xFFE5E7EB),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Social Button 1: Google
                        _SocialButton(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Lanjutkan dengan Google'),
                              ),
                            );
                          },
                          icon: const GoogleLogo(size: 20),
                          label: 'Lanjutkan dengan Google',
                        ),

                        const SizedBox(height: 12),

                        // Social Button 2: Apple
                        _SocialButton(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Lanjutkan dengan Apple'),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.apple,
                            color: Colors.black,
                            size: 24,
                          ),
                          label: 'Lanjutkan dengan Apple',
                        ),

                        const SizedBox(height: 12),

                        // Social Button 3: Nomor HP
                        _SocialButton(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Lanjutkan dengan Nomor HP'),
                              ),
                            );
                          },
                          icon: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFF1F2),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.call_rounded,
                                color: Color(0xFFFF383C),
                                size: 14,
                              ),
                            ),
                          ),
                          label: 'Lanjutkan dengan Nomor HP',
                        ),

                        const SizedBox(height: 22),

                        // Register Link
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Membuka halaman registrasi...'),
                              ),
                            );
                          },
                          child: const Text(
                            'Belum punya akun? Daftar sekarang',
                            style: TextStyle(
                              color: Color(0xFFFF383C),
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final String label;

  const _SocialButton({
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Official multi-color Google 'G' logo vector rendered via CustomPainter
class GoogleLogo extends StatelessWidget {
  final double size;

  const GoogleLogo({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: const _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.save();
    canvas.scale(scale, scale);

    // 1. Red top arc
    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final redPath = Path()
      ..moveTo(12.0, 5.0)
      ..cubicTo(14.09, 5.0, 15.97, 5.72, 17.44, 7.12)
      ..lineTo(21.05, 3.51)
      ..cubicTo(18.66, 1.29, 15.54, 0.0, 12.0, 0.0)
      ..cubicTo(7.33, 0.0, 3.26, 2.68, 1.28, 6.61)
      ..lineTo(5.27, 9.71)
      ..cubicTo(6.23, 6.96, 8.87, 5.0, 12.0, 5.0)
      ..close();
    canvas.drawPath(redPath, redPaint);

    // 2. Yellow left arc
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final yellowPath = Path()
      ..moveTo(5.27, 9.71)
      ..cubicTo(4.99, 10.51, 4.84, 11.37, 4.84, 12.27)
      ..cubicTo(4.84, 13.17, 4.99, 14.03, 5.27, 14.83)
      ..lineTo(1.28, 17.93)
      ..cubicTo(0.46, 16.29, 0.0, 14.44, 0.0, 12.27)
      ..cubicTo(0.0, 10.1, 0.46, 8.25, 1.28, 6.61)
      ..lineTo(5.27, 9.71)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // 3. Green bottom arc
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final greenPath = Path()
      ..moveTo(12.0, 19.54)
      ..cubicTo(8.87, 19.54, 6.23, 17.58, 5.27, 14.83)
      ..lineTo(1.28, 17.93)
      ..cubicTo(3.26, 21.86, 7.33, 24.54, 12.0, 24.54)
      ..cubicTo(15.35, 24.54, 18.23, 23.43, 20.25, 21.57)
      ..lineTo(16.38, 18.57)
      ..cubicTo(15.22, 19.35, 13.72, 19.54, 12.0, 19.54)
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // 4. Blue right bar and upper-right arc
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final bluePath = Path()
      ..moveTo(23.49, 12.27)
      ..cubicTo(23.49, 11.45, 23.41, 10.66, 23.27, 9.9)
      ..lineTo(12.0, 9.9)
      ..lineTo(12.0, 14.64)
      ..lineTo(18.44, 14.64)
      ..cubicTo(18.16, 16.14, 17.31, 17.43, 16.38, 18.57)
      ..lineTo(20.25, 21.57)
      ..cubicTo(22.51, 19.48, 23.49, 16.39, 23.49, 12.27)
      ..close();
    canvas.drawPath(bluePath, bluePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
