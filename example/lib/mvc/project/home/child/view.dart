import 'package:flutter/cupertino.dart';
import 'widget.dart';

import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

///description:首页列表内容
class HomeChildPage extends BasePage<HomeChildController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
//          Positioned( left:0,right: 0,top: 0,height: 50,child: BackgroundItem(),),
          Positioned(
            left: 0,right: 0,top: 0,bottom: 0,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Contain(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        BannerItem(),
                        CategoryItem(),
                        TrendItem(),
                        ClassifyItem(),
                        LikeTab()
                      ],
                    ),
                  ),
                ),

                //列表
                SliverPadding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: LikeGridItem.ratio),
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      var item = c.dataLike[index];
                      return LikeGridItem(
                        title: item.title,
                        url: item.url,
                        price: item.price,
                        shopName: item.shop,
                      );
                    }, childCount: c.dataLike.length),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
