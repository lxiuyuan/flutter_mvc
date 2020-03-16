import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
class HttpUtils {
  static Dio _http = Dio();

  //json转换框架
  static JsonDecoder _mJsonDecoder = JsonDecoder();
  static Map<String, String> _errorJson = {};

  static void setErrorJson(Map<String, dynamic> json) {
    _errorJson = json;
  }

  static void _initProxy(String proxy) {
    if (proxy == null || proxy.trim() == "") {
      return;
    }
    (_http.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return "PROXY $proxy";
      };
    };
  }

  static Options _createOptions(
      HttpOption ho) {
    var options = Options(
        headers: ho.header,
        sendTimeout: ho.timeOut,

        contentType: ho.contentType,

        receiveTimeout: ho.timeOut);
    return options;
  }

  static Future<Map<String, dynamic>> get(String url, Map<String, String> para,
      {HttpOption ho,String proxy}) async {
    _initProxy(proxy);
    Response<String> response = await _http.get(url,
        queryParameters: para, options: _createOptions(ho));
    return _convertResponse(response);
  }

  static Future<Map<String, dynamic>> post(String url, Map<String, String> para,
      {HttpOption ho, String proxy}) async {
    _initProxy(proxy);
    Response<String> response =
        await _http.post(url,data: FormData.fromMap(para), options: _createOptions(ho));
    return _convertResponse(response);
  }

  static Future<Map<String, dynamic>> httpUploadImage(
      String url, String key, File file,
      {Map<String, String> para,HttpOption ho, String proxy}) async {
    String path = file.path;
    String name = path.substring(path.lastIndexOf("/") + 1, path.length);
    String suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    if (suffix == "" || suffix == null) {
      suffix = "jpeg";
    }

    ///添加参数
    var map = Map<String, dynamic>();
    if (para == null) {
      para={"":""};
    }
    map.addAll(para);

    var mf=await MultipartFile.fromFile(path,filename: name);
//    contentType:MediaType.parse("image/$suffix"
    map[key] = mf;
    FormData data = FormData.fromMap(map);
    Response<String> response = await _http.post( url,data: data,options:_createOptions(ho));
    return _convertResponse(response);
  }

  static Future<Map<String, dynamic>> httpUploadImage64(
      String url, String key, File file,
      {Map<String, String> para,HttpOption ho, String proxy}) async {
    _initProxy(proxy);
    String path = file.path;
    String name = path.substring(path.lastIndexOf("/") + 1, path.length);
    String suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    if (suffix == "" || suffix == null) {
      suffix = "jpeg";
    }
    List<int> bytes=await file.readAsBytes();
    var base64=base64Encode(bytes);
    ///添加参数
    var map = Map<String, dynamic>();
    if (para != null) {
      map.addAll(para);
    }
    map[key] = base64;

    FormData data = FormData.fromMap(map);
    Response<String> response = await _http.post(url, data: data,options:_createOptions(ho) );
    return _convertResponse(response);
  }

  static Map<String, dynamic> _convertResponse(Response<String> response) {
    //如果成功正常转换json
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> map =
          _mJsonDecoder.convert(response.data.toString());
      return map;
    }
    //否则返回错误json

    return _errorJson;
  }
}

class HttpOption{
  final Map<String,dynamic> header;
  final int timeOut;
  final String contentType;
  HttpOption({this.header,this.timeOut,this.contentType});
}
