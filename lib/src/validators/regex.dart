class AppRegex {
  static final voterId = RegExp(r"^[A-Z]{3}[0-9]{7}$");
  static final aadhaar = RegExp(r'^[0-9]{12}$');
  static final panCard = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  static final name = RegExp(
    r"^[a-zA-Z0-9\s\.,#\-\/\:\!\@\$\#\'\%\^\&\*\(\)\-\=\+\_\;\?\{\}\[\]]+$",
  );
  static final ifsc = RegExp(r"^[A-Z]{4}0[A-Z\d]{6}");
  static final bankAccount = RegExp(r"^\d{8,18}$");
  static final mobile = RegExp(r'^\d{10}$');
  static final email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final pinCode = RegExp(r'^\d{6}$');
  static final passwordStrong = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#\$&*~]).{8,}$',
  );
}
