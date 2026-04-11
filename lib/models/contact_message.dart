class ContactMessage {
  const ContactMessage({
    required this.fullName,
    required this.email,
    required this.message,
  });

  final String fullName;
  final String email;
  final String message;

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'email': email, 'message': message};
  }
}
