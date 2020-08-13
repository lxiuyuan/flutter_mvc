import 'package:flutter/material.dart';
import 'controller.dart';
export 'controller.dart';

class TabItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  TabItem({this.padding, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: child,
    );
  }
}

class TabScrollWidget extends StatefulWidget {
  final Widget lineWidget;
  final TabScrollController controller;
  final TabItem Function(BuildContext, int index, bool isSelect) builder;
  final EdgeInsets padding;
  final int length;

  TabScrollWidget(
      {@required this.builder,
      @required this.controller,
      this.length = 5,
      this.padding,
      this.lineWidget});

  @override
  _TabScrollWidgetState createState() => _TabScrollWidgetState();
}

class _TabScrollWidgetState extends State<TabScrollWidget>
    with SingleTickerProviderStateMixin {
  TabScrollController c;

  @override
  void initState() {
    c = widget.controller;
    c.animationController = AnimationController(vsync: this);
    c.initLeft = widget.padding?.left ?? 0;

    widget.controller.registerState(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      c.addPostFrameCallback();
    });
    super.initState();
  }
  @override
  void didUpdateWidget(TabScrollWidget oldWidget){
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      c.refreshCallBack();
    });
    if(oldWidget.length!=widget.length){
      c.refresh=true;
      setState(() {

      });
      return;
    }
  }



  List<Widget> _buildWidget() {
    var list = <Widget>[];

    for (int i = 0; i < widget.length; i++) {
      var isSelect = c.index == i;
      var child = widget.builder(context, i, isSelect);
      //计算默认position
      if (i == 0) {
        if (c.position == 0) {
          c.position = child.padding?.left + c.initLeft;
        }
      }
      //循环padding
      var paddingLeft=child.padding?.left ?? 0.0;
      var paddingRight=child.padding?.right ?? 0.0;
      if(c.childrenPadding.length>i+1){
        CPadding padding=c.childrenPadding[i];
        if(padding.left!=paddingLeft||paddingRight!=paddingRight){
          c.refresh=true;
        }
        padding.left=paddingLeft;
        padding.right=paddingRight;
      }else {
        //添加CPaddng
        c.childrenPadding.add(CPadding(
            left: paddingLeft,
            right: paddingRight));
      }
      //padding-end;

      list.add(Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              c.onItemClick(i);
            },
            child: child),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: c.scrollController,
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Container(
              padding: widget.padding,
              child: Row(
                key: c.globalKey,
                children: _buildWidget(),
              ),
            )),
            Visibility(
              visible: true,
              child: Transform.translate(
                offset: Offset(c.position, 0),
                child: Container(key: c.lineKey, width:c.lineWidth,child: widget.lineWidget),
              ),
            )
          ],
        ),
      ),
    );
  }
}
