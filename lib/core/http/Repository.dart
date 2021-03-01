import 'dart:convert';
import 'dart:io';

import 'package:personal_website/model/http/BaseResponse.dart';

const remoteServerUrl = "http://api.pingcc.cn";

/// 数据资源中心的基类
class Repository {
  ///从远端拉取数据
  Future<BaseResponse<T>> fetchDataFromRemote<T>(String method) async {
    var httpClient = HttpClient();
    var uri = Uri.parse(remoteServerUrl + method);
    var httpRequest = await httpClient.getUrl(uri);
    var httpResponse = await httpRequest.close();
    var statusCode = httpResponse.statusCode;
    if (statusCode == 200) {
      var resultBody = await httpResponse.transform(Utf8Decoder()).join();
      try {
        return BaseResponse.fromJson(json.decode(resultBody));
      } catch (e) {
        print('e======>$e');
        throw HttpException("数据解析失败");
      }
    } else {
      throw HttpException("加载数据失败");
    }
  }
}
