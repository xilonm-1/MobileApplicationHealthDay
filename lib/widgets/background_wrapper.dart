import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // เรายังคง Import เพื่อเรียกใช้สีพื้นหลังที่กำหนดไว้

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  const BackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. ใช้สีพื้นหลังเดี่ยว (Solid Color) ตามที่คุณกำหนดไว้ใน AppColors: Color(0xFFF5F7F8)
      backgroundColor: AppColors.backgroundColor, 
      body: SafeArea(
        // 2. เนื้อหาหลักของหน้าจอ (child) จะอยู่ภายใน SafeArea
        child: child,
      ),
    );
  }
}