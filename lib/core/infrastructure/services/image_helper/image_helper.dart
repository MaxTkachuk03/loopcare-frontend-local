import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:mime/mime.dart';

class ImageHelper {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int quality = 95,
  }) async {
    return await _imagePicker.pickImage(source: source, imageQuality: quality);
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    final decodedImage = await decodeImageFromList(File(file.path).readAsBytesSync());

    return await _imageCropper.cropImage(
        sourcePath: file.path,
        compressQuality: 90,
        maxHeight: decodedImage.height ~/ 1.5,
        maxWidth: decodedImage.width ~/ 1.5,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: LocalizedTexts.avatarCropper.tr(),
            toolbarColor: AppColors.blueRegular,
            toolbarWidgetColor: AppColors.white,
            aspectRatioPresets: CropAspectRatioPreset.values,
          ),
          IOSUiSettings(
            title: LocalizedTexts.avatarCropper.tr(),
            aspectRatioPresets: CropAspectRatioPreset.values,
          )
        ]);
  }

  static String _getFileExtension(String path) => path.split('.').last;

  static List<String> _getMimeTypeData(String path) =>
      lookupMimeType(path, headerBytes: [0xFF, 0xD8])?.split('/') ?? [];

  static Future<MultipartFile> createMultipartFromAsset(String path) async {
    final extension = _getFileExtension(path);
    final Uint8List bytes = (await rootBundle.load(path)).buffer.asUint8List();
    final [mimeOne, mimeTwo] = _getMimeTypeData(path);

    return MultipartFile.fromBytes(
      bytes,
      filename: 'avatar.$extension',
      contentType: MediaType(mimeOne, mimeTwo),
    );
  }

  static Future<MultipartFile> createMultipartFromFile(File file) async {
    final extension = _getFileExtension(file.path);
    final [mimeOne, mimeTwo] = _getMimeTypeData(file.path);

    return MultipartFile.fromFile(
      file.path,
      filename: 'avatar.$extension',
      contentType: MediaType(mimeOne, mimeTwo),
    );
  }
}
