import 'dart:ui';
import 'package:flutter/material.dart';
 
class SettingsScreen extends StatefulWidget {
  final String userId;
  const SettingsScreen({super.key, required this.userId});
 
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
 
class _SettingsScreenState extends State<SettingsScreen> {
 
  bool notifications  = true;
  bool privateAccount = false;
  String language     = "English";
  bool isSaving       = false;
 
  // ── DUMMY PLAN DATA (no API) ─────────────────────────────────
  final String planName   = "Gold";
  final String planStatus = "Active";
  final String expiryDate = "31-Dec-2025";
 
  final List<String> languages = [
    "English", "Tamil", "Hindi", "Telugu", "Kannada", "Malayalam",
  ];
 
  // ── MOCK SAVE (no API) ───────────────────────────────────────
  Future<void> _saveSettings() async {
    setState(() => isSaving = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Settings saved successfully."),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
 
  Widget glassTile(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
 
  Widget _planBadge() {
    Color badgeColor;
    switch (planName.toLowerCase()) {
      case "gold":     badgeColor = Colors.amber;       break;
      case "silver":   badgeColor = Colors.grey.shade300; break;
      case "platinum": badgeColor = Colors.cyan.shade200; break;
      default:         badgeColor = Colors.white70;
    }
    return glassTile(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium, color: Colors.amber, size: 22),
              const SizedBox(width: 10),
              Text("My Plan",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 13,
                      letterSpacing: 1.2)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: badgeColor.withOpacity(0.6)),
                ),
                child: Text(planName.toUpperCase(),
                    style: TextStyle(
                        color: badgeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 1.5)),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: planStatus.toLowerCase() == "active"
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: planStatus.toLowerCase() == "active"
                        ? Colors.green.shade300
                        : Colors.red.shade300,
                  ),
                ),
                child: Text(planStatus.toUpperCase(),
                    style: TextStyle(
                        color: planStatus.toLowerCase() == "active"
                            ? Colors.green.shade200
                            : Colors.red.shade200,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  color: Colors.white.withOpacity(0.5), size: 14),
              const SizedBox(width: 6),
              Text("Expires: $expiryDate",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
 
  Widget _languageTile() {
    return glassTile(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.language, color: Colors.white70, size: 22),
              const SizedBox(width: 12),
              const Text("Language",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: languages.contains(language) ? language : languages.first,
              dropdownColor: const Color(0xFF7A1528),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              onChanged: (val) {
                if (val != null) setState(() => language = val);
              },
              items: languages
                  .map((l) =>
                      DropdownMenuItem(value: l, child: Text(l)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFB23A48), Color(0xFF7A1528), Color(0xFF5C1120)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context)),
                    const Text("Settings",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  children: [
                    _planBadge(),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                      child: Text("PREFERENCES",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2)),
                    ),
                    glassTile(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.lock_outline,
                                  color: Colors.white70, size: 22),
                              const SizedBox(width: 12),
                              const Text("Private Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Switch(
                            value: privateAccount,
                            activeColor: Colors.amber,
                            activeTrackColor: Colors.amber.withOpacity(0.3),
                            inactiveThumbColor: Colors.white54,
                            inactiveTrackColor: Colors.white.withOpacity(0.15),
                            onChanged: (val) =>
                                setState(() => privateAccount = val),
                          ),
                        ],
                      ),
                    ),
                    glassTile(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.notifications_outlined,
                                  color: Colors.white70, size: 22),
                              const SizedBox(width: 12),
                              const Text("Notifications",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Switch(
                            value: notifications,
                            activeColor: Colors.amber,
                            activeTrackColor: Colors.amber.withOpacity(0.3),
                            inactiveThumbColor: Colors.white54,
                            inactiveTrackColor: Colors.white.withOpacity(0.15),
                            onChanged: (val) =>
                                setState(() => notifications = val),
                          ),
                        ],
                      ),
                    ),
                    _languageTile(),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : _saveSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          disabledBackgroundColor:
                              Colors.amber.withOpacity(0.5),
                          foregroundColor: const Color(0xFF5C1120),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                        ),
                        child: isSaving
                            ? const SizedBox(
                                width: 22, height: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Color(0xFF5C1120)))
                            : const Text("Save Settings",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
