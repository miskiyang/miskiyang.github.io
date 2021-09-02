import 'package:novel_cartoon_video/model/http/JsonParseAdapter.dart';

class BaseResponse<T> {
  int _code;
  String _msg;
  Response<T> _data;

  int get code => _code;

  String get msg => _msg;

  Response<T> get data => _data;

  BaseResponse({int code, String msg, Response<T> data}) {
    this._code = code;
    this._msg = msg;
    this._data = data;
  }

  BaseResponse.fromJson(Map<String, dynamic> json) {
    _code = json["code"];
    _msg = json["msg"];
    var jsonData = json["data"];
    if (null != jsonData) {
      _data = Response.fromJson(json["data"]);
    } else {
      _data = null;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["msg"] = _msg;
    map["data"] = _data;
    return map;
  }

  @override
  String toString() {
    return 'BaseResponse{_code: $_code, _msg: $_msg, _data: $_data}';
  }
}

class Response<T> {
  int _size;
  T _data;
  int _count;
  int _from;

  int get size => _size;

  T get data => _data;

  int get count => _count;

  int get from => _from;

  Response({int size, T data, int count, int from}) {
    this._size = size;
    this._data = data;
    this._count = count;
    this._from = from;
  }

  Response.fromJson(dynamic json) {
    _size = json["size"];
    var jsonData = json["data"];
    if (null != jsonData) {
      _data = JsonParseAdapter().convertJsonToT(json["data"]);
    } else {
      _data = null;
    }
    _count = json["count"];
    _from = json["from"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["size"] = _size;
    map["data"] = _data;
    map["count"] = _count;
    map["from"] = _from;
    return map;
  }

  @override
  String toString() {
    return 'Response{_size: $_size, _data: $_data, _count: $_count, _from: $_from}';
  }
}
