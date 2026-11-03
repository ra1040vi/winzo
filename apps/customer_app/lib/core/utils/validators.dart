/// Form validators shared across the sign-up and login flows.
///
/// Each returns `null` when the value is acceptable, or a user-facing message.
class Validators {
  Validators._();

  static final _emailPattern = RegExp(
    r"^[\w.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
  );

  static final _namePattern = RegExp(r"^[\p{L}][\p{L}\s'.-]*$", unicode: true);

  /// Collapses runs of whitespace so `"Ada  Lovelace"` measures as typed.
  static String _normalise(String? value) =>
      (value ?? '').trim().replaceAll(RegExp(r'\s+'), ' ');

  /// A single free-form name field.
  ///
  /// Mononyms are accepted on purpose: single legal names are common in India,
  /// so requiring a surname here would lock out real customers.
  static String? fullName(String? value) {
    final trimmed = _normalise(value);
    if (trimmed.isEmpty) return 'Full name is required';
    if (trimmed.length < 2) return 'Full name must be at least 2 characters';
    if (trimmed.length > 60) return 'Full name must be under 60 characters';
    if (!_namePattern.hasMatch(trimmed)) return 'Enter a valid full name';
    return null;
  }

  /// Passwords are never trimmed - spaces are legitimate characters.
  static String? password(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Use at least 8 characters';
    if (password.length > 64) return 'Password must be under 64 characters';
    if (!RegExp(r'[A-Za-z]').hasMatch(password)) {
      return 'Include at least one letter';
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Include at least one number';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if ((value ?? '').isEmpty) return 'Confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  /// Presence-only check for the sign-in form.
  ///
  /// Deliberately does *not* apply the sign-up strength rules: an account
  /// created under older rules must still be able to log in.
  static String? requiredPassword(String? value) {
    if ((value ?? '').isEmpty) return 'Password is required';
    return null;
  }

  static String? email(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Email is required';
    if (trimmed.length > 254 || !_emailPattern.hasMatch(trimmed)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Cognito verification codes are six numeric digits.
  static String? confirmationCode(String? value) {
    final trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return 'Enter the 6-digit code';
    if (!RegExp(r'^\d{6}$').hasMatch(trimmed)) {
      return 'The code is 6 digits';
    }
    return null;
  }
}
