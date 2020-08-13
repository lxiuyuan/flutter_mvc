import 'package:flutter/material.dart';
//默认line宽度
const double defalutLineWidth=24;

class TabScrollController{
  GlobalKey globalKey=new GlobalKey();
  ScrollController scrollController=new ScrollController();
  State _state;
  bool visibleLine=false;
  double _position=0;
  double initLeft=0;
  //控件宽度
  double childrenWidth=0.0;
  //是否重新计算缓存
  bool refresh=false;
  void set position(value){
    _position=value;
  }
  double get position{
    if(_position<0){
      return 0;
    }
    return _position;
  }

  int index=0;
  //控件宽度
  double _width=0.0;
  List<Data> _datas=[];
  List<CPadding> childrenPadding=[];
  double _lineWidth=defalutLineWidth;
  double get lineWidth=>_lineWidth;
  AnimationController animationController;
  Tween<double> _positionTween;

  GlobalKey lineKey= GlobalKey();
  void registerState(State state){
    _state=state;
    _initAnimationListener();
  }

  void _setState(){
    _state.setState(() {});
  }

  void _setLineState(){
    lineKey.currentState.setState(() { });
  }

  var _duration=Duration(milliseconds: 400);
  var _curve=Curves.fastOutSlowIn;

  void onItemClick(int index){
    setIndex(index);
  }

  PageController _pageController;

  var _oldPage=0.0;
  var _isLeftScroll=false;
  void combinationWithPage(PageController pageController) {
    _pageController=pageController;
      pageController.addListener(() {
        var page=pageController.page;
        _isLeftScroll=_oldPage>page;
        _oldPage=page;
        this._position=_getPositionByPage(page);
        this._lineWidth=_getLineWidthByPage(page);
        syncScroll();
        _setState();
      });
  }
//10
  //14
  void syncScroll(){
    var index=_pageController.page.toInt();
    var value=_pageController.page-index;
    if(value>=0.5){
      index++;
    }
    if(index==this.index){
      return;
    }
    this.index=index;
    double getScrollEnd(){
      if(_isLeftScroll){
        if(index==0){
          return 0;
        }else{
         var rect= _datas[index-1].rect;
         var left=rect.left-(rect.width-_lineWidth)/2;
          return left<0?0:left;
        }
      }else{
        Rect rect;
        if(index==_datas.length-1){
          rect=_datas[index].rect;
        }else{
          rect=_datas[index+1].rect;
        }
        var left=rect.left-(rect.width-_lineWidth)/2;
        return left+rect.width;
      }
    }

    var scroll=scrollController.offset;
    if(scroll<0){
      scroll=0;
    }
    var scrollPosition=_width+scroll;
    var positionRight=getScrollEnd();
    var positionLeft=positionRight;
    if(positionRight>scrollPosition&&!_isLeftScroll){
      var scroll=positionRight-_width;
      scrollController.animateTo(scroll, duration: Duration(milliseconds: 400), curve: Curves.linearToEaseOut);
    }else if(positionLeft<0){

    }else if(positionLeft<scroll&&_isLeftScroll){
      scrollController.animateTo(positionLeft, duration: Duration(milliseconds: 400), curve: Curves.linearToEaseOut);

    }


  }

  //初始化计算宽度还有位置
  void addPostFrameCallback({bool isRefresh=false}) {
    refresh=false;
    childrenWidth=globalKey.currentContext.size.width;
    _lineWidth=lineKey.currentContext.size.width;
    _datas.clear();
    double left=initLeft;
    int i=0;
    globalKey.currentContext.visitChildElements((element) {
      var data=Data();
      var padding=childrenPadding[i];
      var width=element.size.width;
      var height=element.size.height;
      //字体宽度
      data.fontWidth=width-padding.horizontal;
      var position=left+(width-data.fontWidth)/2;

      data.rect=Rect.fromLTWH(position, 0, width, height);
      _datas.add(data);
      left+=width;
      i++;
    });
    //判断是否是刷新
    if(isRefresh){
      _position=_getPositionByPage(index.toDouble());
      _lineWidth=_getLineWidthByPage(index.toDouble());
    }
    _width=_state.context.size.width;
    visibleLine=true;
    _setState();


  }

  void setIndex(int index){
    if(_pageController!=null){
      _pageController.animateToPage(index, duration: _duration, curve: _curve);
    }else {
      this.index = index;
      _animPosition();
    }
  }
  double _getLineWidthByPage(double page){
    var index=page.toInt();
    var value=page-index;
    var width=_datas[index].fontWidth;
    if(index>=_datas.length-1){
      return width;
    }else{
      var nextWidth=_datas[index+1].fontWidth;
      var cut=(nextWidth-width)*value;
      return width+cut;
    }
  }

  double _getPositionByPage(double page){
    var index=page.toInt();
    var value=page-index;
    var left=_datas[index].rect.left;
    if(index>=_datas.length-1){
      return left;
    }else{
      var nextLeft=_datas[index+1].rect.left;
      var cut=(nextLeft-left)*value;
      return left+cut;
    }
  }

  void _animPosition(){
    var endPosition=_datas[index].rect.left;
    _positionTween=Tween(begin: _position,end: endPosition);
    animationController.reset();
    animationController.animateTo(1.0,duration:_duration,curve: _curve);
  }

  void _initAnimationListener(){
    animationController.addListener(() {
      if(_positionTween!=null){
        _position=_positionTween.lerp(animationController.value);
        print("position:${_position}");
        _setState();
      }
    });
  }

  void refreshCallBack() {
    if(refresh){
      addPostFrameCallback(isRefresh: true);
      return;
    }
    var width=globalKey.currentContext.size.width;
    if(this.childrenWidth!=width){
      addPostFrameCallback(isRefresh: true);
    }
  }




}

class CPadding{
  double left;
  double right;
  double get horizontal=>left+right;
  CPadding({this.left,this.right});
}

class Data{
  Rect rect;
  double fontWidth;
}