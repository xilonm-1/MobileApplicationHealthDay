import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // ดึงไฟล์สีมาใช้งาน
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // ใช้สีพื้นหลังหลักจาก AppColors
      body: Stack(
        children: [
          // 1. ส่วน Gradient ด้านบน (ไล่จากสีน้ำเงินหลักไปหาโปร่งใส/ขาว)
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryBlueGradient.colors.first.withOpacity(0.8), // ใช้สีแรกจาก Blue Gradient
                  AppColors.backgroundColor, // จบที่สีพื้นหลังแอปเพื่อให้กลืนกัน
                ],
              ),
            ),
          ),

          // 2. เนื้อหาตรงกลาง
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                
                // คำว่า WELCOME (แยกสีตามธีมแอป)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "WEL",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlueGradient.colors.first, // สีน้ำเงินหลัก
                        letterSpacing: 2,
                        fontFamily: 'Poppins-Bold',
                      ),
                    ),
                    Text(
                      "COME",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryOrangeGradient.colors.last, // สีส้มหลัก
                        letterSpacing: 2,
                        fontFamily: 'Poppins-Bold',
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),
                
                // สโลแกน (ใช้สีข้อความเทา)
                Text(
                  "\"Let's start recording your\nhealthy\"",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.greyText, // ใช้สีเทาจาก AppColors
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Poppins-Medium',
                  ),
                ),
              ],
            ),
          ),

          // 3. ปุ่ม Get Started ด้านล่าง
          Align(
            alignment: const Alignment(0, 0.75),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    // ใช้ Gradient สีน้ำเงินหลักสำหรับปุ่มเพื่อให้ดูพรีเมียม
                    gradient: AppColors.primaryBlueGradient, 
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlueGradient.colors.last.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: AppColors.lightText, // สีขาว
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-SemiBold',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}