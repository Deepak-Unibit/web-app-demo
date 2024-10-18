class RewardsModel {
  RewardsModel({
      String? status, 
      String? message, 
      num? responseCode, 
      Data? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  RewardsModel.fromJson(dynamic json) {
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
      num? referralCountForCash, 
      num? earnedReferralCash, 
      num? cashClaimedCount, 
      List<ReferralSystemData>? referralSystem,}){
    _referralCountForCash = referralCountForCash;
    _earnedReferralCash = earnedReferralCash;
    _cashClaimedCount = cashClaimedCount;
    _referralSystem = referralSystem;
}

  Data.fromJson(dynamic json) {
    _referralCountForCash = json['referralCountForCash'];
    _earnedReferralCash = json['earnedReferralCash'];
    _cashClaimedCount = json['cashClaimedCount'];
    if (json['referralSystem'] != null) {
      _referralSystem = [];
      json['referralSystem'].forEach((v) {
        _referralSystem?.add(ReferralSystemData.fromJson(v));
      });
    }
  }
  num? _referralCountForCash;
  num? _earnedReferralCash;
  num? _cashClaimedCount;
  List<ReferralSystemData>? _referralSystem;

  num? get referralCountForCash => _referralCountForCash;
  num? get earnedReferralCash => _earnedReferralCash;
  num? get cashClaimedCount => _cashClaimedCount;
  List<ReferralSystemData>? get referralSystem => _referralSystem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referralCountForCash'] = _referralCountForCash;
    map['earnedReferralCash'] = _earnedReferralCash;
    map['cashClaimedCount'] = _cashClaimedCount;
    if (_referralSystem != null) {
      map['referralSystem'] = _referralSystem?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ReferralSystemData {
  ReferralSystemData({
      num? referralCount, 
      num? referralReward,}){
    _referralCount = referralCount;
    _referralReward = referralReward;
}

  ReferralSystemData.fromJson(dynamic json) {
    _referralCount = json['referralCount'];
    _referralReward = json['referralReward'];
  }
  num? _referralCount;
  num? _referralReward;

  num? get referralCount => _referralCount;
  num? get referralReward => _referralReward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referralCount'] = _referralCount;
    map['referralReward'] = _referralReward;
    return map;
  }

}