import 'package:flutter/material.dart';
import 'page.dart';
///用controller实例化
class AnimationMvcController extends AnimationController{
  AnimationMvcController({
    double value,
    Duration duration,
    Duration reverseDuration,
    String debugLabel,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    @required BaseController controller
  }):super(
      value: value,
      duration: duration,
      reverseDuration: reverseDuration,
      debugLabel: debugLabel,
      lowerBound: lowerBound,
      upperBound: upperBound,
      vsync:BaseController.getMvcAttribute(controller).state);
}