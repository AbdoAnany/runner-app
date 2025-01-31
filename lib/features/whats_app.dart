import 'package:dio/dio.dart';

class WhatsAppVerificationService {
  final Dio _dio = Dio();
  final String _apiKey = "44504413fbbb07a0720f125b7400832a"; // تأكد أنه صحيح

  Future<void> sendWhatsAppOtp({required String phoneNumber}) async {
    try {
      final response = await _dio.post(
        'https://api.ycloud.com/v2/verify/verifications',
        data: {
          "channel": "whatsapp",
          "to": phoneNumber,
        },
        options: Options(headers: {
          "X-API-Key": _apiKey,
          "accept": "application/json",
          "content-type": "application/json",
        }),
      );
      print('✅ OTP Sent Successfully: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('❌ Error sending OTP: ${e.response?.data}');
      } else {
        print('❌ Unexpected error: $e');
      }
    }
  }

  Future<void> verifyWhatsAppOtp({
    required String phoneNumber,
    required String code,
    required String verificationId,
  }) async {
    try {
      final response = await _dio.post(
        'https://api.ycloud.com/v2/verify/verificationChecks',
        data: {
          'verificationId': verificationId,
          'to': phoneNumber,
          'code': code,
        },
        options: Options(headers: {
          "X-API-Key": _apiKey,
          "accept": "application/json",
          "content-type": "application/json",
        }),
      );
      print('✅ OTP Verified Successfully: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('❌ Error verifying OTP: ${e.response?.data}');
      } else {
        print('❌ Unexpected error: $e');
      }
    }
  }
}
