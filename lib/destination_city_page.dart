import 'package:flutter/material.dart';

import 'departure_city_page.dart';

class CityItem {
  final String name;
  final String province;

  const CityItem({required this.name, required this.province});
}

class DestinationCityPage extends StatefulWidget {
  final String departureCity;
  final String selectedDestination;

  const DestinationCityPage({
    super.key,
    this.departureCity = 'Salatiga',
    this.selectedDestination = 'Denpasar',
  });

  @override
  State<DestinationCityPage> createState() => _DestinationCityPageState();
}

class _DestinationCityPageState extends State<DestinationCityPage> {
  final TextEditingController _searchController = TextEditingController();
  late String _currentSelected;
  late String _currentDepartureCity;

  // List of destination cities matching the design
  final List<CityItem> _allCities = const [
    CityItem(name: 'Tangerang', province: 'Banten'),
    CityItem(name: 'Bekasi Timur', province: 'Jawa Barat'),
    CityItem(name: 'Pulogebang', province: 'Jakarta Timur'),
    CityItem(name: 'Depok', province: 'Jawa Barat'),
    CityItem(name: 'Tasikmalaya', province: 'Jawa Barat'),
    CityItem(name: 'Bandung', province: 'Jawa Barat'),
    CityItem(name: 'Blitar', province: 'Jawa Timur'),
    CityItem(name: 'Karanganyar', province: 'Jawa Tengah'),
    CityItem(name: 'Kediri', province: 'Jawa Timur'),
    CityItem(name: 'Malang', province: 'Jawa Timur'),
    CityItem(name: 'Surabaya', province: 'Jawa Timur'),
    CityItem(name: 'Madiun', province: 'Jawa Timur'),
  ];

  List<CityItem> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _currentDepartureCity =
        widget.departureCity.isNotEmpty &&
            widget.departureCity != 'Pilih kota keberangkatan'
        ? widget.departureCity
        : 'Salatiga';

    _currentSelected =
        widget.selectedDestination.isNotEmpty &&
            widget.selectedDestination != 'Pilih kota tujuan'
        ? widget.selectedDestination
        : 'Denpasar';

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

    // Provide visual feedback before returning
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        Navigator.pop(context, cityName);
      }
    });
  }

  void _changeDepartureCity() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => DepartureCityPage(selectedCity: _currentDepartureCity),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _currentDepartureCity = result;
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

              // Header: Back Button, Title, Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context, _currentSelected),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          top: 2.0,
                          right: 14.0,
                          bottom: 8.0,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF111827),
                          size: 24,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Kota Tujuan',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Tentukan tujuan perjalanan Anda',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

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
                      hintText: 'Cari kota tujuan',
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

              const SizedBox(height: 14),

              // Departure Info Card: Berangkat dari Salatiga ->
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFF0F1F5),
                      width: 1.0,
                    ),
                    boxShadow: const [
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
                      onTap: _changeDepartureCity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        child: Row(
                          children: [
                            // Bullseye Icon: Red circle with red inner dot
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFFF383C),
                                  width: 1.6,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF383C),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            // Departure Texts
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Berangkat dari',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _currentDepartureCity,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF111827),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Right Arrow Icon
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Color(0xFFFF383C),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Section Header: PILIH KOTA TUJUAN
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'PILIH KOTA TUJUAN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8C97A8),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Scrollable Cities List + Info Card + Home Indicator
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
                          // The last item is the bottom info notice card
                          if (index == _filteredCities.length) {
                            return _buildBottomInfoCard();
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

              // iOS Home Indicator
              Center(
                child: Container(
                  width: 134,
                  height: 4.5,
                  margin: const EdgeInsets.only(top: 6, bottom: 8),
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

  Widget _buildBottomInfoCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFF0F1F5), width: 1.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x06000000),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.info_outline_rounded,
              size: 20,
              color: Color(0xFF9CA3AF),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Drop off point dapat dipilih setelah Anda menentukan kota tujuan.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
