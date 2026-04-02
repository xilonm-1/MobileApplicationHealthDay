import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:healthday_application/screens/main_screen.dart';
import '../constants/app_colors.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  bool isWeeksSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // พื้นหลังแสงฟุ้ง (Background Circles)
          Positioned(top: 0, left: -10, child: _buildBackgroundCircle(120, AppColors.stepsGradient, 0.5)),
          Positioned(top: 125, right: -10, child: _buildBackgroundCircle(160, AppColors.sleepGradient, 0.5)),
          Positioned(bottom: 100, left: -100, child: _buildBackgroundCircle(220, AppColors.waterGradient, 0.5)),
          Positioned(bottom: -80, right: -50, child: _buildBackgroundCircle(270, AppColors.moodGradient, 0.5)),
          
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildHeader(context),
                const SizedBox(height: 25),
                _buildTabSwitcher(),
                const SizedBox(height: 25),

                // รายการการ์ดสถิติ (Glassmorphism Cards)
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildGlassCard("Steps", isWeeksSelected ? "100,000 steps" : "450,000 steps", AppColors.stepsGradient, 'assets/icons/activity_icon.png'),
                      _buildGlassCard("Water", isWeeksSelected ? "200 glasses" : "900 glasses", AppColors.waterGradient, 'assets/icons/water_icon.png'),
                      _buildGlassCard("Sleep", isWeeksSelected ? "250 hours" : "1,100 hours", AppColors.sleepGradient, 'assets/icons/sleep_icon.png'),
                      _buildGlassCard("Mood", "Good", AppColors.moodGradient, 'assets/icons/mood_icon.png'),
                      const SizedBox(height: 100), // ระยะเผื่อ Bottom Navigation
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // HELPER WIDGETS (ฟังก์ชันตัวช่วยเพื่อลดความยาวโค้ด)
  Widget _buildGradientText(String text, LinearGradient gradient, TextStyle style) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    );
  }

  Widget _buildBackgroundCircle(double size, LinearGradient gradient, double opacity) {
    return Opacity(
      opacity: opacity,
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
  // MAIN COMPONENTS (ชิ้นส่วนหลักของหน้าจอ)
  Widget _buildGlassCard(String title, String value, LinearGradient gradient, String iconPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      height: 125,
      child: Stack(
        children: [
          // ชั้นล่าง: แผ่นกระจกฝ้าและข้อความ
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 75), // เว้นที่ให้ไอคอน (55 + 20)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGradientText(title, gradient, const TextStyle(fontSize: 16, fontFamily: 'Poppins-Medium')),
                          const SizedBox(height: 4),
                          _buildGradientText(value, gradient, const TextStyle(fontSize: 26, letterSpacing: -0.5, fontFamily: 'Poppins-SemiBold')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ชั้นบน: วงกลมไอคอน
          Positioned(
            left: 20, top: 0, bottom: 0,
            child: Center(
              child: Image.asset(
                iconPath, width: 50, height: 50, fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error_outline, color: Colors.red, size: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            child: Center(child: Text("Stats", style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Medium', color: AppColors.greyText))),
          ),
          const SizedBox(width: 60), // สำหรับบาลานซ์ให้คำว่า Stats อยู่ตรงกลางเป๊ะๆ
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity, height: 55,
      decoration: BoxDecoration(color: const Color(0xFFFFA726), borderRadius: BorderRadius.circular(30)),
      child: Stack(
        children: [
          // 1. ตัว Slider เลื่อนสลับซ้ายขวา
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isWeeksSelected ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFB74D), Color(0xFFFB8C00)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.yellow.withOpacity(0.5), width: 1.5),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
              ),
            ),
          ),
          // 2. ตัวอักษร (Weeks / Months)
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isWeeksSelected = true),
                  behavior: HitTestBehavior.opaque,
                  child: Center(child: Text("Weeks", style: TextStyle(color: isWeeksSelected ? const Color(0xFF2D7D9A) : Colors.white, fontFamily: 'Poppins-Medium', fontSize: 20))),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isWeeksSelected = false),
                  behavior: HitTestBehavior.opaque,
                  child: Center(child: Text("Months", style: TextStyle(color: !isWeeksSelected ? const Color(0xFF2D7D9A) : Colors.white, fontFamily: 'Poppins-Medium', fontSize: 20))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}