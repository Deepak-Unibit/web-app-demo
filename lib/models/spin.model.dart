class SpinModel {
  SpinModel({
      String? status, 
      String? message, 
      num? responseCode, 
      SpinData? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  SpinModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'] != null ? SpinData.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  num? _responseCode;
  SpinData? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  SpinData? get data => _data;

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

class SpinData {
  SpinData({
      num? spinAmount, 
      num? earnedAmount, 
      num? spinCount, 
      num? referralSpins,}){
    _spinAmount = spinAmount;
    _earnedAmount = earnedAmount;
    _spinCount = spinCount;
    _referralSpins = referralSpins;
}

  SpinData.fromJson(dynamic json) {
    _spinAmount = json['spinAmount'];
    _earnedAmount = json['earnedAmount'];
    _spinCount = json['spinCount'];
    _referralSpins = json['referralSpins'];
  }
  num? _spinAmount;
  num? _earnedAmount;
  num? _spinCount;
  num? _referralSpins;

  num? get spinAmount => _spinAmount;
  num? get earnedAmount => _earnedAmount;
  num? get spinCount => _spinCount;
  num? get referralSpins => _referralSpins;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['spinAmount'] = _spinAmount;
    map['earnedAmount'] = _earnedAmount;
    map['spinCount'] = _spinCount;
    map['referralSpins'] = _referralSpins;
    return map;
  }

}