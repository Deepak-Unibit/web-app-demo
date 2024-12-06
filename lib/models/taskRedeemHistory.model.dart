class TaskRedeemHistoryModel {
  TaskRedeemHistoryModel({
      String? status, 
      String? message, 
      num? responseCode, 
      List<TaskRedeemHistoryData>? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  TaskRedeemHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskRedeemHistoryData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  num? _responseCode;
  List<TaskRedeemHistoryData>? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  List<TaskRedeemHistoryData>? get data => _data;

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

class TaskRedeemHistoryData {
  TaskRedeemHistoryData({
      String? id, 
      num? method, 
      num? diamonds, 
      String? createdAt, 
      String? task,}){
    _id = id;
    _method = method;
    _diamonds = diamonds;
    _createdAt = createdAt;
    _task = task;
}

  TaskRedeemHistoryData.fromJson(dynamic json) {
    _id = json['_id'];
    _method = json['method'];
    _diamonds = json['diamonds'];
    _createdAt = json['createdAt'];
    _task = json['task'];
  }
  String? _id;
  num? _method;
  num? _diamonds;
  String? _createdAt;
  String? _task;

  String? get id => _id;
  num? get method => _method;
  num? get diamonds => _diamonds;
  String? get createdAt => _createdAt;
  String? get task => _task;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['method'] = _method;
    map['diamonds'] = _diamonds;
    map['createdAt'] = _createdAt;
    map['task'] = _task;
    return map;
  }

}