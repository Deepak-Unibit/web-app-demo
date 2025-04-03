class VerifySubscriptionModel {
  VerifySubscriptionModel({
    String? status,
    String? message,
    num? responseCode,
    VerifySubscriptionData? data,
  }) {
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
  }

  VerifySubscriptionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'] != null ? VerifySubscriptionData.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  num? _responseCode;
  VerifySubscriptionData? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  VerifySubscriptionData? get data => _data;

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

class VerifySubscriptionData {
  VerifySubscriptionData({
    bool? joinedChannel1,
    bool? joinedChannel2,
    bool? joinedChannel3,
  }) {
    _joinedChannel1 = joinedChannel1;
    _joinedChannel2 = joinedChannel2;
    _joinedChannel3 = joinedChannel3;
  }

  VerifySubscriptionData.fromJson(dynamic json) {
    _joinedChannel1 = json['joinedChannel1'];
    _joinedChannel2 = json['joinedChannel2'];
    _joinedChannel3 = json['joinedChannel3'];
  }
  bool? _joinedChannel1;
  bool? _joinedChannel2;
  bool? _joinedChannel3;

  bool? get joinedChannel1 => _joinedChannel1;
  bool? get joinedChannel2 => _joinedChannel2;
  bool? get joinedChannel3 => _joinedChannel3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['joinedChannel1'] = _joinedChannel1;
    map['joinedChannel2'] = _joinedChannel2;
    map['joinedChannel3'] = _joinedChannel3;
    return map;
  }
}
