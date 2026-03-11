import 'package:flutter/material.dart';
import 'elite_religious_details_screen.dart';

class ElitePersonalDetailsScreen extends StatefulWidget {
  const ElitePersonalDetailsScreen({super.key});

  @override
  State<ElitePersonalDetailsScreen> createState() =>
      _ElitePersonalDetailsScreenState();
}

class _ElitePersonalDetailsScreenState
    extends State<ElitePersonalDetailsScreen>
    with TickerProviderStateMixin {

  static const Color primaryMaroon = Color(0xFF800020);
  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  late AnimationController _heartController;
  late Animation<double> _heartAnimation;

  String? gender;
  String? physicalStatus;
  String? maritalStatus;

  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String? selectedHeight;

  final List<String> days =
      List.generate(31, (index) => "${index + 1}");

  final List<String> months = [
    "Jan","Feb","Mar","Apr","May","Jun",
    "Jul","Aug","Sep","Oct","Nov","Dec"
  ];

  final List<String> years =
      List.generate(50, (index) => "${2024 - index}");

  final List<String> heights = [
    "4 ft 10 in",
    "4 ft 11 in",
    "5 ft 0 in",
    "5 ft 1 in",
    "5 ft 2 in",
    "5 ft 3 in",
    "5 ft 4 in",
    "5 ft 5 in",
    "5 ft 6 in",
    "5 ft 7 in",
  ];

  @override
  void initState() {
    super.initState();

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _heartAnimation =
        Tween<double>(begin: 0, end: 1).animate(_heartController);
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  /// Floating Heart Animation
  Widget _floatingHeart(double top, double left, double size) {
    return AnimatedBuilder(
      animation: _heartAnimation,
      builder: (context, child) {
        return Positioned(
          top: top - (_heartAnimation.value * 40),
          left: left,
          child: Opacity(
            opacity: 0.06,
            child: Icon(
              Icons.favorite,
              color: gold,
              size: size,
            ),
          ),
        );
      },
    );
  }

  Widget _toggleButton(String value, String? groupValue,
      Function(String) onChanged) {

    bool selected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? gold : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: primaryMaroon),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: selected ? Colors.white : primaryMaroon,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _dropdown(
      String hint,
      String? value,
      List<String> items,
      Function(String?) onChanged) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryMaroon),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: value,
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _goToNextScreen() {
    if (gender == null ||
        selectedDay == null ||
        selectedMonth == null ||
        selectedYear == null ||
        selectedHeight == null ||
        physicalStatus == null ||
        maritalStatus == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
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
            const EliteReligiousDetailsScreen(),
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
          "Personal Details (1/5)",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [

          _floatingHeart(150, 40, 40),
          _floatingHeart(350, 250, 35),
          _floatingHeart(600, 100, 50),

          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 15),

                const Text("Gender",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _toggleButton("Male", gender,
                        (val) => setState(() => gender = val)),
                    const SizedBox(width: 12),
                    _toggleButton("Female", gender,
                        (val) => setState(() => gender = val)),
                  ],
                ),

                const SizedBox(height: 25),

                const Text("Date of Birth",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _dropdown("DD", selectedDay, days,
                          (val) => setState(() => selectedDay = val)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _dropdown("MMM", selectedMonth, months,
                          (val) => setState(() => selectedMonth = val)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _dropdown("YYYY", selectedYear, years,
                          (val) => setState(() => selectedYear = val)),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Text("Height",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),

                _dropdown("Select your height",
                    selectedHeight,
                    heights,
                    (val) => setState(() => selectedHeight = val)),

                const SizedBox(height: 25),

                const Text("Your physical status",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _toggleButton("Normal", physicalStatus,
                        (val) => setState(() => physicalStatus = val)),
                    const SizedBox(width: 12),
                    _toggleButton("Physically challenged", physicalStatus,
                        (val) => setState(() => physicalStatus = val)),
                  ],
                ),

                const SizedBox(height: 25),

                const Text("Your marital status",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _toggleButton("Never married", maritalStatus,
                        (val) => setState(() => maritalStatus = val)),
                    _toggleButton("Widow", maritalStatus,
                        (val) => setState(() => maritalStatus = val)),
                    _toggleButton("Awaiting divorce", maritalStatus,
                        (val) => setState(() => maritalStatus = val)),
                    _toggleButton("Divorced", maritalStatus,
                        (val) => setState(() => maritalStatus = val)),
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
                      elevation: 0,
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

                const SizedBox(height: 25),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Need help? Call  ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      Icon(Icons.phone,
                          color: Colors.orange,
                          size: 18),
                      SizedBox(width: 6),
                      Text(
                        "8144-99-88-77",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 152, 0, 1),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}