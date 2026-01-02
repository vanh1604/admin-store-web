import 'dart:convert';

import 'package:admin_wed/global_variable.dart';
import 'package:admin_wed/models/order.dart';
import 'package:http/http.dart' as http;

class OrderController {
  Future<List<Order>> loadOrders() async {
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/orders"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(res.body);
        List<dynamic> data = responseData['orders'] ?? [];
        List<Order> orders = data.map((order) => Order.fromMap(order)).toList();
        return orders;
      } else {
        throw Exception("Failed to load orders");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('An error occurred while loading orders: $e');
    }
  }
}
