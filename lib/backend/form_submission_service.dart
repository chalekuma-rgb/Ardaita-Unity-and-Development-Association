import '../models/contact_message.dart';
import '../models/volunteer_application.dart';
import 'firebase_form_store.dart';
import 'rest_api_client.dart';

class SubmissionResult {
  const SubmissionResult({
    required this.message,
    required this.sentToApi,
    required this.sentToFirebase,
  });

  final String message;
  final bool sentToApi;
  final bool sentToFirebase;
}

class FormSubmissionService {
  const FormSubmissionService({
    this.restApiClient,
    this.firebaseFormStore,
    this.enableFirebaseSync = false,
  });

  final RestApiClient? restApiClient;
  final FirebaseFormStore? firebaseFormStore;
  final bool enableFirebaseSync;

  bool get isConfigured {
    return restApiClient != null ||
        (enableFirebaseSync && firebaseFormStore != null);
  }

  Future<SubmissionResult> submitContact(ContactMessage message) {
    return _submit(
      submitToApi: restApiClient == null
          ? null
          : () => restApiClient!.submitContact(message),
      submitToFirebase: enableFirebaseSync && firebaseFormStore != null
          ? () => firebaseFormStore!.saveContactMessage(message)
          : null,
      successLabel: 'Message submitted successfully.',
    );
  }

  Future<SubmissionResult> submitVolunteer(VolunteerApplication application) {
    return _submit(
      submitToApi: restApiClient == null
          ? null
          : () => restApiClient!.submitVolunteer(application),
      submitToFirebase: enableFirebaseSync && firebaseFormStore != null
          ? () => firebaseFormStore!.saveVolunteerApplication(application)
          : null,
      successLabel: 'Application submitted successfully.',
    );
  }

  Future<SubmissionResult> _submit({
    required Future<void> Function()? submitToApi,
    required Future<void> Function()? submitToFirebase,
    required String successLabel,
  }) async {
    if (submitToApi == null && submitToFirebase == null) {
      throw StateError(
        'No backend is configured. Set API_BASE_URL or enable Firebase sync with valid Firebase options.',
      );
    }

    var sentToApi = false;
    var sentToFirebase = false;
    Object? lastError;

    if (submitToApi != null) {
      try {
        await submitToApi();
        sentToApi = true;
      } catch (error) {
        lastError = error;
      }
    }

    if (submitToFirebase != null) {
      try {
        await submitToFirebase();
        sentToFirebase = true;
      } catch (error) {
        lastError ??= error;
      }
    }

    if (!sentToApi && !sentToFirebase) {
      throw lastError ?? StateError('Submission failed.');
    }

    var message = successLabel;
    if (sentToApi && sentToFirebase) {
      message = '$successLabel Synced to Firebase as well.';
    } else if (sentToFirebase && !sentToApi) {
      message = '$successLabel Saved through Firebase.';
    }

    return SubmissionResult(
      message: message,
      sentToApi: sentToApi,
      sentToFirebase: sentToFirebase,
    );
  }
}
