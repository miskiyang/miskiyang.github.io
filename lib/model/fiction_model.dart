/// id : 6687
/// title : "全职高手之站在世界荣耀的巅峰"
/// descs : "莫名其妙地来到了全职高手的世界。 莫名其妙的得到了一个游戏系统。 站在荣耀的巅峰从打造百变枪开始。 主角与叶修的一场比赛一战封神。 被誉为与叶修其名的斗圣。 叶修:有没有兴趣和我一起站在荣耀的巅峰。 主角:除非我当队长。 叶修:单挑，谁赢谁当队长。 主角:乐于奉陪。"
/// cover : "http://www.xbiquge.la/files/article/image/43/43865/43865s.jpg"
/// author : "对夜听风"
/// fictionType : "网游小说"
/// fictionId : "143865"
/// updateTime : "2020-08-12 12:46:16.0"
/// creationTime : "2020-12-18T11:34:17.000+00:00"
/// fictionVariableId : 1
/// 小说模型

class FictionModel {
  int _id;
  String _title;
  String _descs;
  String _cover;
  String _author;
  String _fictionType;
  String _fictionId;
  String _updateTime;
  String _creationTime;
  int _fictionVariableId;

  int get id => _id;

  String get title => _title;

  String get descs => _descs;

  String get cover => _cover;

  String get author => _author;

  String get fictionType => _fictionType;

  String get fictionId => _fictionId;

  String get updateTime => _updateTime;

  String get creationTime => _creationTime;

  int get fictionVariableId => _fictionVariableId;

  FictionModel(
      {int id,
      String title,
      String descs,
      String cover,
      String author,
      String fictionType,
      String fictionId,
      String updateTime,
      String creationTime,
      int fictionVariableId}) {
    _id = id;
    _title = title;
    _descs = descs;
    _cover = cover;
    _author = author;
    _fictionType = fictionType;
    _fictionId = fictionId;
    _updateTime = updateTime;
    _creationTime = creationTime;
    _fictionVariableId = fictionVariableId;
  }

  FictionModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _title = json["title"];
    _descs = json["descs"];
    _cover = json["cover"];
    _author = json["author"];
    _fictionType = json["fictionType"];
    _fictionId = json["fictionId"];
    _updateTime = json["updateTime"];
    _creationTime = json["creationTime"];
    _fictionVariableId = json["fictionVariableId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["descs"] = _descs;
    map["cover"] = _cover;
    map["author"] = _author;
    map["fictionType"] = _fictionType;
    map["fictionId"] = _fictionId;
    map["updateTime"] = _updateTime;
    map["creationTime"] = _creationTime;
    map["fictionVariableId"] = _fictionVariableId;
    return map;
  }

  @override
  String toString() {
    return 'StoryBookModel{_id: $_id, _title: $_title, _descs: $_descs, _cover: $_cover,'
        ' _author: $_author, _fictionType: $_fictionType, _fictionId: $_fictionId, _updateTime: '
        '$_updateTime, _creationTime: $_creationTime, _fictionVariableId: $_fictionVariableId}';
  }
}
