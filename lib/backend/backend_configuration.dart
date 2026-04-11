class BackendConfiguration {
  const BackendConfiguration({
    required this.apiBaseUrl,
    required this.enableFirebaseSync,
  });

  factory BackendConfiguration.fromEnvironment() {
    return BackendConfiguration(
      apiBaseUrl: _normalizeBaseUrl(
        const String.fromEnvironment('API_BASE_URL', defaultValue: ''),
      ),
      enableFirebaseSync: const bool.fromEnvironment(
        'ENABLE_FIREBASE_SYNC',
        defaultValue: false,
      ),
    );
  }

  final String apiBaseUrl;
  final bool enableFirebaseSync;

  bool get hasApiBaseUrl => apiBaseUrl.isNotEmpty;

  static String _normalizeBaseUrl(String value) {
    final trimmed = value.trim();
    if (trimmed.endsWith('/')) {
      return trimmed.substring(0, trimmed.length - 1);
    }
    return trimmed;
  }
}
