import 'package:flutter/material.dart';

class AppColors {
  // 1. สีพื้นหลังหลัก (Solid Color)
  static const Color backgroundColor = Color(0xFFF5F7F8);
  
  // 2. สีข้อความหลัก (Solid Color - ดึงจากจุดสิ้นสุดของ gradient ฟ้า)
  static const Color darkText = Color(0xFF0F2A34);
  static const Color lightText = Colors.white;
  static const Color greyText = Color(0x80000000);

  // 3. ชุดสีไล่เฉดหลัก (Main Gradients)
  
  // สีฟ้าหลัก / สีน้ำเงินเข้ม (Primary Blue)
  static const LinearGradient primaryBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D7D9A), Color(0xFF0F2A34)],
  );

  // สีส้มหลัก (Primary Orange)
  static const LinearGradient primaryOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFB347), Color(0xFFFF9600)],
  );

  // 4. ชุดสีไล่เฉดสถานะ (Status Gradients)

  // สีเขียว Steps
  static const LinearGradient stepsGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF01D8C1), Color(0xFF02AEB9)],
  );

  // สีฟ้า Water
  static const LinearGradient waterGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF06EFFF), Color(0xFF00BBFF)],
  );

  // สีการนอน (Sleep)
  static const LinearGradient sleepGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFE83ED), Color(0xFF9747FF)],
  );

  // สีอารมณ์ (Mood)
  static const LinearGradient moodGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFFAC36), Color(0xFFFF4938)],
  );

  // สีแจ้งเตือน/ลบ (Clear/Delete)
  static const LinearGradient deleteGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFFF0000)],
  );
  
  // 5. การตั้งค่า Glassmorphism (White Transparent) 
  static Color glassColor = Colors.white.withOpacity(0.3); // สีพื้นหลังกระจก
  static Color glassBorderColor = Colors.white.withOpacity(0.2); // สีขอบกระจก
}