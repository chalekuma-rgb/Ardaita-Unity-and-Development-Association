class FormValidators {
  static String? requiredField(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required.';
    }
    return null;
  }

  static String? email(String? value) {
    final required = requiredField(value, 'Email address');
    if (required != null) {
      return required;
    }

    final normalized = value!.trim();
    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailPattern.hasMatch(normalized)) {
      return 'Enter a valid email address.';
    }

    return null;
  }

  static String? minLength(String? value, String label, int minLength) {
    final required = requiredField(value, label);
    if (required != null) {
      return required;
    }

    if (value!.trim().length < minLength) {
      return '$label must be at least $minLength characters long.';
    }

    return null;
  }
}
