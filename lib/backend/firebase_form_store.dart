import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/contact_message.dart';
import '../models/volunteer_application.dart';

class FirebaseFormStore {
  FirebaseFormStore(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> saveContactMessage(ContactMessage message) {
    return _firestore.collection('contactMessages').add({
      ...message.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'source': 'flutter-web',
    });
  }

  Future<void> saveVolunteerApplication(VolunteerApplication application) {
    return _firestore.collection('volunteerApplications').add({
      ...application.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'source': 'flutter-web',
    });
  }
}
