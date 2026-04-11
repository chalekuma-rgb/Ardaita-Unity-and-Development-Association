class SubmissionItem {
  const SubmissionItem({
    required this.id,
    required this.createdAt,
    required this.fullName,
    required this.email,
    this.message,
    this.initiative,
    this.motivation,
  });

  factory SubmissionItem.fromJson(Map<String, dynamic> json) {
    return SubmissionItem(
      id: json['id'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      message: json['message'] as String?,
      initiative: json['initiative'] as String?,
      motivation: json['motivation'] as String?,
    );
  }

  final String id;
  final String createdAt;
  final String fullName;
  final String email;
  final String? message;
  final String? initiative;
  final String? motivation;
}

class SubmissionCollection {
  const SubmissionCollection({
    required this.items,
    required this.total,
    required this.limit,
  });

  factory SubmissionCollection.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(SubmissionItem.fromJson)
        .toList();

    return SubmissionCollection(
      items: items,
      total: json['total'] as int? ?? items.length,
      limit: json['limit'] as int? ?? items.length,
    );
  }

  final List<SubmissionItem> items;
  final int total;
  final int limit;
}

class AdminSubmissionsSnapshot {
  const AdminSubmissionsSnapshot({
    required this.contact,
    required this.volunteer,
  });

  factory AdminSubmissionsSnapshot.fromJson(Map<String, dynamic> json) {
    return AdminSubmissionsSnapshot(
      contact: SubmissionCollection.fromJson(
        json['contact'] as Map<String, dynamic>? ?? const {},
      ),
      volunteer: SubmissionCollection.fromJson(
        json['volunteer'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  final SubmissionCollection contact;
  final SubmissionCollection volunteer;
}