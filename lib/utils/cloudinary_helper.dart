class CloudinaryHelper {
  /// Injects Cloudinary transformation parameters to fetch a smaller thumbnail image.
  /// Example: https://res.cloudinary.com/demo/image/upload/v1234/sample.jpg
  /// Becomes: https://res.cloudinary.com/demo/image/upload/w_200,c_fill/v1234/sample.jpg
  static String getThumbnailUrl(String originalUrl, {int width = 200}) {
    if (originalUrl.isEmpty || !originalUrl.contains('/upload/')) {
      return originalUrl;
    }
    
    // Split the URL at '/upload/'
    List<String> parts = originalUrl.split('/upload/');
    if (parts.length != 2) {
      return originalUrl;
    }
    
    // Reconstruct with transformations
    return '${parts[0]}/upload/w_$width,c_fill/${parts[1]}';
  }
}
