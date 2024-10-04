class InvitationModel {
  InvitationModel({
      String? status, 
      String? message, 
      num? responseCode, 
      List<InvitationData>? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  InvitationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(InvitationData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  num? _responseCode;
  List<InvitationData>? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  List<InvitationData>? get data => _data;

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

class InvitationData {
  InvitationData({
      String? id, 
      String? firstName,}){
    _id = id;
    _firstName = firstName;
}

  InvitationData.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
  }
  String? _id;
  String? _firstName;

  String? get id => _id;
  String? get firstName => _firstName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    return map;
  }

}