import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'backend_configuration.dart';
import 'firebase_form_store.dart';
import 'firebase_runtime_options.dart';
import 'form_submission_service.dart';
import 'rest_api_client.dart';

class AppBackend {
  static final BackendConfiguration configuration =
      BackendConfiguration.fromEnvironment();

  static FormSubmissionService _formSubmissionService = FormSubmissionService(
    restApiClient: configuration.hasApiBaseUrl
        ? RestApiClient(configuration.apiBaseUrl)
        : null,
    enableFirebaseSync: false,
  );

  static FormSubmissionService get formSubmissionService =>
      _formSubmissionService;

  static Future<void> initialize() async {
    FirebaseFormStore? firebaseFormStore;

    if (configuration.enableFirebaseSync) {
      final runtimeOptions = FirebaseRuntimeOptions.fromEnvironment();
      if (!runtimeOptions.isConfigured) {
        debugPrint(
          'Firebase sync is enabled but Firebase runtime options are missing.',
        );
      } else {
        try {
          await Firebase.initializeApp(options: runtimeOptions.toOptions());
          firebaseFormStore = FirebaseFormStore(FirebaseFirestore.instance);
        } catch (error) {
          debugPrint('Firebase initialization failed: $error');
        }
      }
    }

    _formSubmissionService = FormSubmissionService(
      restApiClient: configuration.hasApiBaseUrl
          ? RestApiClient(configuration.apiBaseUrl)
          : null,
      firebaseFormStore: firebaseFormStore,
      enableFirebaseSync: configuration.enableFirebaseSync,
    );
  }
}
