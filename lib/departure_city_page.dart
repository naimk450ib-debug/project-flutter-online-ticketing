import 'package:flutter/material.dart';

import 'main.dart';

class CityItem {
  final String name;
  final String province;

  const CityItem({required this.name, required this.province});
}

class DepartureCityPage extends StatefulWidget {
  final String selectedCity;

  const DepartureCityPage({super.key, this.selectedCity = 'Salatiga'});

  @override
  State<DepartureCityPage> createState() => _DepartureCityPageState();
}

class _DepartureCityPageState extends State<DepartureCityPage> {
  final TextEditingController _searchController = TextEditingController();
  late String _currentSelected;
  int _selectedBottomNavIndex = 0;

  // List of departure cities exactly as shown in UI design
  final List<CityItem> _allCities = const [
    CityItem(name: 'Salatiga', province: 'Jawa Tengah'),
    CityItem(name: 'Semarang', province: 'Jawa Tengah'),
    CityItem(name: 'Solo', province: 'Jawa Tengah'),
    CityItem(name: 'Boyolali', province: 'Jawa Tengah'),
    CityItem(name: 'Kediri', province: 'Jawa Timur'),
    CityItem(name: 'Denpasar', province: 'Bali'),
  ];

  List<CityItem> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _currentSelected =
        widget.selectedCity.isNotEmpty &&
            widget.selectedCity != 'Pilih kota keberangkatan'
        ? widget.selectedCity
        : 'Salatiga';

    _filteredCities = List.from(_allCities);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCities = List.from(_allCities);
      } else {
        _filteredCities = _allCities
            .where(
              (city) =>
                  city.name.toLowerCase().contains(query) ||
                  city.province.toLowerCase().contains(query),
            )
            .toList();
      }
    });
  }

  void _selectCity(String cityName) {
    setState(() {
      _currentSelected = cityName;
    });

    // Provide brief visual feedback before returning
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        Navigator.pop(context, cityName);
      }
    });
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
            stops: [0.0, 0.22, 0.23, 1.0],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Top Header: Back Button, Title, Subtitle, and FN Badge
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular Back Button
                    InkWell(
                      onTap: () => Navigator.pop(context, _currentSelected),
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        width: 42,
                        height: 42,
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
                            Icons.arrow_back_rounded,
                            color: Color(0xFFFF383C),
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Title & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Kota Keberangkatan',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Mulai perjalanan Anda dari sini',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // FN Brand Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFF0F1F5),
                          width: 1.2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x08000000),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.5,
                            height: 6.5,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF383C),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'FN',
                            style: TextStyle(
                              color: Color(0xFFFF383C),
                              fontWeight: FontWeight.w800,
                              fontSize: 12.5,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF111827),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari kota keberangkatan',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF9CA3AF),
                        size: 22,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFF9CA3AF),
                                size: 18,
                              ),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Section Header: PILIH KOTA KEBERANGKATAN
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'PILIH KOTA KEBERANGKATAN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8C97A8),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // List of Cities
              Expanded(
                child: _filteredCities.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_off_outlined,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Kota tidak ditemukan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        itemCount: _filteredCities.length + 1,
                        itemBuilder: (context, index) {
                          // The last item is the bottom info notice
                          if (index == _filteredCities.length) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 12.0,
                                left: 4.0,
                                right: 4.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: 16,
                                    color: Color(0xFF8C97A8),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Pickup point dapat dipilih setelah Anda menentukan kota',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF8C97A8),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          final city = _filteredCities[index];
                          final isSelected =
                              city.name.toLowerCase() ==
                              _currentSelected.toLowerCase();

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildCityCard(
                              city: city,
                              isSelected: isSelected,
                              onTap: () => _selectCity(city.name),
                            ),
                          );
                        },
                      ),
              ),
            ],
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
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

              // iOS Home Indicator
              Center(
                child: Container(
                  width: 134,
                  height: 4.5,
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityCard({
    required CityItem city,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFFFFD1D3) : const Color(0xFFF0F1F5),
          width: isSelected ? 1.4 : 1.0,
        ),
        boxShadow: isSelected
            ? const [
                BoxShadow(
                  color: Color(0x18FF383C),
                  blurRadius: 16,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                ),
              ]
            : const [
                BoxShadow(
                  color: Color(0x06000000),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 14.0,
            ),
            child: Row(
              children: [
                // Left Location Icon Box
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFFF0F0)
                        : const Color(0xFFF3F4F8),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.location_on_outlined,
                      color: isSelected
                          ? const Color(0xFFFF383C)
                          : const Color(0xFF9CA3AF),
                      size: 22,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // City and Province Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        city.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        city.province,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8C97A8),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Indicator
                if (isSelected)
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF383C),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Color(0xFFFF383C),
                        size: 14,
                      ),
                    ),
                  )
                else
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFCBD5E1),
                    size: 22,
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
        if (index == 0) {
          // Return to home / dashboard
          Navigator.pop(context, _currentSelected);
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        } else {
          setState(() {
            _selectedBottomNavIndex = index;
          });
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
}
