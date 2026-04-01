import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/app_colors.dart';
import '../screens/main_screen.dart';
import '../widgets/background_wrapper.dart'; // อย่าลืมตรวจสอบ Path นี้นะครับ

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // สถานะของ Switch
  bool _waterReminder = true;
  bool _healthAdvice = true;

  @override
  Widget build(BuildContext context) {
    // --- แก้ไข: เปลี่ยน Scaffold Body ให้เป็น BackgroundWrapper ---
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BackgroundWrapper( // ใช้ตัว Wrapper ครอบเพื่อให้มี Background Orbs เหมือนหน้าอื่นๆ
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  children: [
                    // --- Section: Profile ---
                    _buildSectionTitle("Profile"),
                    _buildSettingItem(iconPath: 'assets/icons/profile_icon.png', title: "Edit Personal Information", onTap: () {}),
                    _buildSettingItem(iconPath: 'assets/icons/goal_icon.png', title: "Goals", onTap: () {}),
                    const SizedBox(height: 25),

                    // --- Section: Notifications ---
                    _buildSectionTitle("Notifications"),
                    _buildSettingItem(
                      iconPath: 'assets/icons/water_notification_icon.png', title: "Water Reminder", 
                      isSwitch: true, switchValue: _waterReminder, onChanged: (val) => setState(() => _waterReminder = val)
                    ),
                    _buildSettingItem(
                      iconPath: 'assets/icons/health_notification_icon.png', title: "Health Advice", 
                      isSwitch: true, switchValue: _healthAdvice, onChanged: (val) => setState(() => _healthAdvice = val)
                    ),
                    const SizedBox(height: 25),

                    // --- Section: System ---
                    _buildSectionTitle("System"),
                    _buildSettingItem(iconPath: 'assets/icons/logout_icon.png', title: "Log Out", isLogout: true, onTap: () {}),
                    const SizedBox(height: 100), // เผื่อระยะ Bottom Nav
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ====================================================================
  // MAIN COMPONENTS
  // ====================================================================

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
            child: Center(child: Text("Settings", style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Medium', color: AppColors.greyText))),
          ),
          const SizedBox(width: 60), 
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 5),
      child: Text(title, style: const TextStyle(fontSize: 18, fontFamily: 'Poppins-Medium', color: Color(0xFF2D7D9A))),
    );
  }

  Widget _buildSettingItem({
    required String iconPath, required String title,
    bool isSwitch = false, bool isLogout = false,
    bool? switchValue, Function(bool)? onChanged, VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Image.asset(
          iconPath, width: 40, height: 40, fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(Icons.circle, color: isLogout ? Colors.red : Colors.blueGrey, size: 40),
        ),
        title: Text(title, style: const TextStyle(fontSize: 16, fontFamily: 'Poppins-Medium', color: Color(0xFF4A4A4A))),
        trailing: isSwitch
            ? Transform.scale(
                scale: 0.7, 
                child: CupertinoSwitch(
                  value: switchValue!,
                  onChanged: onChanged,
                  activeColor: const Color(0xFF00D1B2),
                  trackColor: const Color(0xFFCED4DA).withOpacity(0.5),
                ),
              )
            : isLogout
                ? null
                : const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF81E5E5)),
        onTap: isSwitch ? null : onTap,
      ),
    );
  }
}