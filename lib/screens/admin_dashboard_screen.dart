import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'admin_manage_users_screen.dart';
import 'admin_premium_plans_screen.dart';
import 'admin_payments_screen.dart';
import 'notification_screen.dart';
import 'admin_user_access_screen.dart';
import 'admin_employees_screen.dart';
import 'admin_free_plan_screen.dart';
import 'admin_gold_plan_screen.dart';
import 'admin_diamond_plan_screen.dart';
import 'admin_slider_gallery_screen.dart';
import 'admin_settings_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(const Color(0xFFFFF5F7),
                    const Color(0xFFFFE3EC), _bgController.value)!,
                Color.lerp(const Color(0xFFFFF0F3),
                    const Color(0xFFFFF8E7), _bgController.value)!,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget floatingHearts() {
  return AnimatedBuilder(
    animation: _heartController,
    builder: (_, __) {
      return Stack(
        children: List.generate(10, (index) {
          final random = Random(index);
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;

          return Positioned(
            left: random.nextDouble() * width,
            bottom:
                (_heartController.value * height + index * 60) % height,
            child: Opacity(
              opacity: 0.12,
              child: Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
                size: 14 + random.nextDouble() * 18,
                shadows: [
                  Shadow(
                    blurRadius: 15,
                    color: Colors.pinkAccent,
                  )
                ],
              ),
            ),
          );
        }),
      );
    },
  );
}
Widget statCard(String title, String value, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFFDEBFF), // very light pink
          Color(0xFFE6F0FF), // very light blue
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        // Dark contrast glow
        BoxShadow(
          color: const Color(0xFF8f2eff).withOpacity(0.35),
          blurRadius: 25,
          spreadRadius: 2,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: const Color(0xFF8f2eff),
          size: 30,
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

  Widget userRow(String id, String name, String email) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text("#$id $name")),
          Expanded(flex: 3, child: Text(email)),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("ACTIVE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }

 Widget smallCard(String title, Widget child) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFFFF0F6), // soft pink
          Color(0xFFF3E8FF), // soft lavender
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF8f2eff).withOpacity(0.25),
          blurRadius: 22,
          spreadRadius: 1,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        child
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: PreferredSize(
  preferredSize: const Size.fromHeight(70),
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFff4e9b), // strong pink
          Color(0xFF8f2eff), // deep violet
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
      "Elite Matrimony ",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white, // if using gradient header
      ),
    ),
    AnimatedBuilder(
      animation: _heartController,
      builder: (_, __) {
        return Opacity(
          opacity: 0.5 + (0.5 * sin(_heartController.value * 6.28)),
          child: const Text(
            "😊",
            style: TextStyle(fontSize: 22),
          ),
        );
      },
    ),
  ],
),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NotificationScreen()),
            );
          },
        ),
      ],
    ),
  ),
),
      drawer: drawerSection(),
      body: Stack(
        children: [
          animatedBackground(),
          floatingHearts(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    children: [
                      statCard("Total Users", "13",
                          Icons.people),
                      statCard("Active Users", "13",
                          Icons.person),
                      statCard("Active Plans", "10",
                          Icons.workspace_premium),
                      statCard("Profiles", "13",
                          Icons.account_circle),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: smallCard(
                          "User Reports",
                          const Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text("Total: 0"),
                              Text("Pending: 0"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: smallCard(
                          "Event Reservations",
                          const Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text("Total: 3"),
                              Text("Pending: 2"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  smallCard(
                    "Recent Users",
                    Column(
                      children: [
                        userRow("32", "Pradeep N",
                            "iiidsumma@gmail.com"),
                        userRow("20", "Hasan",
                            "hasan@gmail.com"),
                        userRow("19", "Taman",
                            "tamana@gmail.com"),
                        userRow("18", "Pooja",
                            "pooja@gmail.com"),
                        userRow("17", "Samantha",
                            "sam@gmail.com"),
                        userRow("16", "Divya",
                            "divya@gmail.com"),
                        userRow("15", "Ram",
                            "pradep@gmail.com"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const SizedBox(height: 24),

Container(
  width: double.infinity, // ✅ Full width
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        blurRadius: 18,
        color: Colors.black12,
        offset: Offset(0, 8),
      )
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        "Recent Reports",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 14),

      // Table Headings
      Row(
        children: [
          Expanded(
            child: Text(
              "REPORT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              "CASE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              "STATUS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

      SizedBox(height: 12),
      Text("No reports submitted yet."),
    ],
  ),
),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawerSection() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 243, 125, 190),
              Color.fromARGB(255, 218, 123, 228),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 30),
            const Text("Elite ✨",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            drawerItem(Icons.dashboard, "Dashboard"),
            drawerItem(Icons.people, "User Access", onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminUserAccessScreen(),
    ),
  );
}),
            drawerItem(Icons.business_center, "Employees", onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminEmployeesScreen(),
    ),
  );
}),
           drawerItem(Icons.card_membership, "Free Plan", onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminFreePlanScreen(),
    ),
  );
}),
          drawerItem(Icons.star, "Gold Plan", onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminGoldPlanScreen(),
    ),
  );
}),
           drawerItem(Icons.workspace_premium, "Diamond Plan", onTap: () {
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminDiamondPlanScreen(),
    ),
  );
}),
           drawerItem(Icons.photo, "Slider & Gallery", onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminSliderGalleryScreen(),
    ),
  );
}),
            drawerItem(Icons.workspace_premium, "Premium Plans", onTap: () {
  Navigator.pop(context); // close drawer
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminPremiumPlansScreen(),
    ),
  );
}),
            drawerItem(Icons.payment, "Payments", onTap: () {
  Navigator.pop(context); // close drawer
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminPaymentsScreen(),
    ),
  );
}),
           drawerItem(Icons.settings, "Settings", onTap: () {
  Navigator.pop(context); // close drawer
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AdminSettingsScreen(),
    ),
  );
}),
            const Divider(color: Colors.white30),
            drawerItem(Icons.logout, "Logout", onTap: () {

  Navigator.pop(context); // close drawer

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text("Confirm Logout"),
      content: const Text(
        "Are you sure you want to logout?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // close dialog
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
              (route) => false, // remove all previous screens
            );
          },
          child: const Text("Logout"),
        ),
      ],
    ),
  );

}),
          ],
        ),
      ),
    );
  }

 Widget drawerItem(IconData icon, String title,
    {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
    }