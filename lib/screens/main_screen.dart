import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'home_page.dart';
import 'stats_page.dart';
import 'calendar_page.dart';
import 'setting_page.dart';
import 'add_record_page.dart'; 

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // รายการหน้าจอทั้งหมด (รวม AddRecord เข้ามาด้วยที่ตำแหน่ง index 2)
  final List<Widget> _pages = [
    const HomePage(),
    const StatsPage(),
    const AddRecordPage(), // <--- เอากลับเข้ามาใส่ใน Stack
    const CalendarPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 110, 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index), // สลับ Index ปกติ
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _buildNavItem('assets/icons/home_icon.png', 0),
              _buildNavItem('assets/icons/stat_icon.png', 1),
              
              // ปุ่มกลาง (+)
              BottomNavigationBarItem(
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryOrangeGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 35),
                ),
                label: '',
              ),
              
              _buildNavItem('assets/icons/calendar_icon.png', 3),
              _buildNavItem('assets/icons/setting_icon.png', 4),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, int index) {
    bool isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 85,
        height: 85,
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
          color: isSelected ? const Color(0xFF0F2A34) : AppColors.greyText, 
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
      label: '',
    );
  }
}