import 'package:flutter/material.dart';
import 'package:flutter_mvc_example/common/widget/statebar.dart';

class WhiteAppBar extends StatelessWidget {
  final String title;
  final bool visibleLeftButton;

  WhiteAppBar(this.title, {this.visibleLeftButton = true});

  @override
  Widget build(BuildContext context) {
    return SystemStateBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Container(
                height: 50,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            inherit: false, color: Color(0xff3c3c3c), fontSize: 18),
                      ),
                    ),
                    Visibility(
                        visible: visibleLeftButton,
                        child: Material(
                          color: Colors.white,
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 19,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,color: Color(0xfff5f5f5),)
        ],
      ),
    );
  }
}
