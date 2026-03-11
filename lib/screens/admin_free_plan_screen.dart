import 'package:flutter/material.dart';

class AdminFreePlanScreen extends StatefulWidget {
  const AdminFreePlanScreen({super.key});

  @override
  State<AdminFreePlanScreen> createState() =>
      _AdminFreePlanScreenState();
}

class _AdminFreePlanScreenState
    extends State<AdminFreePlanScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;

  bool viewContact = false;
  bool sendInterest = false;
  bool chatAccess = false;
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

  // 🌸 Light Pink Animated Gradient Background
  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(
                    const Color(0xFFFFE4EC),
                    const Color(0xFFFFD1DC),
                    _bgController.value)!,
                Color.lerp(
                    const Color(0xFFFFF0F5),
                    const Color(0xFFFFC1CC),
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
              blurRadius: 14,
              color: Colors.pink.withOpacity(0.25),
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

  Widget configCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: Colors.pink.withOpacity(0.2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Text("Free Plan Config",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold)),

          const SizedBox(height: 16),

          buildTextField("Plan Name"),
          const SizedBox(height: 12),
          buildTextField("Price"),
          const SizedBox(height: 12),
          buildTextField("Duration (Days)"),
          const SizedBox(height: 12),
          buildTextField("Profile Views"),

          const SizedBox(height: 14),

          buildCheckbox("View Contact", viewContact,
              (v) => setState(() => viewContact = v!)),
          buildCheckbox("Send Interest", sendInterest,
              (v) => setState(() => sendInterest = v!)),
          buildCheckbox("Chat Access", chatAccess,
              (v) => setState(() => chatAccess = v!)),
          buildCheckbox("Plan Active", planActive,
              (v) => setState(() => planActive = v!)),

          const SizedBox(height: 18),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              padding:
                  const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        14),
              ),
            ),
            onPressed: () {},
            icon:
                const Icon(Icons.save,
                    color: Colors.white),
            label: const Text(
              "Save Plan Settings",
              style: TextStyle(
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget usersOnPlan() {
    return Container(
      width: double.infinity, // ✅ FULL WIDTH
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: Colors.pink.withOpacity(0.2),
          )
        ],
      ),
      child: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text("Users On Free Plan",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold)),
          SizedBox(height: 14),
          Divider(),
          SizedBox(height: 10),
          Text(
              "No active users on this plan."),
        ],
      ),
    );
  }

  Widget buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget buildCheckbox(
      String title,
      bool value,
      Function(bool?) onChanged) {
    return CheckboxListTile(
      activeColor: Colors.pinkAccent,
      title: Text(title),
      value: value,
      onChanged: onChanged,
      controlAffinity:
          ListTileControlAffinity.leading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor:
            Colors.pinkAccent,
        title: const Text(
          "Free Plan Settings",
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
                        statCard(
                            "ACTIVE USERS",
                            "0"),
                        statCard(
                            "TOTAL ASSIGNMENTS",
                            "3"),
                        statCard(
                            "STATUS",
                            "Live"),
                      ],
                    ),

                    const SizedBox(
                        height: 28),

                    configCard(),

                    const SizedBox(
                        height: 28),

                    usersOnPlan(),
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