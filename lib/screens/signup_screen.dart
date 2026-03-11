import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';
import '../services/api_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? selectedRasi;
  String? selectedNatchatiram;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final List<Map<String, dynamic>> rasiList = [
    {"name": "Mesham", "icon": Icons.pets},
    {"name": "Rishabam", "icon": Icons.agriculture},
    {"name": "Mithunam", "icon": Icons.people},
    {"name": "Kadagam", "icon": Icons.water},
    {"name": "Simmam", "icon": Icons.star},
    {"name": "Kanni", "icon": Icons.eco},
    {"name": "Thulam", "icon": Icons.balance},
    {"name": "Viruchigam", "icon": Icons.bug_report},
    {"name": "Dhanusu", "icon": Icons.architecture},
    {"name": "Magaram", "icon": Icons.terrain},
    {"name": "Kumbam", "icon": Icons.water_drop},
    {"name": "Meenam", "icon": Icons.set_meal},
  ];

  final List<String> natchatiramList = [
    "Ashwini","Bharani","Krittika","Rohini","Mrigashirsha",
    "Ardra","Punarvasu","Pushya","Ashlesha","Magha",
    "Purva Phalguni","Uttara Phalguni","Hasta","Chitra",
    "Swati","Vishaka","Anuradha","Jyeshta","Moola",
    "Purva Ashada","Uttara Ashada","Shravana","Dhanishta",
    "Shatabhisha","Purva Bhadrapada","Uttara Bhadrapada","Revati"
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  Future<void> _register() async {

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        selectedRasi == null ||
        selectedNatchatiram == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await ApiService.sendOtp(
      name,
      email,
      phone,
      password,
      selectedRasi!,
      selectedNatchatiram!,
    );

    setState(() => _isLoading = false);

    if (result["success"] == true) {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            name: name,
            email: email,
            password: password,
          ),
        ),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result["message"] ?? "Signup failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    bool isConfirm = false,
    TextEditingController? controller,
  }) {

    return TextField(
      controller: controller,
      obscureText: isPassword
          ? (isConfirm ? _obscureConfirmPassword : _obscurePassword)
          : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  (isConfirm
                          ? _obscureConfirmPassword
                          : _obscurePassword)
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirm) {
                      _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                    } else {
                      _obscurePassword = !_obscurePassword;
                    }
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildRasiDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRasi,
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Select Rasi",
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      items: rasiList.map((rasi) {
        return DropdownMenuItem<String>(
          value: rasi["name"],
          child: Row(
            children: [
              Icon(rasi["icon"], color: Colors.black),
              const SizedBox(width: 10),
              Text(
                rasi["name"],
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedRasi = value;
        });
      },
    );
  }

  Widget _buildNatchatiramDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedNatchatiram,
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Select Natchatiram",
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      items: natchatiramList.map((n) {
        return DropdownMenuItem(
          value: n,
          child: Text(
            n,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedNatchatiram = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9B1C31),
                  Color(0xFFB23A48),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [

                  const SizedBox(height: 40),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFF5E1),
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildTextField("Full Name",
                      controller: _nameController),

                  const SizedBox(height: 20),

                  _buildTextField("Email",
                      controller: _emailController),

                  const SizedBox(height: 20),

                  _buildTextField("Phone Number",
                      controller: _phoneController),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Password",
                    controller: _passwordController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Confirm Password",
                    controller: _confirmPasswordController,
                    isPassword: true,
                    isConfirm: true,
                  ),

                  const SizedBox(height: 20),

                  _buildRasiDropdown(),

                  const SizedBox(height: 20),

                  _buildNatchatiramDropdown(),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _isLoading ? null : _register,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white)
                        : const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
    );
  }
}