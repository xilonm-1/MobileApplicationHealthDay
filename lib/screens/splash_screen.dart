import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // 1. เปลี่ยนการนำเข้าไฟล์เป็น welcome_screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity1 = 0.0; // logo1 (พระอาทิตย์)
  double _opacity2 = 0.0; // logo2 (เส้นคลื่น)
  double _opacity3 = 0.0; // logo3 (ข้อความ)

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    // 1. โชว์เส้นคลื่น (logo2) เป็นอันแรก
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) setState(() => _opacity2 = 1.0);

    // 2. โชว์พระอาทิตย์ (logo1) โผล่ตามมา
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _opacity1 = 1.0);

    // 3. โชว์ข้อความ HEALTHDAY (logo3) เป็นอันสุดท้าย
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _opacity3 = 1.0);

    // ✅ แก้ไข: หน่วงเวลาค้างไว้ 3 วินาทีเพื่อให้เห็นโลโก้ที่สมบูรณ์ก่อนเปลี่ยนหน้า
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      // ✅ แก้ไข: เปลี่ยนจุดหมายปลายทางไปที่ WelcomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: Center(
        child: SizedBox(
          width: 300, 
          height: 300, 
          child: Stack(
            children: [
              // ☀️ 1. พระอาทิตย์
              AnimatedOpacity(
                opacity: _opacity1,
                duration: const Duration(milliseconds: 800),
                child: Align(
                  alignment: const Alignment(-0.15, -0.3), 
                  child: Image.asset('assets/images/logo1.png', width: 130),
                ),
              ),
              
              // 🌊 2. เส้นคลื่น
              AnimatedOpacity(
                opacity: _opacity2,
                duration: const Duration(milliseconds: 800),
                child: Align(
                  alignment: const Alignment(0, 0.0), 
                  child: Image.asset('assets/images/logo2.png', width: 200),
                ),
              ),
              
              // 🔡 3. ข้อความ HEALTHDAY
              AnimatedOpacity(
                opacity: _opacity3,
                duration: const Duration(milliseconds: 800),
                child: Align(
                  alignment: const Alignment(0, 0.6), 
                  child: Image.asset('assets/images/logo3.png', width: 140),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}