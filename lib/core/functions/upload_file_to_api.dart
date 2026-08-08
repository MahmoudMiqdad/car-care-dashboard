import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

Future<MultipartFile?> uploadFileToApi(XFile? image) async {
  if (image == null) return null;
  final bytes = await image.readAsBytes();
  return MultipartFile.fromBytes(bytes, filename: image.name);
}