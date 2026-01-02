import 'dart:convert';

import 'package:admin_wed/global_variable.dart';
import 'package:admin_wed/models/vendor.dart';
import 'package:http/http.dart' as http;

class VendorController {
  Future<List<Vendor>> loadVendors() async {
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/vendors"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(res.body);
        List<dynamic> data = responseData['vendors'] ?? [];
        List<Vendor> vendors = data
            .map((vendor) => Vendor.fromMap(vendor))
            .toList();
        return vendors;
      } else {
        throw Exception("Failed to load vendors");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('An error occurred while loading vendors: $e');
    }
  }
}
