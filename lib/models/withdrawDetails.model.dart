class WithdrawDetailsModel {
  WithdrawDetailsModel({
      String? status, 
      String? message, 
      num? responseCode, 
      WithdrawDetailsData? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  WithdrawDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'] != null ? WithdrawDetailsData.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  num? _responseCode;
  WithdrawDetailsData? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  WithdrawDetailsData? get data => _data;

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

class WithdrawDetailsData {
  WithdrawDetailsData({
      num? successWithDrawl, 
      num? underReview,}){
    _successWithDrawl = successWithDrawl;
    _underReview = underReview;
}

  WithdrawDetailsData.fromJson(dynamic json) {
    _successWithDrawl = json['successWithDrawl'];
    _underReview = json['underReview'];
  }
  num? _successWithDrawl;
  num? _underReview;

  num? get successWithDrawl => _successWithDrawl;
  num? get underReview => _underReview;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['successWithDrawl'] = _successWithDrawl;
    map['underReview'] = _underReview;
    return map;
  }

}