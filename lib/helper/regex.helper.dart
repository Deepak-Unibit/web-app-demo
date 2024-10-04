class RegexHelper{
  static RegExp nameRegex = RegExp(r'^[A-Za-z]+(\s[A-Za-z ]+)?$');
  static RegExp emailRegex = RegExp(r"^([A-Za-z0-9._%+-]+)@([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,5})$");
  static RegExp mobileRegex = RegExp(r"^[6-9][0-9]{9}$");
  static RegExp cityRegex = RegExp(r"^[A-Za-z]{4,28}$");
  static RegExp ageRegex = RegExp(r"^(?:[2-7][0-9]|80)$");
  static RegExp pinCodeRegex = RegExp(r"^\d{6}$");
  static RegExp bankAccountNumberRegex = RegExp(r"^[0-9]{9,18}$");
  static RegExp ifscCodeRegex = RegExp(r"^[A-Z]{4}0[A-Z0-9]{6}$");

}