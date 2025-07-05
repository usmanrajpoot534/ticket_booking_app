import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_booking_app/services/api_response.dart';
import 'package:ticket_booking_app/services/validate_api.dart';

/// ## ApiClient
class ApiClient {
  static final _instance = ApiClient._singleton();

  factory ApiClient() => _instance;

  ApiClient._singleton();

  final _baseUrl = dotenv.env['BASE_URL']!;

  String authToken = dotenv.env['API_ACCESS_TOKEN']!;

  Map<String, String> get _loginHeaders {
    return {'Accept': 'application/json', 'Authorization': 'Bearer $authToken'};
  }

  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
  }

  Future<ApiResponse<T>> login<T>({
    required String endpoint,
    ReqObj? request,
    FromJson<T>? fromJson,
  }) async {
    final url = Uri.parse('$_baseUrl$endpoint');

    final api = ValidatedApi<T>(
      apiCall: () => http.post(url, body: request, headers: _loginHeaders),
      fromJson: fromJson,
      request: request,
      endpoint: '$_baseUrl$endpoint',
    );

    return await api.result;
  }

  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    ReqObj? request,
    FromJson<T>? fromJson,
  }) async {
    final url = Uri.parse('$_baseUrl$endpoint');

    final api = ValidatedApi<T>(
      apiCall: () =>
          http.post(url, body: jsonEncode(request), headers: _headers),
      fromJson: fromJson,
      request: request,
      endpoint: '$_baseUrl$endpoint',
    );

    return await api.result;
  }

  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    ReqObj? request,
    FromJson<T>? fromJson,
  }) async {
    final url = '$_baseUrl$endpoint';

    final api = ValidatedApi<T>(
      apiCall: () => http.get(
        Uri.parse(url).replace(queryParameters: request),
        headers: _headers,
      ),
      fromJson: fromJson,
      request: request,
      endpoint: '$_baseUrl$endpoint',
    );

    return await api.result;
  }

  Future<ApiResponse<T>> patch<T>({
    required String endpoint,
    ReqObj? request,
    FromJson<T>? fromJson,
  }) async {
    final url = Uri.parse('$_baseUrl$endpoint');

    final api = ValidatedApi<T>(
      apiCall: () =>
          http.patch(url, body: jsonEncode(request), headers: _headers),
      fromJson: fromJson,
      request: request,
      endpoint: '$_baseUrl$endpoint',
    );

    return await api.result;
  }
}

typedef ReqObj = Map<String, dynamic>;
typedef FromJson<T> = T Function(ReqObj);
typedef ApiCaller = Future<http.Response> Function();
