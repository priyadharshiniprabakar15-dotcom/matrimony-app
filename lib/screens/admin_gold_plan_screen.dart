import 'package:flutter/material.dart';

class AdminGoldPlanScreen extends StatefulWidget {
  const AdminGoldPlanScreen({super.key});

  @override
  State<AdminGoldPlanScreen> createState() =>
      _AdminGoldPlanScreenState();
}

class _AdminGoldPlanScreenState
    extends State<AdminGoldPlanScreen>
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

  // 🌟 Light Gold Animated Background
  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(
                    const Color(0xFFFFF8E1),
                    const Color(0xFFFFECB3),
                    _bgController.value)!,
                Color.lerp(
                    const Color(0xFFFFF3CD),
                    const Color(0xFFFFE082),
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
              color: Colors.amber.withOpacity(0.25),
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
      activeColor: Colors.amber,
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
          color: Colors.amber.withOpacity(0.2),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text("⭐ Gold Plan Config",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold)),

        const SizedBox(height: 16),

        buildTextField("Plan Name", "Gold"),
        const SizedBox(height: 12),
        buildTextField("Plan Code", "gold"),
        const SizedBox(height: 12),
        buildTextField("Price", "29900"),
        const SizedBox(height: 12),
        buildTextField("Duration (Days)", "30"),
        const SizedBox(height: 12),
        buildTextField("Profile Views", "200"),

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
            backgroundColor: Colors.amber,
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
          color: Colors.amber.withOpacity(0.2),
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
        Text("Plan: Gold"),
        Text("Price: Rs. 29,900"),
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
            color: Colors.amber.withOpacity(0.2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: const [

          Text("Users On Gold Plan",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold)),

          SizedBox(height: 16),

          Divider(),

          ListTile(
            title: Text("#32 Pradeep N"),
            subtitle: Text("iiidsumma@gmail.com"),
            trailing: Text("29 Mar 2026"),
          ),

          ListTile(
            title: Text("#17 Samantha"),
            subtitle: Text("sam@gmail.com"),
            trailing: Text("29 Mar 2026"),
          ),

          ListTile(
            title: Text("#20 Hasan"),
            subtitle: Text("hasan@gmail.com"),
            trailing: Text("27 Mar 2026"),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Gold Plan Settings",
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
                        statCard("TOTAL ASSIGNMENTS", "11"),
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