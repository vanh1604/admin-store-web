import 'dart:convert';

import 'package:admin_wed/global_variable.dart';
import 'package:admin_wed/models/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  Future<List<User>> loadUsers() async {
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/users"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(res.body);
        List<dynamic> data = responseData['users'] ?? [];
        List<User> users = data.map((user) => User.fromMap(user)).toList();
        return users;
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('An error occurred while loading users: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/api/users/$id"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode != 200 && res.statusCode != 204) {
        throw Exception("Failed to delete user: ${res.body}");
      }
    } catch (e) {
      print("Error deleting user: $e");
      throw Exception('An error occurred while deleting user: $e');
    }
  }
}
