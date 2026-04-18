import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickFromGallery(ImagePicker picker) async {
  try {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    print("Selected: ${image.path}");

    return File(image.path);
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}

Future<File?> takePicture(CameraController controller) async {
  try {
    if (!controller.value.isInitialized) return null;

    final XFile image = await controller.takePicture();

    return File(image.path);
  } catch (e) {
    print("Error taking picture: $e");
    return null;
  }
}

Future<void> toggleFlash(bool _isFlashOn, dynamic cameraController) async {
  try {
    await cameraController.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  } catch (e) {
    print("Flash error: $e");
  }
}
