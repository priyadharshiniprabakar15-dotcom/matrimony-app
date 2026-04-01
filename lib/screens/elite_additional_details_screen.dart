import 'package:flutter/material.dart';
import 'elite_photo_upload_screen.dart';

class EliteAdditionalDetailsScreen extends StatefulWidget {
  final String userId;

  const EliteAdditionalDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<EliteAdditionalDetailsScreen> createState() =>
      _EliteAdditionalDetailsScreenState();
}

class _EliteAdditionalDetailsScreenState
    extends State<EliteAdditionalDetailsScreen> {

  static const Color primaryMaroon = Color(0xFF800020);
  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  String? familyStatus = "Upper middle class";
  final TextEditingController aboutController = TextEditingController();

  Widget _statusButton(String value) {
    bool selected = value == familyStatus;

    return GestureDetector(
      onTap: () => setState(() => familyStatus = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? gold : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _autoWrite() {
    setState(() {
      aboutController.text =
          "I am a friendly and positive person who values family and relationships.";
    });
  }

  void _goToPhotoScreen() {
    if (aboutController.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please write at least 10 characters about yourself."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) =>
            ElitePhotoUploadScreen(userId: widget.userId),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: primaryMaroon,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Additional Details (5/5)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 15),

            const Text(
              "Select family status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _statusButton("Middle class"),
                _statusButton("Upper middle class"),
                _statusButton("Rich / Affluent (Elite)"),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "A few words about myself",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: aboutController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write something about yourself...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Minimum 10 characters",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                GestureDetector(
                  onTap: _autoWrite,
                  child: const Text(
                    "Help me write this",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD4AF37),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

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
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _goToPhotoScreen,
                child: const Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}