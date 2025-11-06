import 'dart:convert';

import 'package:admin_wed/global_variable.dart';
import 'package:admin_wed/models/subcategory.dart';
import 'package:admin_wed/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  uploadSubcategory({
    required String categoryId,
    required String categoryName,
    required dynamic pickedImage,
    required String subCategoryName,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("duzytwoln", "dmwyjltu");
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          pickedImage.buffer.asByteData(),
          identifier: 'pickedImage',
          folder: 'category images',
        ),
      );
      String image = imageResponse.secureUrl;
      Subcategory subcategory = Subcategory(
        id: "",
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subCategoryName: subCategoryName,
      );
      http.Response res = await http.post(
        Uri.parse("$uri/api/subcategories"),
        body: subcategory.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      manageHttpResponse(
        res: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Subcategory created successfully");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<Subcategory>> loadSubcategories() async {
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/subcategories"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode == 200) {
        print(res.body);
        Map<String, dynamic> responseData = jsonDecode(res.body);
        List<dynamic> data = responseData['subcategories'] ?? [];
        List<Subcategory> subcategories = data
            .map((subcategory) => Subcategory.fromJson(subcategory))
            .toList();
        print(subcategories);
        return subcategories;
      } else {
        throw Exception("Failed to load subcategories");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('An error occurred while loading subcategories: $e');
    }
  }
}
