import 'package:flutter/material.dart';
import 'dart:ui';
import '../constants/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // 1. ข้อมูลจำลอง (Mock Data)
  final List<Map<String, String>> _notifications = [
    {
      'id': '1',
      'msg': 'It\'s time to drink some water. 💧',
      'time': '14:00 - 13/09/2026',
    },
    {
      'id': '2',
      'msg': 'It\'s time to drink some water. 💧',
      'time': '13:00 - 13/09/2026',
    },
    {
      'id': '3',
      'msg': 'It\'s time to drink some water. 💧',
      'time': '12:00 - 13/09/2026',
    },
    {
      'id': '4',
      'msg': 'It\'s time to drink some water. 💧',
      'time': '09:00 - 13/09/2026',
    },
    {
      'id': '5',
      'msg': 'It\'s time to drink some water. 💧',
      'time': '09:00 - 13/09/2026',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // ไม่มี Background Orbs ตามรีเควส
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildHeader(context),
            const SizedBox(height: 10),
            // แสดงปุ่ม Clear All ก็ต่อเมื่อมี Notification
            if (_notifications.isNotEmpty) _buildClearButton(), 
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 5, bottom: 100),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final item = _notifications[index];
                        return _buildDismissibleItem(item, index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  // HELPER WIDGETS
  // เตรียมฟังก์ชันไล่สี (Gradient Text) ไว้ใช้เป็นมาตรฐาน
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
          // ปรับเป็น GestureDetector แบบเดียวกับหน้าอื่นๆ
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
            child: Center(
              child: Text("Notifications", style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Medium', color: AppColors.greyText)),
            ),
          ),
          const SizedBox(width: 60), // สำหรับบาลานซ์ให้ Title ตรงกลาง
        ],
      ),
    );
  }

  Widget _buildClearButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => setState(() => _notifications.clear()),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppColors.deleteGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: AppColors.deleteGradient.colors.last.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3)),
              ],
            ),
            child: const Text(
              "Clear All",
              style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Poppins-Medium'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleItem(Map<String, String> item, int index) {
    return Dismissible(
      key: Key(item['id']!),
      direction: DismissDirection.endToStart, // สไลด์จากขวาไปซ้าย
      onDismissed: (direction) => setState(() => _notifications.removeAt(index)),
      // พื้นหลังตอนสไลด์ (ขอบโค้งเท่ากับตัว Card)
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.only(right: 25),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          gradient: AppColors.deleteGradient,
          borderRadius: BorderRadius.circular(15), 
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
      ),
      child: _buildNotificationCard(item),
    );
  }

  Widget _buildNotificationCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ไอคอนวงกลมด้านหน้า
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryBlueGradient, // หรือเปลี่ยนตามประเภทแจ้งเตือนได้
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['msg']!,
                  style: const TextStyle(fontFamily: 'Poppins-Medium', fontSize: 15, color: AppColors.darkText),
                ),
                const SizedBox(height: 8),
                Text(
                  item['time']!,
                  style: const TextStyle(fontFamily: 'Poppins-Medium', color: AppColors.greyText, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, color: Colors.grey, size: 50),
          SizedBox(height: 10),
          Text(
            "No notifications",
            style: TextStyle(fontFamily: 'Poppins-Medium', color: AppColors.greyText, fontSize: 16),
          ),
        ],
      ),
    );
  }
}