import 'package:flutter/material.dart';
import 'elite_professional_details_screen.dart';

class EliteLocationDetailsScreen extends StatefulWidget {
  final String userId;

  const EliteLocationDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<EliteLocationDetailsScreen> createState() =>
      _EliteLocationDetailsScreenState();
}

class _EliteLocationDetailsScreenState
    extends State<EliteLocationDetailsScreen> {

  static const Color primaryMaroon = Color(0xFF800020);
  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  final Map<String, Map<String, List<String>>> worldData = {
    "India": {
      "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai", "Salem"],
      "Kerala": ["Kochi", "Trivandrum", "Kozhikode"],
      "Karnataka": ["Bangalore", "Mysore"],
    },
    "USA": {
      "California": ["Los Angeles", "San Francisco"],
      "Texas": ["Houston", "Dallas"],
    },
    "Canada": {
      "Ontario": ["Toronto", "Ottawa"],
      "Quebec": ["Montreal", "Quebec City"],
    },
    "Australia": {
      "New South Wales": ["Sydney"],
      "Victoria": ["Melbourne"],
    },
    "UK": {
      "England": ["London", "Manchester"],
      "Scotland": ["Edinburgh"],
    }
  };

  List<String> get countries => worldData.keys.toList();

  List<String> get states =>
      selectedCountry == null ? [] : worldData[selectedCountry!]!.keys.toList();

  List<String> get cities =>
      (selectedCountry != null && selectedState != null)
          ? worldData[selectedCountry!]![selectedState!]!
          : [];

  Widget _searchableCountryDropdown() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) return countries;
        return countries.where(
            (c) => c.toLowerCase().contains(value.text.toLowerCase()));
      },
      onSelected: (value) {
        setState(() {
          selectedCountry = value;
          selectedState = null;
          selectedCity = null;
        });
      },
      fieldViewBuilder: (context, controller, focusNode, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade400),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              hintText: "Select your country",
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }

  Widget _dropdown(
      String hint,
      String? value,
      List<String> items,
      Function(String?) onChanged) {
    return Container(
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

  void _goToProfessionalScreen() {
    if (selectedCountry == null ||
        selectedState == null ||
        selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select Country, State & City"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            EliteProfessionalDetailsScreen(userId: widget.userId),
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
          "Location Details (3/5)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            const Text("Your residing country",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _searchableCountryDropdown(),

            const SizedBox(height: 25),

            const Text("Your residing state",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _dropdown("Select State", selectedState, states, (val) {
              setState(() {
                selectedState = val;
                selectedCity = null;
              });
            }),

            const SizedBox(height: 25),

            const Text("Your residing city",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _dropdown("Select City", selectedCity, cities,
                (val) => setState(() => selectedCity = val)),

            const SizedBox(height: 45),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: _goToProfessionalScreen,
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}