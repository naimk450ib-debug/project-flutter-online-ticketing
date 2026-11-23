import 'package:flutter/material.dart';

/// Halaman Tiket Perjalanan (Hasil Pencarian Tiket Bus)
/// Mereproduksi tampilan desain UI tiket perjalanan secara persis dan pixel-perfect.
class TripTicketsPage extends StatefulWidget {
  final String departureCity;
  final String destinationCity;
  final String departureDate;
  final String pickupPoint;
  final String dropOffPoint;

  const TripTicketsPage({
    super.key,
    this.departureCity = 'Salatiga',
    this.destinationCity = 'Denpasar',
    this.departureDate = 'Kamis, 22 Oktober 2026',
    this.pickupPoint = 'Taman Cerdas Salatiga',
    this.dropOffPoint = 'Pulau Moyo',
  });

  @override
  State<TripTicketsPage> createState() => _TripTicketsPageState();
}

class _TripTicketsPageState extends State<TripTicketsPage> {
  // 0: Harga, 1: Keberangkatan, 2: Durasi
  int _selectedSortIndex = 0;
  bool _priceSortAscending = true;

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter Tiket',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF6B7280)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Kelas Bus',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Semua Kelas'),
                      selected: false,
                      onSelected: (_) => Navigator.pop(context),
                    ),
                    ChoiceChip(
                      label: const Text('Stadium Sleeper'),
                      selected: true,
                      selectedColor: const Color(0xFFFFECEF),
                      labelStyle: const TextStyle(
                        color: Color(0xFFFF383C),
                        fontWeight: FontWeight.w700,
                      ),
                      onSelected: (_) => Navigator.pop(context),
                    ),
                    ChoiceChip(
                      label: const Text('Executive Class'),
                      selected: false,
                      onSelected: (_) => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF383C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Terapkan Filter',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSeatTersediaPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Memilih kursi untuk ${widget.departureCity} ke ${widget.destinationCity}...',
        ),
        duration: const Duration(milliseconds: 1500),
      ),
    );
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
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // Header Bar: Back Button & "Tiket Perjalanan" Title
                        Row(
                          children: [
                            // Circular Back Button
                            InkWell(
                              onTap: () => Navigator.pop(context),
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
                                    Icons.arrow_back,
                                    color: Color(0xFF111827),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Text(
                              'Tiket Perjalanan',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Route Header: "Salatiga -> Denpasar" & Filter Icon Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.departureCity,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF111827),
                                        letterSpacing: -0.6,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Color(0xFF111827),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      widget.destinationCity,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF111827),
                                        letterSpacing: -0.6,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Red Filter (Tune) Button
                            InkWell(
                              onTap: _showFilterModal,
                              borderRadius: BorderRadius.circular(12),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.tune_rounded,
                                  color: Color(0xFFFF383C),
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Date Row: Calendar Icon & Date
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Color(0xFFFF383C),
                              size: 17,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              widget.departureDate,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // Section: "Urutkan berdasarkan"
                        const Text(
                          'Urutkan berdasarkan',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Sort Buttons Row: [Harga ^] [Keberangkatan] [Durasi]
                        Row(
                          children: [
                            // 1. Harga
                            Expanded(
                              child: _buildSortButton(
                                index: 0,
                                title: _selectedSortIndex == 0
                                    ? (_priceSortAscending ? 'Harga ↑' : 'Harga ↓')
                                    : 'Harga',
                                isActive: _selectedSortIndex == 0,
                                isPrice: true,
                              ),
                            ),
                            const SizedBox(width: 10),

                            // 2. Keberangkatan
                            Expanded(
                              flex: 1,
                              child: _buildSortButton(
                                index: 1,
                                title: 'Keberangkatan',
                                isActive: _selectedSortIndex == 1,
                              ),
                            ),
                            const SizedBox(width: 10),

                            // 3. Durasi
                            Expanded(
                              child: _buildSortButton(
                                index: 2,
                                title: 'Durasi',
                                isActive: _selectedSortIndex == 2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Section Title: "Perjalanan tersedia"
                        const Text(
                          'Perjalanan tersedia',
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            letterSpacing: -0.3,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Main Ticket Card: STADIUM SLEEPER I
                        _buildTripCard(),

                        const SizedBox(height: 18),

                        // Info Disclaimer
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Color(0xFF8C97A8),
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Waktu tiba merupakan estimasi. Lihat fasilitas dan titik keberangkatan pada detail perjalanan.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                  height: 1.45,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // Support Note
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Menghubungi Customer Support...'),
                                duration: Duration(milliseconds: 1500),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF383C),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 4,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF383C),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Butuh bantuan? Hubungi Support',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w400,
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

              // iOS Home Indicator at the bottom
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                  child: Center(
                    child: Container(
                      width: 134,
                      height: 4.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortButton({
    required int index,
    required String title,
    required bool isActive,
    bool isPrice = false,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          if (index == 0 && _selectedSortIndex == 0) {
            _priceSortAscending = !_priceSortAscending;
          } else {
            _selectedSortIndex = index;
          }
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFF7F7) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? const Color(0xFFFF383C) : const Color(0xFFE5E7EB),
            width: isActive ? 1.2 : 1.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? const Color(0xFFFF383C) : const Color(0xFF4B5563),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildTripCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: "SMG" Badge & Bus Class Name
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'SMG',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFF383C),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'STADIUM SLEEPER I',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Subtitle: Route Details
          const Text(
            'SEMARANG–SALATIGA–DENPASAR I',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8C97A8),
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 16),

          // Schedule Row: Departure (13:43) --- 16j 30m [bus] --- Arrival (06:13 +1 hari)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Departure Time & City
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '13:43',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.departureCity,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),

              // Center: Trip duration and visual line with bus
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      const Text(
                        '16j 30m',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF383C),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFFF383C),
                                  width: 1.3,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 5,
                                    margin: const EdgeInsets.fromLTRB(1, 1, 1, 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0x33FF383C),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 2.5,
                                        height: 2.5,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF383C),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Container(
                                        width: 2.5,
                                        height: 2.5,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF383C),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color(0xFFE5E7EB),
                            ),
                          ),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF383C),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Right: Arrival Time, City & "+1 hari"
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '06:13',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.destinationCity,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '+1 hari',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFF383C),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Divider Line
          const Divider(
            color: Color(0xFFF0F1F5),
            thickness: 1,
            height: 1,
          ),

          const SizedBox(height: 16),

          // Price Row: "Rp600.000 /seat"
          Text.rich(
            const TextSpan(
              children: [
                TextSpan(
                  text: 'Rp600.000',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFF383C),
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: ' /seat',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Red Button: "-> Seat Tersedia"
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFF2D36),
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40FF383C),
                  blurRadius: 14,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: _onSeatTersediaPressed,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 19,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Seat Tersedia',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
