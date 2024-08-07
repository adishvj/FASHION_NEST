// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../constants.dart';
// import '../models/auth_model.dart';
//
// class AuthServices {
//   Future<void> register({required AuthModel auth}) async {
//     final Uri url = Uri.parse('$baseurl/api/auth/register');
//
//     try {
//       print(auth.toJson());
//       final response = await http.post(url, body: auth.toJson());
//
//       if (response.statusCode == 200) {
//         print('Registration successful');
//       } else {
//         throw Exception(
//             'Failed to register. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error during registration: $e');
//       throw Exception('An error occurred during registration');
//     }
//   }
//
//   Future<void> login(
//       {required String username, required String password}) async {
//     final Uri url = Uri.parse('$baseurl/api/auth/login');
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'username': username,
//           'password': password,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         print('Login successful');
//         // Optionally, you can return or save user data from response
//         // return jsonDecode(response.body);
//       } else if (response.statusCode == 400) {
//         // Handle specific error for bad request
//         print('Login failed: ${response.body}');
//         throw Exception('Failed to login. ${response.body}');
//       } else if (response.statusCode == 401) {
//         // Handle unauthorized error
//         print('Login failed: Incorrect password');
//         throw Exception('Failed to login. Incorrect password.');
//       } else {
//         print('Login failed: ${response.body}');
//         throw Exception('Failed to login. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle exceptions
//       print('Error during login: $e');
//       throw Exception('An error occurred during login');
//     }
//   }
// }
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/auth_model.dart';

class AuthServices {
  String? userId;

  AuthServices() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print('Loaded user ID: $userId');
  }

  Future<void> _saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
    userId = id;
    print('Saved user ID: $userId');
  }

  Future<void> register({required AuthModel user}) async {
    final Uri url = Uri.parse('$baseurl/api/auth/register');
    try {
      final response = await http.post(url, body: user.toJson());

      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        print('Failed to register. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
      throw Exception('An error occurred during registration');
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    final Uri url = Uri.parse('$baseurl/api/auth/login');
    try {
      final Map<String, dynamic> body = {
        'username': username,
        'password': password,
      };
      print("Request body: $body");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        print('User ID from response: ${responseData['_id']}');
        print('Username from response: ${responseData['username']}');
        print('Email from response: ${responseData['email']}');

        userId = responseData['loginid'];
        if (userId != null) {
          await _saveUserId(userId!);
          print('Login successful');
          print('User ID: $userId');
        } else {
          print('User ID is null');
          throw Exception('User ID not found in response');
        }
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('An error occurred during login');
    }
  }
}
