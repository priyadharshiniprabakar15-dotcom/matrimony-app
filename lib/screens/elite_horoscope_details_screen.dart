import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'elite_welcome_offer_screen.dart';

class EliteHoroscopeDetailsScreen extends StatefulWidget {
  final String userId;

  const EliteHoroscopeDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<EliteHoroscopeDetailsScreen> createState() =>
      _EliteHoroscopeDetailsScreenState();
}

class _EliteHoroscopeDetailsScreenState
    extends State<EliteHoroscopeDetailsScreen> {

  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);
  static const Color primaryMaroon = Color(0xFF800020);

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  final Map<String, Map<String, List<String>>> worldData = {
    "India": {
      "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"],
      "Kerala": ["Kochi", "Trivandrum"],
      "Karnataka": ["Bangalore", "Mysore"],
    },
    "USA": {
      "California": ["Los Angeles", "San Francisco"],
      "Texas": ["Houston", "Dallas"],
    },
    "UK": {
      "England": ["London", "Manchester"],
      "Scotland": ["Edinburgh"],
    },
    "Canada": {
      "Ontario": ["Toronto", "Ottawa"],
      "Quebec": ["Montreal"],
    }
  };

  List<String> get countries => worldData.keys.toList();

  List<String> get states =>
      selectedCountry == null ? [] : worldData[selectedCountry!]!.keys.toList();

  List<String> get cities =>
      (selectedCountry != null && selectedState != null)
          ? worldData[selectedCountry!]![selectedState!]!
          : [];

  bool get isFormValid =>
      selectedDate != null &&
      selectedTime != null &&
      selectedCountry != null &&
      selectedState != null &&
      selectedCity != null;

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  Widget _dropdown(
      String hint,
      String? value,
      List<String> items,
      Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          onChanged: (val) {
            onChanged(val);
            setState(() {});
          },
        ),
      ),
    );
  }

  void _submit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => EliteWelcomeOfferScreen(userId: widget.userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = selectedDate != null
        ? DateFormat("dd-MMM-yyyy").format(selectedDate!)
        : "Select your date of birth";

    String formattedTime = selectedTime != null
        ? selectedTime!.format(context)
        : "Select your time of birth";

    return Scaffold(
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: primaryMaroon,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add horoscope details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            const Text("Date of birth",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade400),
                  color: Colors.white,
                ),
                child: Text(formattedDate),
              ),
            ),

            const SizedBox(height: 25),

            const Text("Time of birth",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickTime,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade400),
                  color: Colors.white,
                ),
                child: Text(formattedTime),
              ),
            ),

            const SizedBox(height: 30),

            const Text("Place of birth",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            _dropdown("Select your country", selectedCountry, countries, (val) {
              selectedCountry = val;
              selectedState = null;
              selectedCity = null;
            }),
            const SizedBox(height: 20),

            _dropdown("Select your state", selectedState, states, (val) {
              selectedState = val;
              selectedCity = null;
            }),
            const SizedBox(height: 20),

            _dropdown("Select your city", selectedCity, cities,
                (val) => selectedCity = val),

            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid ? gold : Colors.grey,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: isFormValid ? _submit : null,
              child: const Text(
                "Submit",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}