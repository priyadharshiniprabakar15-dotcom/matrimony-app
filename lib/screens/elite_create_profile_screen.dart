import 'package:flutter/material.dart';
import 'elite_basic_details_screen.dart';

class EliteCreateProfileScreen extends StatefulWidget {
  const EliteCreateProfileScreen({super.key});

  @override
  State<EliteCreateProfileScreen> createState() =>
      _EliteCreateProfileScreenState();
}

class _EliteCreateProfileScreenState
    extends State<EliteCreateProfileScreen> {

  static const Color primaryMaroon = Color(0xFF800020);
  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  String selected = "";

  final List<String> options = [
    "Myself",
    "Son",
    "Daughter",
    "Brother",
    "Sister",
    "Friend",
    "Relative"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: primaryMaroon,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Create Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [

            const SizedBox(height: 10),

            const Text(
              "I am creating this profile for",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: primaryMaroon,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.builder(
                itemCount: options.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 3.2,
                ),
                itemBuilder: (context, index) {
                  bool isSelected = selected == options[index];

                  return GestureDetector(
                    onTap: () => setState(() => selected = options[index]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? gold : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: primaryMaroon,
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: gold.withOpacity(0.4),
                                  blurRadius: 15,
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        options[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : primaryMaroon,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x55D4AF37),
                    blurRadius: 30,
                    spreadRadius: 3,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: selected.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EliteBasicDetailsScreen(),
                          ),
                        );
                      },
                child: const Text(
                  "Start Registration",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}