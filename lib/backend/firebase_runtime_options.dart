import 'package:firebase_core/firebase_core.dart';

class FirebaseRuntimeOptions {
  const FirebaseRuntimeOptions({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    required this.authDomain,
    required this.storageBucket,
    required this.measurementId,
  });

  factory FirebaseRuntimeOptions.fromEnvironment() {
    return const FirebaseRuntimeOptions(
      apiKey: String.fromEnvironment('FIREBASE_API_KEY', defaultValue: ''),
      appId: String.fromEnvironment('FIREBASE_APP_ID', defaultValue: ''),
      messagingSenderId: String.fromEnvironment(
        'FIREBASE_MESSAGING_SENDER_ID',
        defaultValue: '',
      ),
      projectId: String.fromEnvironment(
        'FIREBASE_PROJECT_ID',
        defaultValue: '',
      ),
      authDomain: String.fromEnvironment(
        'FIREBASE_AUTH_DOMAIN',
        defaultValue: '',
      ),
      storageBucket: String.fromEnvironment(
        'FIREBASE_STORAGE_BUCKET',
        defaultValue: '',
      ),
      measurementId: String.fromEnvironment(
        'FIREBASE_MEASUREMENT_ID',
        defaultValue: '',
      ),
    );
  }

  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String authDomain;
  final String storageBucket;
  final String measurementId;

  bool get isConfigured {
    return apiKey.isNotEmpty &&
        appId.isNotEmpty &&
        messagingSenderId.isNotEmpty &&
        projectId.isNotEmpty;
  }

  FirebaseOptions toOptions() {
    return FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: authDomain.isEmpty ? null : authDomain,
      storageBucket: storageBucket.isEmpty ? null : storageBucket,
      measurementId: measurementId.isEmpty ? null : measurementId,
    );
  }
}
