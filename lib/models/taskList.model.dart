class TaskListModel {
  TaskListModel({
      String? status, 
      String? message, 
      num? responseCode, 
      List<TaskListData>? data,}){
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
}

  TaskListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskListData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  num? _responseCode;
  List<TaskListData>? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  List<TaskListData>? get data => _data;

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

class TaskListData {
  TaskListData({
      String? id, 
      String? title, 
      String? icon, 
      num? diamonds, 
      String? destinationLink, 
      num? type, 
      num? status, 
      num? claimDuration, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _title = title;
    _icon = icon;
    _diamonds = diamonds;
    _destinationLink = destinationLink;
    _type = type;
    _status = status;
    _claimDuration = claimDuration;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  TaskListData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _icon = json['icon'];
    _diamonds = json['diamonds'];
    _destinationLink = json['destinationLink'];
    _type = json['type'];
    _status = json['status'];
    _claimDuration = json['claimDuration'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _title;
  String? _icon;
  num? _diamonds;
  String? _destinationLink;
  num? _type;
  num? _status;
  num? _claimDuration;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get title => _title;
  String? get icon => _icon;
  num? get diamonds => _diamonds;
  String? get destinationLink => _destinationLink;
  num? get type => _type;
  num? get status => _status;
  num? get claimDuration => _claimDuration;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['icon'] = _icon;
    map['diamonds'] = _diamonds;
    map['destinationLink'] = _destinationLink;
    map['type'] = _type;
    map['status'] = _status;
    map['claimDuration'] = _claimDuration;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}