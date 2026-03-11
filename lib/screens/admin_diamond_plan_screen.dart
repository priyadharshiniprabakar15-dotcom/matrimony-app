import 'package:flutter/material.dart';

class AdminDiamondPlanScreen extends StatefulWidget {
  const AdminDiamondPlanScreen({super.key});

  @override
  State<AdminDiamondPlanScreen> createState() =>
      _AdminDiamondPlanScreenState();
}

class _AdminDiamondPlanScreenState
    extends State<AdminDiamondPlanScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;

  bool viewContact = true;
  bool sendInterest = true;
  bool chatAccess = true;
  bool planActive = true;

  @override
  void initState() {
    super.initState();
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  // 💎 Diamond Animated Gradient
  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(
                    const Color(0xFFE3F2FD),
                    const Color(0xFFD1C4E9),
                    _bgController.value)!,
                Color.lerp(
                    const Color(0xFFF3E5F5),
                    const Color(0xFFBBDEFB),
                    _bgController.value)!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }

  Widget statCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.blueAccent.withOpacity(0.25),
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12)),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String value) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget buildCheckbox(
      String title,
      bool value,
      Function(bool?) onChanged) {
    return CheckboxListTile(
      activeColor: Colors.blueAccent,
      title: Text(title),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

 Widget configCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          blurRadius: 16,
          color: Colors.blueAccent.withOpacity(0.2),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text("💎 Diamond Plan Config",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold)),

        const SizedBox(height: 16),

        buildTextField("Plan Name", "Diamond"),
        const SizedBox(height: 12),
        buildTextField("Plan Code", "diamond"),
        const SizedBox(height: 12),
        buildTextField("Price", "45599"),
        const SizedBox(height: 12),
        buildTextField("Duration (Days)", "30"),
        const SizedBox(height: 12),
        buildTextField("Profile Views", "1000"),

        const SizedBox(height: 12),

        buildCheckbox("View Contact", viewContact,
            (v) => setState(() => viewContact = v!)),
        buildCheckbox("Send Interest", sendInterest,
            (v) => setState(() => sendInterest = v!)),
        buildCheckbox("Chat Access", chatAccess,
            (v) => setState(() => chatAccess = v!)),
        buildCheckbox("Plan Active", planActive,
            (v) => setState(() => planActive = v!)),

        const SizedBox(height: 16),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {},
          icon: const Icon(Icons.save, color: Colors.white),
          label: const Text(
            "Save Plan Settings",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );
}

  Widget previewCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          blurRadius: 16,
          color: Colors.blueAccent.withOpacity(0.2),
        )
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Feature Preview",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text("Plan: Diamond"),
        Text("Price: Rs. 45,599"),
        Text("Duration: 30 Days"),
        SizedBox(height: 10),
        Text("✔ View Contact"),
        Text("✔ Send Interest"),
        Text("✔ Chat Access"),
        Text("Status: ACTIVE"),
      ],
    ),
  );
}

  Widget usersTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: Colors.blueAccent.withOpacity(0.2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: const [

          Text("Users On Diamond Plan",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold)),

          SizedBox(height: 16),

          Divider(),

          ListTile(
            title: Text("#15 Divya"),
            subtitle: Text("divya@gmail.com"),
            trailing: Text("27 Mar 2026"),
          ),

          ListTile(
            title: Text("#5 Mydeen"),
            subtitle: Text("mydeenabdulkader070@gmail.com"),
            trailing: Text("26 Mar 2026"),
          ),

          ListTile(
            title: Text("#7 Halith"),
            subtitle: Text("mohamedhalith117@gmail.com"),
            trailing: Text("25 Mar 2026"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Diamond Plan Settings",
          style: TextStyle(
              color: Colors.white),
        ),
        iconTheme:
            const IconThemeData(
                color: Colors.white),
      ),

      body: Stack(
        children: [
          animatedBackground(),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(16),
              child:
                  SingleChildScrollView(
                child: Column(
                  children: [

                    Row(
                      children: [
                        statCard("ACTIVE USERS", "5"),
                        statCard("TOTAL ASSIGNMENTS", "6"),
                        statCard("STATUS", "Live"),
                      ],
                    ),

                    const SizedBox(height: 28),

                   configCard(),

const SizedBox(height: 20),

previewCard(),
                    const SizedBox(height: 28),

                    usersTable(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}