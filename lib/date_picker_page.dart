import 'package:flutter/material.dart';

/// Function to show the Date Picker as a modal dialog over the current page.
Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? currentDate,
}) {
  return showGeneralDialog<DateTime>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Pilih Tanggal',
    barrierColor: const Color(0x66000000),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: DatePickerCard(
              initialDate: initialDate ?? DateTime(2026, 10, 22),
              currentDate: currentDate ?? DateTime(2026, 10, 19),
              onDateSelected: (date) {
                Navigator.of(context).pop(date);
              },
              onClose: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      );
    },
  );
}

/// Standalone DatePickerPage that faithfully reproduces the exact full screen
/// shown in the design (dimmed dashboard in the background + DatePicker modal + bottom nav).
class DatePickerPage extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? currentDate;

  const DatePickerPage({
    super.key,
    this.initialDate,
    this.currentDate,
  });

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  late DateTime _selectedDate;
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime(2026, 10, 22);
    _currentDate = widget.currentDate ?? DateTime(2026, 10, 19);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: Stack(
        children: [
          // Background: Dashboard Page representation
          Container(
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
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.notifications_none_rounded,
                              color: Color(0xFFFF383C),
                              size: 20,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Brand Title
                        const Expanded(
                          child: Text(
                            'FN Online Ticketing',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Profile Button
                        const Row(
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
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Greeting Header
                    const Text(
                      'Mau ke mana hari ini?',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Perjalanan nyaman bersama Mtrans',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Modal Backdrop Scrim
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: const Color(0x66000000),
              ),
            ),
          ),

          // Floating Date Picker Modal Card
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: DatePickerCard(
                    initialDate: _selectedDate,
                    currentDate: _currentDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                      Navigator.of(context).pop(date);
                    },
                    onClose: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ),

          // Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFF0F1F5),
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.home_rounded,
                    label: 'Beranda',
                    isActive: true,
                  ),
                  _buildNavItem(
                    icon: Icons.confirmation_number_outlined,
                    label: 'Tiket Saya',
                    isActive: false,
                  ),
                  _buildNavItem(
                    icon: Icons.assignment_outlined,
                    label: 'Booking Saya',
                    isActive: false,
                  ),
                  _buildNavItem(
                    icon: Icons.account_circle_outlined,
                    label: 'Akun',
                    isActive: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
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
            color: isActive ? const Color(0xFFFF383C) : const Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? const Color(0xFFFF383C) : const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }
}

/// The reusable DatePickerCard widget that renders the exact calendar card.
class DatePickerCard extends StatefulWidget {
  final DateTime initialDate;
  final DateTime currentDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback? onClose;

  const DatePickerCard({
    super.key,
    required this.initialDate,
    required this.currentDate,
    required this.onDateSelected,
    this.onClose,
  });

  @override
  State<DatePickerCard> createState() => _DatePickerCardState();
}

class _DatePickerCardState extends State<DatePickerCard> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  static const List<String> _dayNames = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  static const List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const List<String> _weekHeaders = [
    'Min',
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
  ];

  String _formatFullDate(DateTime date) {
    final dayName = _dayNames[date.weekday - 1];
    final monthName = _monthNames[date.month - 1];
    return '$dayName, ${date.day} $monthName ${date.year}';
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isBeforeDay(DateTime a, DateTime b) {
    final dateA = DateTime(a.year, a.month, a.day);
    final dateB = DateTime(b.year, b.month, b.day);
    return dateA.isBefore(dateB);
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 30,
              spreadRadius: 2,
              offset: Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Pilih Tanggal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                    letterSpacing: -0.3,
                  ),
                ),
                InkWell(
                  onTap: widget.onClose ?? () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close_rounded,
                      color: Color(0xFF9CA3AF),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Departure Date Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7F7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFFD1D3),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TANGGAL KEBERANGKATAN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9CA3AF),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatFullDate(_selectedDate),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFF383C),
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Month and Year with Chevrons
            Row(
              children: [
                Text(
                  '${_monthNames[_displayedMonth.month - 1]} ${_displayedMonth.year}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                    letterSpacing: -0.2,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: _previousMonth,
                  borderRadius: BorderRadius.circular(16),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      color: Color(0xFF9CA3AF),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _nextMonth,
                  borderRadius: BorderRadius.circular(16),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF9CA3AF),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Weekday Headers: Min, Sen, Sel, Rab, Kam, Jum, Sab
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _weekHeaders.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8C97A8),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Calendar Days Grid
            _buildCalendarGrid(),

            const SizedBox(height: 18),

            // Today indicator row
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF383C),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Hari ini · ${widget.currentDate.day} ${_monthNames[widget.currentDate.month - 1]} ${widget.currentDate.year}',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Action Button: "Pilih Tanggal"
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFFF383C),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4DFF383C),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    widget.onDateSelected(_selectedDate);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: const Center(
                    child: Text(
                      'Pilih Tanggal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final year = _displayedMonth.year;
    final month = _displayedMonth.month;

    // Number of days in current displayed month
    final daysInMonth = DateTime(year, month + 1, 0).day;

    // First day of month (DateTime weekday: 1 = Mon, ..., 7 = Sun)
    final firstWeekday = DateTime(year, month, 1).weekday;
    // We map Sunday to column 0, Monday to 1, ..., Saturday to 6
    final startOffset = firstWeekday % 7;

    // Calculate total rows needed
    final totalCells = startOffset + daysInMonth;
    final rowCount = (totalCells / 7).ceil();

    return Column(
      children: List.generate(rowCount, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (colIndex) {
              final cellIndex = rowIndex * 7 + colIndex;
              final dayNumber = cellIndex - startOffset + 1;

              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const Expanded(
                  child: SizedBox(
                    height: 40,
                  ),
                );
              }

              final cellDate = DateTime(year, month, dayNumber);
              final isSelected = _isSameDay(cellDate, _selectedDate);
              final isToday = _isSameDay(cellDate, widget.currentDate);
              final isPast = _isBeforeDay(cellDate, widget.currentDate);

              return Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: isPast
                        ? null
                        : () {
                            setState(() {
                              _selectedDate = cellDate;
                            });
                          },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFF383C)
                            : (isToday
                                ? const Color(0xFFFFECEF)
                                : Colors.transparent),
                        shape: BoxShape.circle,
                        boxShadow: isSelected
                            ? const [
                                BoxShadow(
                                  color: Color(0x33FF383C),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '$dayNumber',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: (isSelected || isToday)
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : (isToday
                                    ? const Color(0xFFFF383C)
                                    : (isPast
                                        ? const Color(0xFFA0AAB8)
                                        : const Color(0xFF111827))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
