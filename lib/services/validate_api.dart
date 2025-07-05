import 'dart:convert';

import 'package:ticket_booking_app/services/api_client.dart';
import 'package:ticket_booking_app/services/api_response.dart';

class ValidatedApi<T> extends ApiResponse<T> {
  final ApiCaller apiCall;
  final FromJson<T>? fromJson;
  ValidatedApi({
    required this.apiCall,
    this.fromJson,
    super.endpoint,
    super.request,
  });

  Future<ApiResponse<T>> get result => _callApi();

  Future<ApiResponse<T>> _callApi() async {
    try {
      final resp = await apiCall();

      if (resp.statusCode >= 200 && resp.statusCode <= 203) {
        final body = jsonDecode(resp.body);
        dynamic data = fromJson == null ? body : fromJson!(body);

        return ApiResponse<T>(
          endpoint: endpoint,
          request: request,
          code: resp.statusCode,
          data: data,
          response: resp,
        );
      }

      return ApiResponse<T>(
        endpoint: endpoint,
        request: request,
        code: resp.statusCode,
        data: null,
        success: false,
        response: resp,
        message: '',
      );
    } catch (e) {
      return ApiResponse<T>(
        endpoint: endpoint,
        request: request,
        code: -1,
        data: null,
        success: false,
        message: e.toString(),
      );
    }
  }
}
