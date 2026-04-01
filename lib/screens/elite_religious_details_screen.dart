import 'package:flutter/material.dart';
import 'elite_location_details_screen.dart';

class EliteReligiousDetailsScreen extends StatefulWidget {
  final String userId;

  const EliteReligiousDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<EliteReligiousDetailsScreen> createState() =>
      _EliteReligiousDetailsScreenState();
}

class _EliteReligiousDetailsScreenState
    extends State<EliteReligiousDetailsScreen> {

  static const Color primaryMaroon = Color(0xFF800020);
  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  String? selectedReligion = "Hindu";
  String? selectedCaste = "Don't wish to specify";
  String? selectedDosham = "No";

  bool willingAnyCaste = true;

  final List<String> religions = [
    "Hindu", "Christian", "Muslim", "Sikh", "Jain", "Other"
  ];

  final List<String> castes = [
    "Don't wish to specify", "Brahmin", "Kshatriya",
    "Vaishya", "SC/ST", "Other"
  ];

  Widget _dropdown(
      String label,
      String? value,
      List<String> items,
      Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade400),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _doshamButton(String value) {
    bool selected = value == selectedDosham;

    return GestureDetector(
      onTap: () => setState(() => selectedDosham = value),
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

  void _goToNextScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) =>
            EliteLocationDetailsScreen(userId: widget.userId),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: primaryMaroon,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Religious Details (2/5)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            const Text("Religion",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _dropdown("Religion", selectedReligion, religions,
                (val) => setState(() => selectedReligion = val)),

            const SizedBox(height: 25),

            const Text("Caste",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _dropdown("Caste", selectedCaste, castes,
                (val) => setState(() => selectedCaste = val)),

            const SizedBox(height: 15),

            TextField(
              decoration: InputDecoration(
                hintText: "Enter subcaste (Optional)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Checkbox(
                  value: willingAnyCaste,
                  activeColor: gold,
                  onChanged: (val) =>
                      setState(() => willingAnyCaste = val ?? false),
                ),
                const Expanded(
                    child: Text("Willing to marry from any caste")),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Do you have any dosham? (Optional)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _doshamButton("No"),
                const SizedBox(width: 10),
                _doshamButton("Yes"),
                const SizedBox(width: 10),
                _doshamButton("Don't know"),
              ],
            ),

            const SizedBox(height: 45),

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
                ),
                onPressed: _goToNextScreen,
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