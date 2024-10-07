class CashOutModel {
  CashOutModel({
      String? status, 
      String? message, 
      num? responseCode, 
      Data? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  CashOutModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  num? _responseCode;
  Data? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  Data? get data => _data;

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

class Data {
  Data({
      num? earnedAmount,}){
    _earnedAmount = earnedAmount;
}

  Data.fromJson(dynamic json) {
    _earnedAmount = json['earnedAmount'];
  }
  num? _earnedAmount;

  num? get earnedAmount => _earnedAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['earnedAmount'] = _earnedAmount;
    return map;
  }

}