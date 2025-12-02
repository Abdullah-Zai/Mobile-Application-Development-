import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraService {
  static final ImagePicker _picker = ImagePicker();

  // pick image from camera
  static Future<File?> pickImageFromCamera() async {
    try {
      final XFile? photo =
      await _picker.pickImage(source: ImageSource.camera, imageQuality: 75);

      if (photo == null) return null;
      return File(photo.path);
    } catch (e) {
      print('Camera error: $e');
      return null;
    }
  }
}
