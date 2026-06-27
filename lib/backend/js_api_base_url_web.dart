import 'dart:js_util' as js_util; // ignore: uri_does_not_exist

String getJsApiBaseUrl() {
  try {
    final value = js_util.getProperty(js_util.globalThis, 'API_BASE_URL');
    if (value is String && value.isNotEmpty) {
      return value;
    }
  } catch (_) {
    // ignore: avoid_print
    return '';
  }
  return '';
}
