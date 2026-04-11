class VolunteerApplication {
  const VolunteerApplication({
    required this.fullName,
    required this.email,
    required this.initiative,
    required this.motivation,
  });

  final String fullName;
  final String email;
  final String initiative;
  final String motivation;

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'initiative': initiative,
      'motivation': motivation,
    };
  }
}
