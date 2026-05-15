import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/constants/app_config.dart';
import 'secure_storage_service.dart';
 
class ImageUploadService {
  static Future<String?> uploadImage(File file) async {
    final token = await SecureStorageService.getAccessToken();
    final dio = Dio();
 
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });
 
    final response = await dio.post(
      '${AppConfig.baseUrl}/upload',
      data: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
 
    return response.data['url'] as String?;
  }
}
