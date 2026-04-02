import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  late AnimationController _signInAnimationController;
  late Animation<double> _signInScaleAnimation;

  @override
  void initState() {
    super.initState();
    _signInAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _signInScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _signInAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _signInAnimationController.dispose();
    super.dispose();
  }

  void _onSignUpPressed() async {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _firstnameController.text.isEmpty ||
        _lastnameController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _navigateToLogin() {
    _signInAnimationController.forward().then((_) {
      Navigator.of(context).pop();
      _signInAnimationController.reverse();
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    bool hasToggle = false,
    VoidCallback? onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightText,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.darkText,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 15,
          ),
          suffixIcon: hasToggle
              ? IconButton(
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: onToggle,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ส่วนบน: SIGNUP title + Logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                // แสดง Full Logo (SignUp Page)
                child: Column(
                  children: [
                    const Text(
                      'SIGNUP',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5C5454),
                        fontFamily: 'Poppins',
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/Full_logo.png',
                      width: 250, // 📐 ต้องเท่ากับหน้า Login
                      height: 200, // 📐 ต้องเท่ากับหน้า Login
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.health_and_safety,
                        size: 80,
                        color: Color(0xFF2D7D9A),
                      ),
                    ),
                  ],
                ),
              ),

              // ส่วนล่าง: กล่องฟอร์มสมัครสมาชิก (ไล่สีเข้มไปอ่อน)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // ✅ แก้ไข: ไล่สีจากเข้ม (Top) ไปอ่อน (Bottom) เหมือนหน้า Welcome/Login
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primaryBlueGradient.colors.first,
                      AppColors.primaryBlueGradient.colors.first.withOpacity(
                        0.4,
                      ),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _usernameController,
                      hint: 'username',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _passwordController,
                      hint: 'password',
                      obscure: _obscurePassword,
                      hasToggle: true,
                      onToggle: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hint: 'confirm password',
                      obscure: _obscureConfirmPassword,
                      hasToggle: true,
                      onToggle: () => setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _firstnameController,
                      hint: 'firstname',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _lastnameController,
                      hint: 'lastname',
                    ),
                    const SizedBox(height: 15),

                    // แถวน้ำหนัก/ส่วนสูง
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _weightController,
                            hint: 'weight(kg)',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildTextField(
                            controller: _heightController,
                            hint: 'height(cm)',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // ปุ่ม Register (Gradient สีส้ม)
                    GestureDetector(
                      onTap: _isLoading ? null : _onSignUpPressed,
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryOrangeGradient,
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
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // ลิงก์กลับไปหน้า Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkText.withOpacity(
                              0.6,
                            ), // สีเข้มจางๆ ให้อ่านง่ายบนสีสว่าง
                            fontFamily: 'Poppins',
                          ),
                        ),
                        ScaleTransition(
                          scale: _signInScaleAnimation,
                          child: GestureDetector(
                            onTap: _navigateToLogin,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors
                                    .primaryBlueGradient
                                    .colors
                                    .first, // สีน้ำเงินเข้มให้เด่น
                                fontFamily: 'Poppins',
                              ),
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
      ),
    );
  }
}
