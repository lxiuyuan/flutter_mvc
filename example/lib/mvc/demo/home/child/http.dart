import 'dart:convert';

import 'package:flutter_mvc_example/common/empty.dart';

import 'list_bean.dart';

class HomeHttp{
  Future<ListBean> httpList() async{
    await Future.delayed(Duration(milliseconds: 500));
    var json=JsonDecoder().convert(homeJson);
    return ListBean(json);

  }
}