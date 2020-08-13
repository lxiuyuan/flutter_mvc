import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'http.dart';
import 'list_bean.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'view.dart';
import 'dart:math' as math;
import 'package:flutter_mvc/flutter_mvc.dart';

///Description:首页列表内容
///Author:djy
///date created 2020/08/13
class HomeChildController extends BaseController {
  final String id;

  HomeChildController(this.id) : super(HomeChildPage());

  //banner数据
  var dataBanner = <String>[];

  //广告数据
  var dataTrend = <String>[];

  //猜你喜欢列表数据
  var dataLike = <ListDataLikeBean>[];

  //分类数据
  var dataClassify = <ListDataClassifyBean>[];

  //猜你喜欢tabIndex
  var likeTabIndex = 0;

  //banner的Index
  var bannerIndex = 0;

  var pageController = PageController();
  var _http = HomeHttp();

  @override
  void initState() {
    super.initState();
    httpList();
    _initListener();
  }

  void _initListener() {
    pageController.addListener(() {
      var p = pageController.page.round();
      if (bannerIndex != p) {
        bannerIndex = p;
        setState();
      }
    });
  }

  void httpList() async {
    showLoading();
    var bean = await _http.httpList();
    dismissLoading();
    dataBanner.clear();
    dataLike.clear();
    dataClassify.clear();
    dataTrend.clear();
    bannerIndex = 0;
    //200：成功状态
    if (bean.status == 200) {
      dataBanner.addAll(bean.data.banner);
      dataLike.addAll(bean.data.like);
      dataLike.addAll(bean.data.like);
      dataLike.addAll(bean.data.like);
      dataClassify.addAll(bean.data.classify);
      dataTrend.addAll(bean.data.trend);
    } else {
      print("${bean.message}");
    }

    ///由于我们变换bannerPageIndex
    ///所以setState可能会只刷新变化的Stateful(bind:=>[c.bannerPageIndex])
    setRootState(); //全局刷新(view.dart所有组件刷新)
    //setState();//刷新变换的Stateful（没有变换全局刷新）
  }

  //bannel被点击
  void onBannerItemClick(index) {
    showToast("你点击了第${index + 1}个banner");
  }

  //类目item被点击
  void onCategoryItemClick(int index) {
    String text;
    switch (index) {
      case 1:
        text = "鞋子";
        break;
      case 2:
        text = "上衣";
        break;
      case 3:
        text = "背带";
        break;
      default:
        text = "裤子";
        break;
    }

    showToast("你点击了'${text}'");
  }


  //Trend被点击
  void onTrendItemClick(int index){
    var text="";
    switch(index){
      case 0:
        text="大牌鞋靴";
        break;
      case 1:
        text="潮流男装";
        break;
      default :
        text="大牌女装";
        break;
    }

    showToast("你点击了'${text}'");

  }

  //classify被点击
  void onClassifyItemClick(int index){
    var text="";
    switch(index){
      case 1:
        text="户外运动会场";
        break;
      default :
        text="大牌女装";
        break;
    }

    showToast("你点击了'${text}'");
  }

  //likeTabItem点击事件
  void onLikeTabItemClick(int index) {
    likeTabIndex = index;
    setState();
  }



  void showToast(String message) {
    FToast(context).showToast(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: Color(0xcc000000),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            message,
            style: TextStyle(inherit: false, color: Colors.white, fontSize: 15),
          ),
        ),
        toastDuration: Duration(milliseconds: 1500),
        gravity: ToastGravity.CENTER);
  }
}
