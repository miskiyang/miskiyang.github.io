import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:novel_cartoon_video/model/http/BaseResponse.dart';
import 'package:novel_cartoon_video/model/http/ResultDto.dart';

const remoteServerUrl = "http://api.pingcc.cn";

/// 数据资源中心的基类
class Repository {
  /// 从远端拉取数据
  Future<BaseResponse<T>> fetchDataFromRemote<T>(String method) async {
    var httpClient = HttpClient();
    var uri = Uri.parse(remoteServerUrl + method);
    var httpRequest = await httpClient.getUrl(uri);
    var httpResponse = await httpRequest.close();
    var statusCode = httpResponse.statusCode;
    if (statusCode == 200) {
      var resultBody = await httpResponse.transform(Utf8Decoder()).join();
      try {
        log('result======>' + resultBody);
        return BaseResponse.fromJson(json.decode(resultBody));
      } catch (e) {
        throw HttpException("数据解析失败");
      }
    } else {
      throw HttpException("加载数据失败");
    }
  }

  /// 处理结果
  ResultDto<T> handleResult<T>(BaseResponse<T> result, int from, int count) {
    if (result.code == 0) {
      return ResultDto.success(result.code, result.msg,
          result.data.data == null ? [] : result.data.data,
          from: from, count: count);
    } else {
      return ResultDto.failure(result.code, result.msg,
          from: from, count: count);
    }
  }

  /// 处理异常
  ResultDto<T> handleError<T>(e, int from, int count) =>
      ResultDto<T>.failure(-1, e.message, from: from, count: count);
}
