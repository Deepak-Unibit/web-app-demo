class DailyRewardsModel {
  DailyRewardsModel({
    String? status,
    String? message,
    num? responseCode,
    DailyRewardsData? data,
  }) {
    _status = status;
    _message = message;
    _responseCode = responseCode;
    _data = data;
  }

  DailyRewardsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responseCode = json['responseCode'];
    _data = json['data'] != null ? DailyRewardsData.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  num? _responseCode;
  DailyRewardsData? _data;

  String? get status => _status;
  String? get message => _message;
  num? get responseCode => _responseCode;
  DailyRewardsData? get data => _data;

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

class DailyRewardsData {
  DailyRewardsData({
    DailyReward? dailyReward,
    num? dailyRewardDay,
  }) {
    _dailyReward = dailyReward;
    _dailyRewardDay = dailyRewardDay;
  }

  DailyRewardsData.fromJson(dynamic json) {
    _dailyReward = json['dailyReward'] != null ? DailyReward.fromJson(json['dailyReward']) : null;
    _dailyRewardDay = json['dailyRewardDay'];
  }
  DailyReward? _dailyReward;
  num? _dailyRewardDay;

  DailyReward? get dailyReward => _dailyReward;
  num? get dailyRewardDay => _dailyRewardDay;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dailyReward != null) {
      map['dailyReward'] = _dailyReward?.toJson();
    }
    map['dailyRewardDay'] = _dailyRewardDay;
    return map;
  }
}

class DailyReward {
  DailyReward({
    num? day1,
    num? day2,
    num? day3,
    num? day4,
    num? day5,
    num? day6,
    num? day7,
  }) {
    _day1 = day1;
    _day2 = day2;
    _day3 = day3;
    _day4 = day4;
    _day5 = day5;
    _day6 = day6;
    _day7 = day7;
  }

  DailyReward.fromJson(dynamic json) {
    _day1 = json['Day1'];
    _day2 = json['Day2'];
    _day3 = json['Day3'];
    _day4 = json['Day4'];
    _day5 = json['Day5'];
    _day6 = json['Day6'];
    _day7 = json['Day7'];
  }
  num? _day1;
  num? _day2;
  num? _day3;
  num? _day4;
  num? _day5;
  num? _day6;
  num? _day7;

  num? get day1 => _day1;
  num? get day2 => _day2;
  num? get day3 => _day3;
  num? get day4 => _day4;
  num? get day5 => _day5;
  num? get day6 => _day6;
  num? get day7 => _day7;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Day1'] = _day1;
    map['Day2'] = _day2;
    map['Day3'] = _day3;
    map['Day4'] = _day4;
    map['Day5'] = _day5;
    map['Day6'] = _day6;
    map['Day7'] = _day7;
    return map;
  }
}
