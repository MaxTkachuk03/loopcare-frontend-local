import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ImageHelper {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  Future<XFile?> pickImage(
      {ImageSource source = ImageSource.gallery, int quality = 100}) async {
    return await _imagePicker.pickImage(source: source, imageQuality: quality);
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    return await _imageCropper
        .cropImage(sourcePath: file.path, compressQuality: 100, uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: AppColors.blueRegular,
        toolbarWidgetColor: AppColors.white,
        aspectRatioPresets: CropAspectRatioPreset.values,
      ),
      IOSUiSettings(
          title: 'Cropper', aspectRatioPresets: CropAspectRatioPreset.values)
    ]);
  }
}
