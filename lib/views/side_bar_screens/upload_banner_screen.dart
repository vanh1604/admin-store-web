import 'package:admin_wed/controllers/banner_controller.dart';
import 'package:admin_wed/widgets/banner_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = "/banners-screen";
  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final BannerController _bannerController = BannerController();
  dynamic _image;
  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Upload Banners',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(color: Colors.grey, thickness: 2),
        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: _image != null
                  ? Image.memory(_image)
                  : Center(child: Text('banner image')),
            ),
            ElevatedButton(
              onPressed: () async {
                await _bannerController.uploadBanner(
                  pickedImage: _image,
                  context: context,
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            pickImage();
          },
          child: Text('Pick Image'),
        ),
        Divider(color: Colors.grey),
        BannerWidget(),
      ],
    );
  }
}
