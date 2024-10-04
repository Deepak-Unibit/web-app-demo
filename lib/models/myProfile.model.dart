class MyProfileModel {
  MyProfileModel({
      String? status, 
      String? message, 
      num? responseCode, 
      MyProfileData? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  MyProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'] != null ? MyProfileData.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  num? _responseCode;
  MyProfileData? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  MyProfileData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['responseCode'] = _responseCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class MyProfileData {
  MyProfileData({
      String? id, 
      String? telegramId, 
      String? username, 
      String? firstName, 
      String? lastName, 
      num? earnedAmountTemp, 
      num? earnedAmount, 
      num? spinCount, 
      num? referralSpins, 
      String? referralCode, 
      num? referralCount, 
      num? referralCountDue, 
      num? cashOutCount, 
      String? accountHolderName, 
      String? phoneNumber, 
      String? upiId, 
      List<String>? referrals, 
      bool? status,}){
    _id = id;
    _telegramId = telegramId;
    _username = username;
    _firstName = firstName;
    _lastName = lastName;
    _earnedAmountTemp = earnedAmountTemp;
    _earnedAmount = earnedAmount;
    _spinCount = spinCount;
    _referralSpins = referralSpins;
    _referralCode = referralCode;
    _referralCount = referralCount;
    _referralCountDue = referralCountDue;
    _cashOutCount = cashOutCount;
    _accountHolderName = accountHolderName;
    _phoneNumber = phoneNumber;
    _upiId = upiId;
    _referrals = referrals;
    _status = status;
}

  MyProfileData.fromJson(dynamic json) {
    _id = json['_id'];
    _telegramId = json['telegramId'];
    _username = json['username'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _earnedAmountTemp = json['earnedAmountTemp'];
    _earnedAmount = json['earnedAmount'];
    _spinCount = json['spinCount'];
    _referralSpins = json['referralSpins'];
    _referralCode = json['referralCode'];
    _referralCount = json['referralCount'];
    _referralCountDue = json['referralCountDue'];
    _cashOutCount = json['cashOutCount'];
    _accountHolderName = json['accountHolderName'];
    _phoneNumber = json['phoneNumber'];
    _upiId = json['upiId'];
    _referrals = json['referrals'] != null ? json['referrals'].cast<String>() : [];
    _status = json['status'];
  }
  String? _id;
  String? _telegramId;
  String? _username;
  String? _firstName;
  String? _lastName;
  num? _earnedAmountTemp;
  num? _earnedAmount;
  num? _spinCount;
  num? _referralSpins;
  String? _referralCode;
  num? _referralCount;
  num? _referralCountDue;
  num? _cashOutCount;
  String? _accountHolderName;
  String? _phoneNumber;
  String? _upiId;
  List<String>? _referrals;
  bool? _status;

  String? get id => _id;
  String? get telegramId => _telegramId;
  String? get username => _username;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  num? get earnedAmountTemp => _earnedAmountTemp;
  num? get earnedAmount => _earnedAmount;
  num? get spinCount => _spinCount;
  num? get referralSpins => _referralSpins;
  String? get referralCode => _referralCode;
  num? get referralCount => _referralCount;
  num? get referralCountDue => _referralCountDue;
  num? get cashOutCount => _cashOutCount;
  String? get accountHolderName => _accountHolderName;
  String? get phoneNumber => _phoneNumber;
  String? get upiId => _upiId;
  List<String>? get referrals => _referrals;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['telegramId'] = _telegramId;
    map['username'] = _username;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['earnedAmountTemp'] = _earnedAmountTemp;
    map['earnedAmount'] = _earnedAmount;
    map['spinCount'] = _spinCount;
    map['referralSpins'] = _referralSpins;
    map['referralCode'] = _referralCode;
    map['referralCount'] = _referralCount;
    map['referralCountDue'] = _referralCountDue;
    map['cashOutCount'] = _cashOutCount;
    map['accountHolderName'] = _accountHolderName;
    map['phoneNumber'] = _phoneNumber;
    map['upiId'] = _upiId;
    map['referrals'] = _referrals;
    map['status'] = _status;
    return map;
  }

}