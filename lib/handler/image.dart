import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHandler {
  static Future<File?> pickImage() async {
    var picker = ImagePicker();
    try {
      var res = await picker.pickImage(source: ImageSource.gallery);
      if (res != null) {
        return File(res.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
