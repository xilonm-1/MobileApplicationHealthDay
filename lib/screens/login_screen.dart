import 'package:flutter/material.dart';
// import '../constants/app_colors.dart'; // ใช้ได้ตามปกติ

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
  double _signUpOpacity = 1.0;

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
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _navigateToSignUp() async {
    setState(() => _signUpOpacity = 0.0);
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() => _signUpOpacity = 1.0);
      Navigator.of(context).pushNamed('/signup');
    }
  }

  void _navigateToForgotPassword() {
    Navigator.of(context).pushNamed('/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // พื้นหลังสีเทาอ่อน
      body: SafeArea(
        child: Column(
          children: [
            // ส่วนบน: LOGIN title + Logo
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title LOGIN
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C5454),
                      fontFamily: 'Poppins',
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ===== ส่วนโลโก้ =====
                  Image.asset(
                    'assets/images/Full_logo.jpg',
                    width: 260,
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 260,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFCFDDE2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF9BAFB5),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image_not_supported_outlined,
                              size: 60,
                              color: Color(0xFF3D8EA0),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Logo',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xFF3D8EA0),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // ===== สิ้นสุดส่วนโลโก้ =====
                ],
              ),
            ),

            // ส่วนล่าง: กล่องฟอร์ม Login
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFCFDDE2), // สีพื้นหลังกล่องฟอร์ม
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Username Field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF3D5A63),
                    ),
                    decoration: InputDecoration(
                      hintText: 'username',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9BAFB5),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF3D5A63),
                    ),
                    decoration: InputDecoration(
                      hintText: 'password',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9BAFB5),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9BAFB5),
                          ),
                          onPressed: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Forget password
                  GestureDetector(
                    onTap: _navigateToForgotPassword,
                    child: const Text(
                      'Forget password ?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3D8EA0),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _onLoginPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7F8B8E),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _signUpOpacity,
                        duration: const Duration(milliseconds: 200),
                        child: GestureDetector(
                          onTap: _navigateToSignUp,
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3D8EA0),
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
    );
  }
}