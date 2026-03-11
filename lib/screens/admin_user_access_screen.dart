import 'package:flutter/material.dart';

class AdminUserAccessScreen extends StatefulWidget {
  const AdminUserAccessScreen({super.key});

  @override
  State<AdminUserAccessScreen> createState() =>
      _AdminUserAccessScreenState();
}

class _AdminUserAccessScreenState
    extends State<AdminUserAccessScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  String? selectedPlan;

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

  // Animated Background
  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(
                    const Color.fromARGB(255, 238, 163, 213),
                    const Color.fromARGB(255, 209, 155, 236),
                    _bgController.value)!,
                Color.lerp(
                    const Color.fromARGB(255, 230, 164, 245),
                    const Color.fromARGB(255, 196, 172, 244),
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

  Widget activeBadge() {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.teal],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "ACTIVE",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    );
  }

  Widget userCard(
      String id,
      String name,
      String email,
      String plan,
      String expiry) {

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            color: Colors.black26,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // TOP ROW
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#$id $name",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(email,
                        style: const TextStyle(
                            color: Colors.grey)),
                  ],
                ),
              ),
              activeBadge(),
            ],
          ),

          const SizedBox(height: 16),

          // PLAN INFO
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text("Plan: $plan",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500)),
              Text("Expiry: $expiry"),
            ],
          ),

          const SizedBox(height: 18),

          // ACTIONS
          Row(
            children: [

              // Disable
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: const Text("Disable"),
              ),

              const SizedBox(width: 12),

              // Assign
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(
                            vertical: 14),
                    backgroundColor:
                        const Color.fromARGB(255, 252, 110, 219),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Assign",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 97, 156),
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.white), // back icon white
        title: const Text(
          "User Access & Plan Control",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Stack(
        children: [
          animatedBackground(),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    userCard("20", "Hasan",
                        "hasan@gmail.com",
                        "Gold", "27 Mar 2026"),

                    userCard("19", "Taman",
                        "tamana@gmail.com",
                        "Gold", "27 Mar 2026"),

                    userCard("18", "Pooja",
                        "pooja@gmail.com",
                        "Free", "-"),

                    userCard("17", "Samantha",
                        "sam@gmail.com",
                        "Gold", "29 Mar 2026"),

                    userCard("16", "Divya",
                        "divya@gmail.com",
                        "Diamond", "25 Mar 2026"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}