import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'elite_horoscope_details_screen.dart';

class ElitePhotoUploadScreen extends StatefulWidget {
  const ElitePhotoUploadScreen({super.key});

  @override
  State<ElitePhotoUploadScreen> createState() =>
      _ElitePhotoUploadScreenState();
}

class _ElitePhotoUploadScreenState
    extends State<ElitePhotoUploadScreen>
    with SingleTickerProviderStateMixin {

  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  File? _selectedImage;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHoroscope() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const EliteHoroscopeDetailsScreen(),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image =
        await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });

      _startUploading();
    }
  }

  void _startUploading() async {
    setState(() {
      _isUploading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isUploading = false;
    });

    _navigateToHoroscope();
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _skipPhoto() {
    _navigateToHoroscope();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [

                  const SizedBox(height: 40),

                  /// Image Preview
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.account_circle,
                              size: 120,
                              color: Colors.grey,
                            ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Add your photo now",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  /// Uploading Indicator
                  if (_isUploading)
                    Column(
                      children: const [
                        CircularProgressIndicator(
                          color: gold,
                        ),
                        SizedBox(height: 10),
                        Text("Uploading... Please wait"),
                        SizedBox(height: 20),
                      ],
                    ),

                  /// ADD PHOTO BUTTON
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x55D4AF37),
                          blurRadius: 25,
                          spreadRadius: 3,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        minimumSize:
                            const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _showPickerOptions,
                      child: const Text(
                        "Add photo now",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  GestureDetector(
                    onTap: _skipPhoto,
                    child: const Text(
                      "I'll add photo later  >",
                      style: TextStyle(
                        color: gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}