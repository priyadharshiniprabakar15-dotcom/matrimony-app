import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String loginUrl =
      "https://id36.evaangracetravels.com/matrimonial/api/api_login.php";

  static const String sendOtpUrl =
      "https://id36.evaangracetravels.com/matrimonial/api/api_send_otp.php";

  static const String chatUrl =
      "https://id36.evaangracetravels.com/matrimonial/api/api_chat.php";



  // LOGIN API
  static Future<Map<String, dynamic>> login(
      String email, String password) async {

    try {

      final response = await http.post(
        Uri.parse(loginUrl),
        body: {
          "email": email,
          "pswd": password,
        },
      );

      print("LOGIN STATUS: ${response.statusCode}");
      print("LOGIN RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {
        "status": "error",
        "message": "Server error"
      };

    } catch (e) {

      print("LOGIN ERROR: $e");

      return {
        "status": "error",
        "message": "Connection error"
      };
    }
  }



  // SIGNUP OTP API
  static Future<Map<String, dynamic>> sendOtp(
    String name,
    String email,
    String phone,
    String password,
    String rasi,
    String natchatiram,
  ) async {

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

      print("OTP STATUS: ${response.statusCode}");
      print("OTP RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return {
        "status": "error",
        "message": "Server error"
      };

    } catch (e) {

      print("OTP ERROR: $e");

      return {
        "status": "error",
        "message": "Connection error"
      };
    }
  }



  // CHAT LIST API
  static Future<List<dynamic>> getChats(String userId) async {

    try {

      final response = await http.post(
        Uri.parse(chatUrl),
        body: {
          "user_id": userId
        },
      );

      print("CHAT STATUS: ${response.statusCode}");
      print("CHAT RESPONSE: ${response.body}");

      if (response.statusCode != 200) {
        return [];
      }

      final data = jsonDecode(response.body);

      // Handle different API formats safely
      if (data is List) {
        return data;
      }

      if (data["data"] != null) {
        return data["data"];
      }

      if (data["messages"] != null) {
        return data["messages"];
      }

      return [];

    } catch (e) {

      print("CHAT ERROR: $e");
      return [];
    }
  }
}