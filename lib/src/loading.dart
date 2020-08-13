import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  @required
  LoadingController controller;
  @required
  Widget child;

  LoadingDialog({@required this.controller,@required this.child});

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with SingleTickerProviderStateMixin {
  LoadingController controller;

  @override
  void initState() {
    controller = widget.controller;
    controller._registerState(this);
    controller.animController = new AnimationController(
        duration: Duration(milliseconds: 400), value: 0, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
//    controller._animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.animValue > 0,
      child: Opacity(
          opacity: controller.animValue,
          child: Transform.scale(
            scale: controller.animValue,
            child: Loading(child: widget.child,),
          )),
    );
  }
}

class LoadingController {
  AnimationController _animController;

  set animController(AnimationController controller) {
    _animController = controller;
    _initListener();
  }

  double animValue = 0;
  bool isLoading = false;

  void _initListener() {
    _animController.addListener(() {
      animValue = _animController.value;
      setState();
    });
  }

  State _state;

  void _registerState(State state) {
    this._state = state;
  }

  ///setstate
  void setState() {
    try {
      if (_state?.mounted) {
        _state?.setState(() {});
      }
    } catch (e) {
      print(e);
      Future.delayed(Duration(milliseconds: 50), () {
        setState();
      });
    }
  }


  void showLoading() {
    if (isLoading) {
      return;
    }
    isLoading = true;
    if(_animController!=null) {
      _animController.forward(from: animValue);
    }else{
      animValue=1.0;
    }
  }

  void dismissLoading() {
    if (!isLoading) {
      return;
    }
    isLoading = false;
    if(_animController!=null) {
      _animController.reverse(from: animValue);
    }else{
      animValue=0.0;
    }
  }
}

///视图
class Loading extends StatelessWidget {
  final String text;
  final Widget child;

  Loading({this.text,this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            color: Color(0x01ffffff),
            child:child));
  }
}
