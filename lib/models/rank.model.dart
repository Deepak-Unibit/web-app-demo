class RankModel {
  RankModel({
      String? status, 
      String? message, 
      num? responseCode, 
      List<RankData>? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  RankModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RankData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  num? _responseCode;
  List<RankData>? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  List<RankData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['responseCode'] = _responseCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RankData {
  RankData({
      String? id, 
      String? telegramId, 
      String? firstName, 
      num? referralCount,}){
    _id = id;
    _telegramId = telegramId;
    _firstName = firstName;
    _referralCount = referralCount;
}

  RankData.fromJson(dynamic json) {
    _id = json['_id'];
    _telegramId = json['telegramId'];
    _firstName = json['firstName'];
    _referralCount = json['referralCount'];
  }
  String? _id;
  String? _telegramId;
  String? _firstName;
  num? _referralCount;

  String? get id => _id;
  String? get telegramId => _telegramId;
  String? get firstName => _firstName;
  num? get referralCount => _referralCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['telegramId'] = _telegramId;
    map['firstName'] = _firstName;
    map['referralCount'] = _referralCount;
    return map;
  }

}