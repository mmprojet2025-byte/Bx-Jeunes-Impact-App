import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/api_service_provider.dart';
import '../../shared/services/api_service.dart';
 
class ImageUploadService {
  final ApiService _api;
  ImageUploadService(this._api);
  Future<String?> uploadImage(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
    });
    final result = await _api.upload<Map<String, dynamic>>('/upload',
      formData: formData, fromJson: (j) => j as Map<String, dynamic>);
    return result['url'] as String?;
  }
}
 
final imageUploadServiceProvider = Provider<ImageUploadService>((ref) =>
    ImageUploadService(ref.read(apiServiceProvider)));
 