import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/main_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'rewards_page.dart';

class PointPage extends StatefulWidget {
  const PointPage({super.key});

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  final int redeemablePoints = 220;

  // ===== ข้อมูลเดียวกับ CalendarPage =====
  // TODO: เปลี่ยนเป็น shared data source / API call จริง
  final Map<DateTime, List<Map<String, dynamic>>> _mockEvents = {
    DateTime(2026, 3, 29): [
      {'type': 'steps', 'label': 'Steps:',  'value': '1234', 'unit': '',      'points': 20},
      {'type': 'water', 'label': 'Waters:', 'value': '5',    'unit': '',      'points': 5},
      {'type': 'sleep', 'label': 'Sleeps:', 'value': '8',    'unit': 'hours', 'points': 7},
      {'type': 'mood',  'label': 'Moods:',  'value': 'Happy','unit': '',      'points': 3},
      {'type': 'note',  'value': "It's been a good day !"},
    ],
  };

  List<Map<String, dynamic>> _getTodayEvents() {
    final today = DateTime.now();
    for (var dateKey in _mockEvents.keys) {
      if (isSameDay(dateKey, today)) return _mockEvents[dateKey]!;
    }
    return [];
  }

  _StatTheme _getStatTheme(String type) {
    switch (type) {
      case 'steps': return _StatTheme('assets/icons/activity2_icon.png', const Color(0xFF01D8C1));
      case 'water': return _StatTheme('assets/icons/water2_icon.png',    const Color(0xFF06EFFF));
      case 'sleep': return _StatTheme('assets/icons/sleep2_icon.png',    const Color(0xFFFE83ED));
      case 'mood':  return _StatTheme('assets/icons/mood2_icon.png',     const Color(0xFFFFAC36));
      default:      return _StatTheme('assets/icons/activity2_icon.png', Colors.grey);
    }
  }

  String _getMonthName(int month) => [
    'Jan','Feb','Mar','Apr','May','Jun',
    'Jul','Aug','Sep','Oct','Nov','Dec',
  ][month - 1];

  // navigate กลับ MainScreen พร้อมเปลี่ยน tab
  void _navigateTo(int index) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final todayEvents = _getTodayEvents();
    final statEvents  = todayEvents.where((e) => e['type'] != 'note').toList();
    final noteEvent   = todayEvents.where((e) => e['type'] == 'note').firstOrNull;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          // ===== Header =====
          Container(
            width: double.infinity,
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Back + Title row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new,
                              size: 16, color: Colors.grey),
                          onPressed: () => _navigateTo(0), // กลับ home
                        ),
                        const Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Points',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 60),
                      ],
                    ),
                  ),

                  // ===== Points Card =====
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RewardsShopPage(userPoints: redeemablePoints),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              // ส่วนบน: Total Points label
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFF2D7D9A), Color(0xFF1A4A56)],
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.star_border_rounded,
                                        color: Colors.white, size: 28),
                                    SizedBox(width: 10),
                                    Text(
                                      'Total Points',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ส่วนล่าง: ตัวเลข
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '$redeemablePoints Points',
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ===== Today's Stats =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${today.day} ${_getMonthName(today.month)} ${today.year}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF2D7D9A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (statEvents.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'No records for today',
                            style: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                          ),
                        ),
                      )
                    else
                      ...statEvents.map((item) => _buildStatRow(item)),

                    if (noteEvent != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Text(
                          noteEvent['value'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildStatRow(Map<String, dynamic> item) {
    final theme  = _getStatTheme(item['type']);
    final points = item['points'] as int?;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(
            theme.iconPath,
            width: 28,
            height: 28,
            color: theme.color,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                Icon(Icons.broken_image, color: theme.color, size: 28),
          ),
          const SizedBox(width: 14),
          Text(
            item['label'],
            style: TextStyle(
              color: theme.color,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          if (points != null)
            Text(
              '+$points',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.color,
                fontFamily: 'Poppins',
              ),
            ),
        ],
      ),
    );
  }
}

class _StatTheme {
  final String iconPath;
  final Color color;
  _StatTheme(this.iconPath, this.color);
}