import 'dart:ui';
import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() =>
      _AdminSettingsScreenState();
}

class _AdminSettingsScreenState
    extends State<AdminSettingsScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _floatController;

  late Animation<double> _bgAnimation;
  late Animation<double> _floatAnimation;

  bool notifications = true;
  bool darkMode = false;
  bool maintenanceMode = false;
  bool autoApprove = false;

  @override
  void initState() {
    super.initState();

    // 🌸 Background animation
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat(reverse: true);

    _bgAnimation =
        Tween<double>(begin: 0, end: 1).animate(_bgController);

    // 🌊 Floating animation
    _floatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _floatAnimation =
        Tween<double>(begin: -30, end: 30).animate(_floatController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // 💎 Glass Setting Tile
  Widget settingTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 15,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: Colors.amber,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme:
            const IconThemeData(color: Colors.black),
        title: const Text("⚙ Admin Settings",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          // 🌸 Animated Light Gradient
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFFE3F2FD),
                          const Color(0xFFF3E5F5),
                          _bgAnimation.value)!,
                      Color.lerp(
                          const Color(0xFFFFF3E0),
                          const Color(0xFFE8F5E9),
                          _bgAnimation.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          // 🌊 Floating Shapes
          Positioned(
            top: -60,
            left: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: -60,
            right: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, -_floatAnimation.value),
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [

                  const SizedBox(height: 30),

                  // 👤 Admin Profile
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25),
                      color:
                          Colors.white.withOpacity(0.85),
                    ),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              "assets/images/onboard1.png"),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "Elite Admin 👑\nadmin@elitematrimony.com",
                            style: TextStyle(
                                color: Colors.black87),
                          ),
                        )
                      ],
                    ),
                  ),

                  sectionTitle("🔔 Notifications"),

                  settingTile(
                    title: "Enable Notifications",
                    subtitle:
                        "Receive alerts for reports & approvals",
                    value: notifications,
                    onChanged: (val) =>
                        setState(() => notifications = val),
                  ),

                  sectionTitle("🎨 Appearance"),

                  settingTile(
                    title: "Dark Mode",
                    subtitle:
                        "Switch between light & dark theme",
                    value: darkMode,
                    onChanged: (val) =>
                        setState(() => darkMode = val),
                  ),

                  sectionTitle("🛡 Security & Control"),

                  settingTile(
                    title: "Maintenance Mode",
                    subtitle:
                        "Temporarily disable user access",
                    value: maintenanceMode,
                    onChanged: (val) =>
                        setState(() => maintenanceMode = val),
                  ),

                  settingTile(
                    title: "Auto Approve Profiles",
                    subtitle:
                        "Automatically approve verified users",
                    value: autoApprove,
                    onChanged: (val) =>
                        setState(() => autoApprove = val),
                  ),

                  sectionTitle("🌐 Server Status"),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25),
                      color:
                          Colors.white.withOpacity(0.85),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.cloud_done,
                            color: Colors.green),
                        SizedBox(width: 10),
                        Text("Server Running Smoothly",
                            style: TextStyle(
                                color: Colors.black87)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}