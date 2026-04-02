import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // ดึงไฟล์สีมาใช้
import 'signup_screen.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      // ไปหน้า Main และล้าง Stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // ใช้สีพื้นหลังจาก AppColors
      body: SafeArea(
        child: Column(
          children: [
            // ส่วนบน: LOGIN title + Logo
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText.withOpacity(
                        0.7,
                      ), // สีข้อความหลัก
                      fontFamily: 'Poppins',
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),
                 // แสดง Full Logo (Login Page)
                  Image.asset(
                    'assets/images/Full_logo.png', 
                    width: 250,      // 📐 Fix ความกว้าง
                    height: 200,     // 📐 Fix ความสูง
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.health_and_safety,
                      size: 80,
                      color: AppColors.primaryBlueGradient.colors.first,
                    ),
                  ),
                ],
              ),
            ),

            // ส่วนล่าง: กล่องฟอร์ม Login (แก้ไขการไล่สีจากเข้มไปอ่อน)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // ✅ ปรับปรุงการไล่สี: เข้ม (Top) -> อ่อน (Bottom)
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors
                        .primaryBlueGradient
                        .colors
                        .first, // สีน้ำเงินเข้ม (จาก AppColors)
                    AppColors.primaryBlueGradient.colors.first.withOpacity(
                      0.4,
                    ), // สีเดิมแต่ทำให้จางลง (เหมือนหน้า Welcome)
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Field: Username
                  _buildInputField(
                    controller: _emailController,
                    hintText: 'username',
                  ),
                  const SizedBox(height: 20),

                  // Field: Password
                  _buildInputField(
                    controller: _passwordController,
                    hintText: 'password',
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggle: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),

                  const SizedBox(height: 40),

                  // ปุ่ม Login (ใช้ Gradient สีส้ม)
                  GestureDetector(
                    onTap: _isLoading ? null : _onLoginPressed,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryOrangeGradient, // สีส้มหลัก
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  color: AppColors.lightText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ส่วน Sign Up (ปรับสีฟอนต์ให้อ่านง่ายขึ้นบนพื้นหลังที่อ่อนลง)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                          color: AppColors.darkText.withOpacity(
                            0.6,
                          ), // เปลี่ยนเป็นสีเข้มจางๆ ให้อ่านง่าย
                          fontFamily: 'Poppins',
                          fontSize: 13,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors
                                .primaryBlueGradient
                                .colors
                                .first, // ใช้สีน้ำเงินเข้มเพื่อให้เด่นขึ้น
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget ช่วยสร้างช่อง Input สีขาว
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightText, // สีขาว
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.darkText,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 15,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: onToggle,
                )
              : null,
        ),
      ),
    );
  }
}
