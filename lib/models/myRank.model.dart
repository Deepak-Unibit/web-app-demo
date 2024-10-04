class MyRankModel {
  MyRankModel({
      String? status, 
      String? message, 
      num? responseCode, 
      MyRankData? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  MyRankModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'] != null ? MyRankData.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  num? _responseCode;
  MyRankData? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  MyRankData? get data => _data;

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

class MyRankData {
  MyRankData({
      num? myRank, 
      num? myReferral,}){
    _myRank = myRank;
    _myReferral = myReferral;
}

  MyRankData.fromJson(dynamic json) {
    _myRank = json['myRank'];
    _myReferral = json['myReferral'];
  }
  num? _myRank;
  num? _myReferral;

  num? get myRank => _myRank;
  num? get myReferral => _myReferral;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['myRank'] = _myRank;
    map['myReferral'] = _myReferral;
    return map;
  }

}