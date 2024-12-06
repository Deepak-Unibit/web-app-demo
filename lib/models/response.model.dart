class ResponseModel {
  ResponseModel({
    String? status,
    String? message,
    num? responseCode,
    dynamic data,
  }) {
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
  }

  ResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'];
  }
  String? _status;
  String? _message;
  num? _responseCode;
  dynamic _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['responseCode'] = _responseCode;
    map['data'] = _data;
    return map;
  }
}
