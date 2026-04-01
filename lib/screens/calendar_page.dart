import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/app_colors.dart';
import '../screens/main_screen.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  // ข้อมูลจำลอง: เพิ่ม key 'isGoalMet' เพื่อเช็คว่ากิจกรรมนั้นถึงเป้าหรือยัง
  final Map<DateTime, List<Map<String, dynamic>>> _mockEvents = {
    DateTime(2026, 3, 29): [
      {'type': 'steps', 'label': 'Steps:', 'value': '1234', 'unit': '', 'isGoalMet': false}, // ยังไม่ถึงเป้า
      {'type': 'water', 'label': 'Waters:', 'value': '5', 'unit': '', 'isGoalMet': true},   // ถึงเป้าแล้ว
      {'type': 'sleep', 'label': 'Sleeps:', 'value': '8', 'unit': 'hours', 'isGoalMet': true}, // ถึงเป้าแล้ว
      {'type': 'mood', 'label': 'Moods:', 'value': 'Happy', 'unit': '', 'isGoalMet': true},  // อารมณ์ดี
      {'type': 'note', 'value': 'It\'s been a good day !'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    for (var dateKey in _mockEvents.keys) {
      if (isSameDay(dateKey, day)) return _mockEvents[dateKey]!;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          _buildBackgroundOrbs(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildQuote(),
                const SizedBox(height: 20),
                _buildCalendarCard(),
                const SizedBox(height: 20),
                Expanded(child: _buildDailyRecordsContainer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // HELPER WIDGETS
  Widget _buildGradientText(String text, LinearGradient gradient, TextStyle style) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    );
  }
  // MAIN COMPONENTS
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainScreen()), (route) => false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, size: 14, color: AppColors.greyText),
                  SizedBox(width: 5),
                  Text("Back", style: TextStyle(color: AppColors.greyText, fontFamily: 'Poppins-Medium')),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(child: Text("History", style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Medium', color: AppColors.greyText))),
          ),
          const SizedBox(width: 60), 
        ],
      ),
    );
  }

  Widget _buildQuote() {
    return const Text(
      "“Frame your health with memories”",
      style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Medium', color: Color(0xFF2D7D9A), fontStyle: FontStyle.italic),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontSize: 18, fontFamily: 'Poppins-Medium'),
        ),
        calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(fontFamily: 'Poppins-Medium'),
          weekendTextStyle: TextStyle(color: Colors.red, fontFamily: 'Poppins-Medium'),
          todayDecoration: BoxDecoration(color: AppColors.darkText, shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(color: Color(0xFFFFA726), shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget _buildDailyRecordsContainer() {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_selectedDay?.day} ${_getMonthName(_selectedDay?.month ?? 1)} ${_selectedDay?.year}",
                      style: const TextStyle(fontSize: 18, fontFamily: 'Poppins-Medium', color: Color(0xFF2D7D9A)),
                    ),
                    const Divider(height: 30, color: Colors.black12),
                    Expanded(
                      child: events.isEmpty ? _buildEmptyState() : _buildEventList(events),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList(List<Map<String, dynamic>> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final item = events[index];
        return item['type'] == 'note' ? _buildNoteCard(item['value']) : _buildStatRow(item);
      },
    );
  }

  Widget _buildStatRow(Map<String, dynamic> item) {
    final theme = _getStatTheme(item['type']);
    final bool isMet = item['isGoalMet'] ?? false; // เช็คว่าผ่านเป้าหมายไหม
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(
            theme.iconPath, width: 28, height: 28, fit: BoxFit.contain,
            errorBuilder: (c, e, s) => Icon(Icons.broken_image, color: theme.gradient.colors.first, size: 28),
          ),
          const SizedBox(width: 15),
          _buildGradientText(
            item['label'], 
            theme.gradient, 
            const TextStyle(fontFamily: 'Poppins-Medium', fontSize: 16)
          ),
          const SizedBox(width: 10),
          Text(
            "${item['value']} ${item['unit']}",
            style: const TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Poppins-Medium'),
          ),
          
          // --- เพิ่มติ๊กถูกด้านหลัง ---
          if (isMet) ...[
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x4001D8C1), // แสงฟุ้งสีเขียวมิ้นต์
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF01D8C1), // สีเขียวมิ้นต์ (Steps Gradient)
                size: 20,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildNoteCard(String note) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black.withOpacity(0.03)),
      ),
      child: Text(note, style: const TextStyle(fontSize: 15, color: Colors.black54, fontFamily: 'Poppins-Medium')),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note_outlined, color: Colors.grey, size: 50),
          SizedBox(height: 10),
          Text("No records for this day", style: TextStyle(color: AppColors.greyText, fontFamily: 'Poppins-Medium')),
        ],
      ),
    );
  }

  // --- Background ---
  Widget _buildBackgroundOrbs() {
    return Stack(
      children: [
        Positioned(top: -30, left: -20, child: _orb(100, AppColors.primaryOrangeGradient)),
        Positioned(top: 80, right: -50, child: _orb(200, AppColors.primaryBlueGradient)),
        Positioned(bottom: 150, left: -80, child: _orb(200, AppColors.primaryBlueGradient)),
        Positioned(bottom: 0, right: -30, child: _orb(250, AppColors.primaryOrangeGradient)),
      ],
    );
  }

  Widget _orb(double size, LinearGradient gradient) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: gradient),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  _StatTheme _getStatTheme(String type) {
    switch (type) {
      case 'steps': return _StatTheme('assets/icons/activity2_icon.png', AppColors.stepsGradient);
      case 'water': return _StatTheme('assets/icons/water2_icon.png', AppColors.waterGradient);
      case 'sleep': return _StatTheme('assets/icons/sleep2_icon.png', AppColors.sleepGradient);
      case 'mood': return _StatTheme('assets/icons/mood2_icon.png', AppColors.moodGradient);
      default: return _StatTheme('assets/icons/activity2_icon.png', AppColors.stepsGradient);
    }
  }

  String _getMonthName(int month) => ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][month - 1];
}

class _StatTheme {
  final String iconPath;
  final LinearGradient gradient; 
  _StatTheme(this.iconPath, this.gradient);
}