import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin {
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
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _signInScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _signInAnimationController, curve: Curves.easeInOut),
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

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
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
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontFamily: 'Poppins',
        color: Color(0xFF3D5A63),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF9BAFB5),
          fontFamily: 'Poppins',
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        suffixIcon: hasToggle
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF9BAFB5),
                  ),
                  onPressed: onToggle,
                ),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ส่วนบน: SIGNUP title + Logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
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
                    const SizedBox(height: 32),

                    Image.asset(
                      'assets/images/Full_logo.jpg',
                      width: 240,
                      height: 180,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 240,
                          height: 180,
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
                                size: 50,
                                color: Color(0xFF3D8EA0),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Logo',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF3D8EA0),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // ส่วนล่าง: กล่องฟอร์ม
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFCFDDE2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Username
                    _buildTextField(
                      controller: _usernameController,
                      hint: 'username',
                    ),
                    const SizedBox(height: 30),

                    // Password
                    _buildTextField(
                      controller: _passwordController,
                      hint: 'password',
                      obscure: _obscurePassword,
                      hasToggle: true,
                      onToggle: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    const SizedBox(height: 30),

                    // Confirm Password
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hint: 'confirm password',
                      obscure: _obscureConfirmPassword,
                      hasToggle: true,
                      onToggle: () => setState(
                          () => _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                    const SizedBox(height: 30),

                    // Firstname
                    _buildTextField(
                      controller: _firstnameController,
                      hint: 'firstname',
                    ),
                    const SizedBox(height: 30),

                    // Lastname
                    _buildTextField(
                      controller: _lastnameController,
                      hint: 'lastname',
                    ),
                    const SizedBox(height: 30),

                    // Weight
                    _buildTextField(
                      controller: _weightController,
                      hint: 'weight(km)',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),

                    // Height
                    _buildTextField(
                      controller: _heightController,
                      hint: 'height(cm)',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 50),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryOrangeGradient,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFA500).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _isLoading ? null : _onSignUpPressed,
                            borderRadius: BorderRadius.circular(16),
                            child: Center(
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account ? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7F8B8E),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ScaleTransition(
                            scale: _signInScaleAnimation,
                            child: GestureDetector(
                              onTap: _navigateToLogin,
                              child: AnimatedBuilder(
                                animation: _signInAnimationController,
                                builder: (context, child) {
                                  return Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.lerp(
                                        const Color(0xFF3D8EA0),
                                        const Color(0xFF2D7D9A),
                                        _signInAnimationController.value,
                                      ),
                                      fontFamily: 'Poppins',
                                    ),
                                  );
                                },
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