class WithdrawRequestModel {
  WithdrawRequestModel({
      String? status, 
      String? message, 
      num? responseCode, 
      List<WithdrawRequestData>? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  WithdrawRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WithdrawRequestData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  num? _responseCode;
  List<WithdrawRequestData>? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  List<WithdrawRequestData>? get data => _data;

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

class WithdrawRequestData {
  WithdrawRequestData({
      String? id, 
      String? userId, 
      num? status, 
      num? amount, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _status = status;
    _amount = amount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  WithdrawRequestData.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _status = json['status'];
    _amount = json['amount'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _userId;
  num? _status;
  num? _amount;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get userId => _userId;
  num? get status => _status;
  num? get amount => _amount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['status'] = _status;
    map['amount'] = _amount;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}