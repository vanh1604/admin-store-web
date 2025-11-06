import 'dart:convert';

import 'package:admin_wed/global_variable.dart';
import 'package:admin_wed/models/banner.dart';
import 'package:admin_wed/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic("duzytwoln", "dmwyjltu");
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          pickedImage.buffer.asByteData(),
          identifier: 'pickedImage',
          folder: 'banner images',
        ),
      );
      String image = imageResponse.secureUrl;
      BannerModel banner = BannerModel(id: "", image: image);
      http.Response res = await http.post(
        Uri.parse("$uri/api/createbanner"),
        body: banner.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      manageHttpResponse(
        res: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Banner uploaded successfully");
        },
      );
    } catch (e) {
      print("Error: $e");
      showSnackBar(context, e.toString());
    }
  }

  //fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/getbanner"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(res.body);
        List<dynamic> data = responseData['banner'] ?? [];
        List<BannerModel> banners = data
            .map((banner) => BannerModel.fromJson(banner))
            .toList();
        return banners;
      } else {
        throw Exception("Failed to load banners");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('An error occurred while loading banners: $e');
    }
  }
}
