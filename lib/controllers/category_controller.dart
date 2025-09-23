import 'package:cloudinary_public/cloudinary_public.dart';

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
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
      print(imageResponse);
      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          pickedImage.buffer.asByteData(),
          identifier: 'pickedBanner',
          folder: 'category banners',
        ),
      );
      print(bannerResponse);
    } catch (e) {
      print("Error: $e");
    }
  }
}
