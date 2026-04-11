import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/admin_submissions.dart';
import '../models/contact_message.dart';
import '../models/volunteer_application.dart';

class RestApiException implements Exception {
  const RestApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class RestApiClient {
  RestApiClient(this.baseUrl, {http.Client? client})
    : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Future<void> submitContact(ContactMessage message) {
    return _postJson('/api/contact', message.toJson());
  }

  Future<void> submitVolunteer(VolunteerApplication application) {
    return _postJson('/api/volunteer', application.toJson());
  }

  Future<AdminSubmissionsSnapshot> fetchAdminSubmissions(
    String adminToken, {
    int limit = 25,
  }) async {
    final response = await _client.get(
      _buildUri('/api/admin/submissions?limit=$limit'),
      headers: _adminHeaders(adminToken),
    );

    return AdminSubmissionsSnapshot.fromJson(
      await _parseJsonMap(response),
    );
  }

  Future<void> _postJson(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      _buildUri(path),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    await _ensureSuccess(response);
  }

  Future<Map<String, dynamic>> _parseJsonMap(http.Response response) async {
    await _ensureSuccess(response);

    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw const RestApiException('The server returned an unexpected response.');
  }

  Future<void> _ensureSuccess(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    String message = 'Request failed with status ${response.statusCode}.';

    if (response.body.isNotEmpty) {
      try {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        if (decoded['errors'] case final List<dynamic> errors
            when errors.isNotEmpty) {
          message = errors.join(' ');
        } else if (decoded['error'] case final String error) {
          message = error;
        }
      } catch (_) {
        message = response.body;
      }
    }

    throw RestApiException(message);
  }

  Map<String, String> _adminHeaders(String adminToken) {
    return {
      'Authorization': 'Bearer $adminToken',
      'Content-Type': 'application/json',
    };
  }

  Uri _buildUri(String path) {
    final root = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return Uri.parse(root).resolve(cleanPath);
  }
}
