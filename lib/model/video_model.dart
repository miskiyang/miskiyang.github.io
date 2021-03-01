/// id : 24536
/// title : "海贼王"
/// descs : "传奇海盗哥尔•D•罗杰在临死前曾留下关于其毕生的财富“One Piece”的消息，由此引得群雄并起，众海盗们为了这笔传说中的巨额财富展开争夺，各种势力、政权不断交替，整个世界进入了动荡混乱的“大海贼时代”。生长在东海某小村庄的路飞受到海贼香克斯的精神指引，决定成为一名出色的海盗。为了达成这个目标，并找到万众瞩目的One Piece，路飞踏上艰苦的旅程。一路上他遇到了无数磨难，也结识了索隆、娜美、乌索普、香吉、罗宾等一众性格各异的好友。他们携手一同展开充满传奇色彩的大冒险……本片根据日本漫画家尾田荣一郎超人气漫画原作《One Piece》改编。"
/// cover : "http://images.cnblogsc.com/pic/upload/vod/2018-01/201801291517162561.jpg"
/// author : "宇田钢之助"
/// videoType : "日韩动漫"
/// videoId : "17477"
/// updateTime : "2021-02-28 11:51:36.0"
/// creationTime : "2020-12-18T08:27:58.000+00:00"
/// videoVariableId : 1
/// 视频模型

class VideoModel {
  int _id;
  String _title;
  String _descs;
  String _cover;
  String _author;
  String _videoType;
  String _videoId;
  String _updateTime;
  String _creationTime;
  int _videoVariableId;

  int get id => _id;
  String get title => _title;
  String get descs => _descs;
  String get cover => _cover;
  String get author => _author;
  String get videoType => _videoType;
  String get videoId => _videoId;
  String get updateTime => _updateTime;
  String get creationTime => _creationTime;
  int get videoVariableId => _videoVariableId;

  VideoModel(
      {int id,
      String title,
      String descs,
      String cover,
      String author,
      String videoType,
      String videoId,
      String updateTime,
      String creationTime,
      int videoVariableId}) {
    _id = id;
    _title = title;
    _descs = descs;
    _cover = cover;
    _author = author;
    _videoType = videoType;
    _videoId = videoId;
    _updateTime = updateTime;
    _creationTime = creationTime;
    _videoVariableId = videoVariableId;
  }

  VideoModel.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _descs = json["descs"];
    _cover = json["cover"];
    _author = json["author"];
    _videoType = json["videoType"];
    _videoId = json["videoId"];
    _updateTime = json["updateTime"];
    _creationTime = json["creationTime"];
    _videoVariableId = json["videoVariableId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["descs"] = _descs;
    map["cover"] = _cover;
    map["author"] = _author;
    map["videoType"] = _videoType;
    map["videoId"] = _videoId;
    map["updateTime"] = _updateTime;
    map["creationTime"] = _creationTime;
    map["videoVariableId"] = _videoVariableId;
    return map;
  }
}
