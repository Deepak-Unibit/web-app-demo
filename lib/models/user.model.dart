class UserModel {
  UserModel({
    num? id,
    String? firstName,
    String? lastName,
    String? languageCode,
    bool? allowsWriteToPm,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _languageCode = languageCode;
    _allowsWriteToPm = allowsWriteToPm;
  }

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _languageCode = json['language_code'];
    _allowsWriteToPm = json['allows_write_to_pm'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _languageCode;
  bool? _allowsWriteToPm;

  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get languageCode => _languageCode;
  bool? get allowsWriteToPm => _allowsWriteToPm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['language_code'] = _languageCode;
    map['allows_write_to_pm'] = _allowsWriteToPm;
    return map;
  }
}
