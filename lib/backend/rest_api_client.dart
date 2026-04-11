import 'dart:convert';

import 'package:http/http.dart' as http;

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

  Future<void> _postJson(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      _buildUri(path),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

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

  Uri _buildUri(String path) {
    final root = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return Uri.parse(root).resolve(cleanPath);
  }
}
