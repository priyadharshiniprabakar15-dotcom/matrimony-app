import 'package:flutter/material.dart';
import 'elite_additional_details_screen.dart';

class EliteProfessionalDetailsScreen extends StatefulWidget {
  final String userId;

  const EliteProfessionalDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<EliteProfessionalDetailsScreen> createState() =>
      _EliteProfessionalDetailsScreenState();
}

class _EliteProfessionalDetailsScreenState
    extends State<EliteProfessionalDetailsScreen> {

  static const Color primaryMaroon = Color(0xFF800020);
  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  String? education;
  String? employmentType;
  String? occupation;
  String? currency = "INR - India";
  String? annualIncome;

  final List<String> educationList = [
    "BE / B.Tech", "B.Sc", "MBA", "M.Tech", "Doctor", "Other"
  ];

  final List<String> employmentList = [
    "Private", "Government", "Business", "Self Employed", "Not Working"
  ];

  final List<String> occupationList = [
    "Software Engineer", "Doctor", "Teacher", "Business", "Banking", "Other"
  ];

  final List<String> incomeList = [
    "Below 2 Lakhs", "2 - 5 Lakhs", "5 - 10 Lakhs",
    "10 - 20 Lakhs", "20+ Lakhs"
  ];

  Widget _dropdown(
      String hint,
      String? value,
      List<String> items,
      Function(String?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: value,
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _goToAdditionalScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) =>
            EliteAdditionalDetailsScreen(userId: widget.userId),
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
          "Professional Details (4/5)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 15),

            _dropdown("Select your education details", education,
                educationList, (val) => setState(() => education = val)),

            _dropdown("Select your employment type", employmentType,
                employmentList, (val) => setState(() => employmentType = val)),

            _dropdown("Select your occupation", occupation,
                occupationList, (val) => setState(() => occupation = val)),

            _dropdown("Your annual income currency (Optional)", currency,
                ["INR - India", "USD - USA", "GBP - UK"],
                (val) => setState(() => currency = val)),

            _dropdown("Select your annual income (Optional)", annualIncome,
                incomeList, (val) => setState(() => annualIncome = val)),

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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: _goToAdditionalScreen,
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