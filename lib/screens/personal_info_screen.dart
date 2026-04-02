import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // 1. แสงฟุ้งและวงกลมพื้นหลัง
          _buildBackgroundDecorations(),

          // 2. เนื้อหาหลัก
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 20),
                  _buildGlassCard(),
                  const SizedBox(height: 30),
                  _buildSaveButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // เปลี่ยนเป็น Navigator.pop(context) แบบหน้า Goals
          GestureDetector(
            onTap: () => Navigator.pop(context), 
            child: Container(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, size: 16, color: AppColors.greyText),
                  SizedBox(width: 5),
                  Text("Back", style: TextStyle(color: AppColors.greyText, fontFamily: 'Poppins-Medium', fontSize: 16)),
                ],
              ),
            ),
          ),
          const Text(
            "Personal Information",
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 18,
              fontFamily: 'Poppins-Medium',
            ),
          ),
          const SizedBox(width: 60), // สำหรับบาลานซ์ให้ Title ตรงกลาง
        ],
      ),
    );
  }

  // ====================================================================
  // MAIN COMPONENTS
  // ====================================================================

  Widget _buildGlassCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.glassBorderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: AppColors.glassColor, 
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  _buildProfileAvatar(),
                  const SizedBox(height: 35),
                  _buildTextField(_firstNameController, "firstname"),
                  const SizedBox(height: 15),
                  _buildTextField(_lastNameController, "lastname"),
                  const SizedBox(height: 15),
                  _buildTextField(_weightController, "weight(kg)"), 
                  const SizedBox(height: 15),
                  _buildTextField(_heightController, "height(cm)"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Center(
      child: Stack(
        children: [
          // วงกลมรูปโปรไฟล์
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, size: 55, color: Colors.white),
          ),
          // ปุ่มปากกาแก้ไข (Edit)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.darkText, 
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontFamily: 'Poppins-Medium', color: AppColors.darkText, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Poppins-Medium'),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () {
          // โค้ดสำหรับเซฟข้อมูล
          print("Saved!");
          Navigator.pop(context); // กดเซฟแล้วเด้งกลับอัตโนมัติ
        },
        child: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.primaryOrangeGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrangeGradient.colors.last.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins-SemiBold',
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ====================================================================
  // HELPER WIDGETS
  // ====================================================================

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // 1. วงกลมสีส้มทึบมุมซ้ายบน
        Positioned(
          top: -40,
          left: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryOrangeGradient.scale(0.7),
            ),
          ),
        ),
        
        // 2. แสงฟุ้ง (Orbs)
        Positioned(top: 100, right: -50, child: _orb(200, AppColors.primaryBlueGradient)),
        Positioned(bottom: 250, left: -50, child: _orb(250, AppColors.primaryBlueGradient)),
        Positioned(bottom: -50, right: -50, child: _orb(300, AppColors.primaryOrangeGradient)),
      ],
    );
  }

  Widget _orb(double size, LinearGradient gradient) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: gradient),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}