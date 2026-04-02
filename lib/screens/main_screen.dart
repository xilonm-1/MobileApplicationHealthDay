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

  final List<Widget> _pages = [
    const HomePage(),
    const StatsPage(),
    const AddRecordPage(), // Index 2
    const CalendarPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.lightText, // ใช้สีขาวจากไฟล์สี
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCustomNavItem('assets/icons/home_icon.png', 'home', 0),
            _buildCustomNavItem('assets/icons/stat_icon.png', 'stats', 1),
            _buildAddButton(), 
            _buildCustomNavItem('assets/icons/calendar_icon.png', 'calendar', 3),
            _buildCustomNavItem('assets/icons/setting_icon.png', 'settings', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomNavItem(String iconPath, String label, int index) {
    bool isSelected = _currentIndex == index;
    
    // ดึงสีน้ำเงินเข้มจากตัวสุดท้ายของ primaryBlueGradient
    final Color selectedColor = AppColors.primaryBlueGradient.colors.last;
    // ใช้สีเทาจาก greyText
    final Color unselectedColor = AppColors.greyText;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 28,
            height: 28,
            color: isSelected ? selectedColor : unselectedColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? selectedColor : unselectedColor,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    bool isSelected = _currentIndex == 2;
    
    // สีกรณีถูกเลือก: ใช้ Gradient น้ำเงินเข้ม
    // สีกรณีปกติ: ใช้ Gradient ส้มหลัก
    final Gradient currentGradient = isSelected 
        ? AppColors.primaryBlueGradient 
        : AppColors.primaryOrangeGradient;

    // สีของเงา (Shadow)
    final Color shadowColor = isSelected 
        ? AppColors.primaryBlueGradient.colors.last 
        : AppColors.primaryOrangeGradient.colors.first;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: currentGradient,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}