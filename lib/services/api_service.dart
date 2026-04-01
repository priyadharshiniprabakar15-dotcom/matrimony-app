import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://id36.evaangracetravels.com/matrimonial/api/";

  static const String loginUrl    = "${baseUrl}api_login.php";
  static const String sendOtpUrl  = "${baseUrl}api_send_otp.php";
  static const String profileUrl  = "${baseUrl}api_get_profile.php";
  static const String chatUrl     = "${baseUrl}api_chat.php";
  static const String interestUrl = "${baseUrl}api_interests.php";
  static const String userPlanUrl = "${baseUrl}api_user_plan.php";

  // ================= LOGIN =================
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: {"email": email, "pswd": password},
      );

      print("LOGIN RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {"status": "error", "message": "Server error"};
    } catch (e) {
      print("LOGIN ERROR: $e");
      return {"status": "error", "message": "Connection error"};
    }
  }

  // ================= SEND OTP =================
  static Future<Map<String, dynamic>> sendOtp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String rasi,
    required String natchatiram,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(sendOtpUrl),
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "pswd": password,
          "confirm_pswd": password,
          "rasi": rasi,
          "natchatiram": natchatiram,
        },
      );

      print("OTP RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {"status": "error", "message": "Server error"};
    } catch (e) {
      print("OTP ERROR: $e");
      return {"status": "error", "message": "Connection error"};
    }
  }

  // ================= GET PROFILE =================
  static Future<Map<String, dynamic>> getProfile(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(profileUrl),
        body: {"user_id": userId},
      );

      print("PROFILE RESPONSE: ${response.body}");

      if (response.statusCode != 200) return {};

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        return data["data"] ?? {};
      }

      return {};
    } catch (e) {
      print("PROFILE ERROR: $e");
      return {};
    }
  }

  // ================= GET INTERESTS =================
  static Future<Map<String, dynamic>> getInterestsAll(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(interestUrl),
        body: {"user_id": userId},
      );

      print("INTEREST RESPONSE: ${response.body}");

      if (response.statusCode != 200) return {};

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        return data["data"] ?? {};
      }

      return {};
    } catch (e) {
      print("INTEREST ERROR: $e");
      return {};
    }
  }

  // ================= UPDATE INTEREST =================
  static Future<Map<String, dynamic>> updateInterest({
    required String userId,
    required String fromUserId,
    required String action,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(interestUrl),
        body: {
          "user_id": userId,
          "from_user_id": fromUserId,
          "action": action,
        },
      );

      print("UPDATE INTEREST RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {"status": "error"};
    } catch (e) {
      print("UPDATE INTEREST ERROR: $e");
      return {"status": "error"};
    }
  }

  // ================= GET CHATS =================
  static Future<List<dynamic>> getChats(String userId) async {
    try {
      final data = await getInterestsAll(userId);

      if (data.isEmpty) return [];

      final lists = data["lists"] ?? {};
      final accepted = lists["accepted"] ?? [];

      return accepted;
    } catch (e) {
      print("CHAT ERROR: $e");
      return [];
    }
  }

  // ================= SEND MESSAGE =================
  static Future<Map<String, dynamic>> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(chatUrl),
        body: {
          "user_id": senderId,
          "receiver_id": receiverId,
          "message": message,
          "action": "send",
        },
      );

      print("SEND MSG RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {"status": "error"};
    } catch (e) {
      print("SEND MSG ERROR: $e");
      return {"status": "error"};
    }
  }

  // ================= GET MESSAGES =================
  static Future<List<dynamic>> getMessages({
    required String userId,
    required String receiverId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(chatUrl),
        body: {
          "user_id": userId,
          "receiver_id": receiverId,
          "action": "get_messages",
        },
      );

      print("MESSAGES RESPONSE: ${response.body}");

      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);

      if (data is List) return data;

      if (data["status"] == "success") {
        return data["data"] ?? data["messages"] ?? [];
      }

      return [];
    } catch (e) {
      print("MESSAGES ERROR: $e");
      return [];
    }
  }

  // ================= GET USER PLAN =================
  static Future<Map<String, dynamic>> getUserPlan(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(userPlanUrl),
        body: {"user_id": userId},
      );

      print("USER PLAN RESPONSE: ${response.body}");

      if (response.statusCode != 200) return {};

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        return data["data"] ?? {};
      }

      return {};
    } catch (e) {
      print("USER PLAN ERROR: $e");
      return {};
    }
  }

  // ================= UPDATE SETTINGS =================
  static Future<Map<String, dynamic>> updateUserPlanSettings({
    required String userId,
    required String notifications,
    required String privateAccount,
    required String language,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(userPlanUrl),
        body: {
          "user_id": userId,
          "notifications": notifications,
          "private_account": privateAccount,
          "language": language,
          "action": "update_settings",
        },
      );

      print("UPDATE SETTINGS RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {"status": "error"};
    } catch (e) {
      print("UPDATE SETTINGS ERROR: $e");
      return {"status": "error"};
    }
  }
}