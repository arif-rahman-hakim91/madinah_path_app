import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PhotoService {
  final picker = ImagePicker();

  Future<File?> pickImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }
}