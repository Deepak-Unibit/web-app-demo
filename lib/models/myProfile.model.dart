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
      String? firstName, 
      String? lastName, 
      String? phoneNumber, 
      String? accountHolderName, 
      String? upiId, 
      bool? status, 
      num? earnedAmountTemp, 
      num? earnedAmount, 
      num? spinCount, 
      num? referralSpins, 
      String? referralCode, 
      List<String>? referrals, 
      num? referralCount, 
      num? referralCountForCash, 
      num? earnedReferralCash, 
      num? cashClaimedCount, 
      num? cashOutRequestFor10, 
      num? newLogicStatus, 
      num? referralCountDue, 
      num? currentSpinRequired, 
      num? cashOutCount, 
      num? payOutCount, 
      num? diamondsEarned, 
      num? spinFromDiamond, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _telegramId = telegramId;
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _accountHolderName = accountHolderName;
    _upiId = upiId;
    _status = status;
    _earnedAmountTemp = earnedAmountTemp;
    _earnedAmount = earnedAmount;
    _spinCount = spinCount;
    _referralSpins = referralSpins;
    _referralCode = referralCode;
    _referrals = referrals;
    _referralCount = referralCount;
    _referralCountForCash = referralCountForCash;
    _earnedReferralCash = earnedReferralCash;
    _cashClaimedCount = cashClaimedCount;
    _cashOutRequestFor10 = cashOutRequestFor10;
    _newLogicStatus = newLogicStatus;
    _referralCountDue = referralCountDue;
    _currentSpinRequired = currentSpinRequired;
    _cashOutCount = cashOutCount;
    _payOutCount = payOutCount;
    _diamondsEarned = diamondsEarned;
    _spinFromDiamond = spinFromDiamond;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  MyProfileData.fromJson(dynamic json) {
    _id = json['_id'];
    _telegramId = json['telegramId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _phoneNumber = json['phoneNumber'];
    _accountHolderName = json['accountHolderName'];
    _upiId = json['upiId'];
    _status = json['status'];
    _earnedAmountTemp = json['earnedAmountTemp'];
    _earnedAmount = json['earnedAmount'];
    _spinCount = json['spinCount'];
    _referralSpins = json['referralSpins'];
    _referralCode = json['referralCode'];
    _referrals = json['referrals'] != null ? json['referrals'].cast<String>() : [];
    _referralCount = json['referralCount'];
    _referralCountForCash = json['referralCountForCash'];
    _earnedReferralCash = json['earnedReferralCash'];
    _cashClaimedCount = json['cashClaimedCount'];
    _cashOutRequestFor10 = json['cashOutRequestFor10'];
    _newLogicStatus = json['newLogicStatus'];
    _referralCountDue = json['referralCountDue'];
    _currentSpinRequired = json['currentSpinRequired'];
    _cashOutCount = json['cashOutCount'];
    _payOutCount = json['payOutCount'];
    _diamondsEarned = json['diamondsEarned'];
    _spinFromDiamond = json['spinFromDiamond'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _telegramId;
  String? _firstName;
  String? _lastName;
  String? _phoneNumber;
  String? _accountHolderName;
  String? _upiId;
  bool? _status;
  num? _earnedAmountTemp;
  num? _earnedAmount;
  num? _spinCount;
  num? _referralSpins;
  String? _referralCode;
  List<String>? _referrals;
  num? _referralCount;
  num? _referralCountForCash;
  num? _earnedReferralCash;
  num? _cashClaimedCount;
  num? _cashOutRequestFor10;
  num? _newLogicStatus;
  num? _referralCountDue;
  num? _currentSpinRequired;
  num? _cashOutCount;
  num? _payOutCount;
  num? _diamondsEarned;
  num? _spinFromDiamond;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get telegramId => _telegramId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get phoneNumber => _phoneNumber;
  String? get accountHolderName => _accountHolderName;
  String? get upiId => _upiId;
  bool? get status => _status;
  num? get earnedAmountTemp => _earnedAmountTemp;
  num? get earnedAmount => _earnedAmount;
  num? get spinCount => _spinCount;
  num? get referralSpins => _referralSpins;
  String? get referralCode => _referralCode;
  List<String>? get referrals => _referrals;
  num? get referralCount => _referralCount;
  num? get referralCountForCash => _referralCountForCash;
  num? get earnedReferralCash => _earnedReferralCash;
  num? get cashClaimedCount => _cashClaimedCount;
  num? get cashOutRequestFor10 => _cashOutRequestFor10;
  num? get newLogicStatus => _newLogicStatus;
  num? get referralCountDue => _referralCountDue;
  num? get currentSpinRequired => _currentSpinRequired;
  num? get cashOutCount => _cashOutCount;
  num? get payOutCount => _payOutCount;
  num? get diamondsEarned => _diamondsEarned;
  num? get spinFromDiamond => _spinFromDiamond;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['telegramId'] = _telegramId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['phoneNumber'] = _phoneNumber;
    map['accountHolderName'] = _accountHolderName;
    map['upiId'] = _upiId;
    map['status'] = _status;
    map['earnedAmountTemp'] = _earnedAmountTemp;
    map['earnedAmount'] = _earnedAmount;
    map['spinCount'] = _spinCount;
    map['referralSpins'] = _referralSpins;
    map['referralCode'] = _referralCode;
    map['referrals'] = _referrals;
    map['referralCount'] = _referralCount;
    map['referralCountForCash'] = _referralCountForCash;
    map['earnedReferralCash'] = _earnedReferralCash;
    map['cashClaimedCount'] = _cashClaimedCount;
    map['cashOutRequestFor10'] = _cashOutRequestFor10;
    map['newLogicStatus'] = _newLogicStatus;
    map['referralCountDue'] = _referralCountDue;
    map['currentSpinRequired'] = _currentSpinRequired;
    map['cashOutCount'] = _cashOutCount;
    map['payOutCount'] = _payOutCount;
    map['diamondsEarned'] = _diamondsEarned;
    map['spinFromDiamond'] = _spinFromDiamond;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}