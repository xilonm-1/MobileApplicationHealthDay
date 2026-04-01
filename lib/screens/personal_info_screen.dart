import 'dart:ui';
import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // สีพื้นหลังหลักขาวอมเทานิดๆ
      body: Stack(
        children: [
          // พื้นหลังลูกกลมๆ สีส้ม (บนซ้าย)
          Positioned(
            top: -80,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFBDDAB), // สีส้มอ่อน
              ),
            ),
          ),
          // พื้นหลังลูกกลมๆ สีฟ้า (บนขวา)
          Positioned(
            top: 100,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD3E6EB), // สีฟ้าอ่อน
              ),
            ),
          ),
          // พื้นหลังลูกกลมๆ สีฟ้า (ล่างซ้าย)
          Positioned(
            bottom: 150,
            left: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFB1CBD0), // สีฟ้าเข้มขึ้นมานิดนึง
              ),
            ),
          ),
          // พื้นหลังลูกกลมๆ สีส้ม (ล่างขวา)
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFAD195), // สีส้ม
              ),
            ),
          ),

          // ส่วนของ UI หลัก
          SafeArea(
            child: Column(
              children: [
                // Header (ปุ่ม Back และ Title)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // กลับไปหน้า Home
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back_ios, color: Colors.black54, size: 20),
                            Text(
                              "Back",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Personal Information",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 60), // บาลานซ์ช่องว่างให้ Title อยู่ตรงกลาง
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // วิดเจ็ตแบบกระจก (Glassmorphism)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.6),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                children: [
                                  // รูปโปรไฟล์และไอคอนแก้ไข
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      const CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey,
                                        child: Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1F4C6B),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),

                                  // ช่องกรอกข้อมูล
                                  _buildTextField("firstname"),
                                  _buildTextField("lastname"),
                                  _buildTextField("weight(kg)"), // แก้จาก km เป็น kg ให้แล้วครับ
                                  _buildTextField("height(cm)"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // ปุ่ม Save
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // ใส่ Logic ตอนกด Save ตรงนี้
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF8991D), // สีส้ม
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
      // ส่วนของ Bottom Navigation Bar แบบมีปุ่มตรงกลาง
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFF8991D),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home_filled, "home", false),
              _buildBottomNavItem(Icons.bar_chart, "stats", false),
              const SizedBox(width: 40), // เว้นที่ให้ปุ่มบวกตรงกลาง
              _buildBottomNavItem(Icons.calendar_today, "calendar", false),
              _buildBottomNavItem(Icons.person, "settings", true), // Active state
            ],
          ),
        ),
      ),
    );
  }

  // Widget สำหรับสร้าง TextField แต่ละช่อง
  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ),
    );
  }

  // Widget สำหรับสร้างไอคอนใน Bottom Navigation Bar
  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    final color = isActive ? const Color(0xFF1F4C6B) : Colors.grey.shade400;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }
}