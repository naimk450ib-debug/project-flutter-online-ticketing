import 'package:flutter/material.dart';

import 'main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedBottomNavIndex = 0;

  // Selected values for the booking form
  String _departureCity = 'Pilih kota keberangkatan';
  String _pickupPoint = 'Pilih pickup point';
  String _destinationCity = 'Pilih kota tujuan';
  String _dropOffPoint = 'Pilih drop off point';
  String _departureDate = 'Pilih tanggal keberangkatan';

  void _swapCities() {
    setState(() {
      final tempCity = _departureCity;
      _departureCity = _destinationCity;
      _destinationCity = tempCity;

      final tempPoint = _pickupPoint;
      _pickupPoint = _dropOffPoint;
      _dropOffPoint = tempPoint;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kota keberangkatan dan tujuan ditukar'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF383C),
              onPrimary: Colors.white,
              onSurface: Color(0xFF111827),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'Mei',
          'Jun',
          'Jul',
          'Agu',
          'Sep',
          'Okt',
          'Nov',
          'Des',
        ];
        _departureDate =
            '${picked.day} ${months[picked.month - 1]} ${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.25, 0.26, 1.0],
            colors: [
              Color(0xFFFFF7F7),
              Color(0xFFFFF7F7),
              Color(0xFFF6F7FB),
              Color(0xFFF6F7FB),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Top Bar: Notification Bell, App Title, Profile Button
                  Row(
                    children: [
                      // Bell Notification Icon
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tidak ada notifikasi baru'),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
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
                              Icons.notifications_none_rounded,
                              color: Color(0xFFFF383C),
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Brand Title
                      const Text(
                        'FN Online Ticketing',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          letterSpacing: -0.3,
                        ),
                      ),

                      const Spacer(),

                      // Profile Button
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.account_circle_outlined,
                              color: Color(0xFFFF383C),
                              size: 24,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Profil',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Headline: Mau ke mana hari ini?
                  const Text(
                    'Mau ke mana hari ini?',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Subtitle
                  const Text(
                    'Perjalanan nyaman bersama Mtrans.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Main White Card: Pesan tiket bus
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Header
                        const Row(
                          children: [
                            Icon(
                              Icons.directions_bus_outlined,
                              color: Color(0xFFFF383C),
                              size: 22,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Pesan tiket bus',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Field 1: Kota Keberangkatan
                        _FormFieldCard(
                          icon: const Icon(
                            Icons.radio_button_checked,
                            color: Color(0xFFFF383C),
                            size: 19,
                          ),
                          label: 'Kota Keberangkatan',
                          value: _departureCity,
                          isPlaceholder:
                              _departureCity == 'Pilih kota keberangkatan',
                          onTap: () {
                            _showCityPicker(
                              title: 'Pilih Kota Keberangkatan',
                              onSelected: (city) =>
                                  setState(() => _departureCity = city),
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        // Field 2: Pickup Point
                        _FormFieldCard(
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFFFF383C),
                            size: 20,
                          ),
                          label: 'Pickup Point',
                          value: _pickupPoint,
                          isPlaceholder: true,
                          onTap: () {
                            _showLocationPicker(
                              title: 'Pilih Pickup Point',
                              onSelected: (loc) =>
                                  setState(() => _pickupPoint = loc),
                            );
                          },
                        ),

                        const SizedBox(height: 6),

                        // Swap Button with horizontal divider
                        SizedBox(
                          height: 38,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Divider(
                                color: Color(0xFFE5E7EB),
                                thickness: 1,
                              ),
                              GestureDetector(
                                onTap: _swapCities,
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF383C),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x33FF383C),
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.swap_vert_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Field 3: Kota Tujuan
                        _FormFieldCard(
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFFFF383C),
                            size: 20,
                          ),
                          label: 'Kota Tujuan',
                          value: _destinationCity,
                          isPlaceholder:
                              _destinationCity == 'Pilih kota tujuan',
                          onTap: () {
                            _showCityPicker(
                              title: 'Pilih Kota Tujuan',
                              onSelected: (city) =>
                                  setState(() => _destinationCity = city),
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        // Field 4: Drop Off Point
                        _FormFieldCard(
                          icon: const Icon(
                            Icons.outlined_flag,
                            color: Color(0xFFFF383C),
                            size: 20,
                          ),
                          label: 'Drop Off Point',
                          value: _dropOffPoint,
                          isPlaceholder: true,
                          onTap: () {
                            _showLocationPicker(
                              title: 'Pilih Drop Off Point',
                              onSelected: (loc) =>
                                  setState(() => _dropOffPoint = loc),
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        // Field 5: Tanggal Keberangkatan
                        _FormFieldCard(
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xFFFF383C),
                            size: 19,
                          ),
                          label: 'Tanggal Keberangkatan',
                          value: _departureDate,
                          isPlaceholder:
                              _departureDate == 'Pilih tanggal keberangkatan',
                          onTap: _selectDate,
                        ),

                        const SizedBox(height: 16),

                        // Button "Cari Tiket"
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
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
                                    'Mencari tiket dari $_departureCity ke $_destinationCity ($_departureDate)...',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF383C),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Cari Tiket',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF0F1F5), width: 1.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  label: 'Beranda',
                  isActive: _selectedBottomNavIndex == 0,
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.confirmation_number_outlined,
                  label: 'Tiket Saya',
                  isActive: _selectedBottomNavIndex == 1,
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.assignment_outlined,
                  label: 'Booking Saya',
                  isActive: _selectedBottomNavIndex == 2,
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.account_circle_outlined,
                  label: 'Akun',
                  isActive: _selectedBottomNavIndex == 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedBottomNavIndex = index;
        });
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFFFF0F0) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 22,
              color: isActive
                  ? const Color(0xFFFF383C)
                  : const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive
                  ? const Color(0xFFFF383C)
                  : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  void _showCityPicker({
    required String title,
    required ValueChanged<String> onSelected,
  }) {
    final cities = [
      'Jakarta',
      'Surabaya',
      'Bandung',
      'Semarang',
      'Yogyakarta',
      'Denpasar',
      'Malang',
      'Solo',
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return ListTile(
                      title: Text(city),
                      onTap: () {
                        onSelected(city);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLocationPicker({
    required String title,
    required ValueChanged<String> onSelected,
  }) {
    final locations = [
      'Terminal Utama',
      'Pool Pusat',
      'Rest Area KM 57',
      'Stasiun Barat',
      'Halte Bandara',
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final loc = locations[index];
                    return ListTile(
                      title: Text(loc),
                      onTap: () {
                        onSelected(loc);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FormFieldCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final String value;
  final bool isPlaceholder;
  final VoidCallback onTap;

  const _FormFieldCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.isPlaceholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF8C97A8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: isPlaceholder
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF1F2937),
                          fontWeight: isPlaceholder
                              ? FontWeight.w400
                              : FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF9CA3AF),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
