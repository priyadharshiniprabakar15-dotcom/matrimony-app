import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;

  const EditProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late TextEditingController nameController;
  late TextEditingController professionController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController       = TextEditingController(text: "Madhu");
    professionController = TextEditingController(text: "Software Engineer");
    locationController   = TextEditingController(text: "Chennai");
  }

  @override
  void dispose() {
    nameController.dispose();
    professionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final name       = nameController.text.trim();
    final profession = professionController.text.trim();
    final location   = locationController.text.trim();

    if (name.isEmpty || profession.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile Updated Successfully ✅"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            _buildField("Name", nameController),
            _buildField("Profession", professionController),
            _buildField("Location", locationController),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: _saveProfile,
              child: const Text(
                "Save Changes 💖",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}