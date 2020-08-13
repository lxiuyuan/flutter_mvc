import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'controller.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

//圆弧背景
class BackgroundPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 2);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height / 2);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BackgroundItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundPath(),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xffff5555),
          Color(0xffff4444),
        ])),
      ),
    );
  }
}

//banner模块
class BannerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ControllerBuilder(builder: (HomeChildController c) {
      return Container(
        height: 170,
        child: Stack(
          children: <Widget>[
            BackgroundItem(),
            PageView.builder(
                controller: c.pageController,
                itemCount: c.dataBanner.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      c.onBannerItemClick(index);
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            c.dataBanner[index],
                            fit: BoxFit.fill,
                          ),
                        )),
                  );
                }),
            Positioned(
                right: 15,
                bottom: 10,
                child: Stateful(
                    bind: () => [c.bannerIndex],
                    builder: (context) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: Color(0x66000000),
                            borderRadius: BorderRadius.circular(32)),
                        child: Text(
                          "${c.bannerIndex + 1}/${c.dataBanner.length}",
                          style: TextStyle(
                              inherit: false,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      );
                    }))
          ],
        ),
      );
    });
  }
}

//类目模块
class CategoryItem extends StatelessWidget {
  Widget _buildItem(String asset, String text, Function onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                asset,
                width: 42,
                height: 40,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    inherit: false, color: Color(0xff666666), fontSize: 11),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ControllerBuilder(builder: (HomeChildController c) {
      return Container(
        height: 100,
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Row(
          children: <Widget>[
            _buildItem("images/123.png", "裤子", () {
              c.onCategoryItemClick(0);
            }),
            _buildItem("images/45.png", "鞋子", () {
              c.onCategoryItemClick(1);
            }),
            _buildItem("images/wwww.png", "上衣", () {
              c.onCategoryItemClick(2);
            }),
            _buildItem("images/56.png", "背带", () {
              c.onCategoryItemClick(3);
            }),
            _buildItem("images/123.png", "裤子", () {
              c.onCategoryItemClick(4);
            }),
          ],
        ),
      );
    });
  }
}

//分类模块
class ClassifyItem extends StatelessWidget {
  List<Widget> _buildChildren(HomeChildController c) {
    List<Widget> list = [];
    for (int i = 0; i < c.dataClassify.length; i++) {
      var item = c.dataClassify[i];
      if (i != 0) {
        list.add(Container(
          height: 120,
          width: 0.5,
          color: Color(0xfff9f9f9),
        ));
      }
      list.add(Expanded(
          child: InkWell(
              onTap: () {
                c.onClassifyItemClick(i);
              },
              child: Image.network(item.url))));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ControllerBuilder(
      builder: (HomeChildController c) {
        return Container(
          height: 160,
          margin: EdgeInsets.only(left: 8, right: 8, top: 3),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.5, color: Color(0xffe4e4e4))),
          child: Row(
            children: _buildChildren(c),
          ),
        );
      },
    );
  }
}

//广告潮牌模块
class TrendItem extends StatelessWidget {
  List<Widget> _buildChildren(HomeChildController c) {
    List<Widget> list = [];
    for (int i = 0; i < c.dataTrend.length; i++) {
      var item = c.dataTrend[i];
      if (i != 0) {
        list.add(Container(
          width: 2,
        ));
      }
      list.add(Expanded(
          child: InkWell(
            onTap: (){
              c.onTrendItemClick(i);
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(item)),
          )));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ControllerBuilder(builder: (HomeChildController c) {
      return Container(
        height: 160,
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildChildren(c),
        ),
      );
    });
  }
}

//猜你喜欢筛选模块
class LikeTab extends StatelessWidget {
  Widget _buildItem(String text, bool isSelect, Function onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(
            left: 2,
            right: 2,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: !isSelect
              ? null
              : BoxDecoration(
                  color: Color(0xffff5566),
                  borderRadius: BorderRadius.circular(30)),
          child: Text(
            "$text",
            style: TextStyle(
                inherit: false,
                color: !isSelect ? Color(0xff3c3c3c) : Colors.white,
                height: 1,
                fontSize: 15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ControllerBuilder(builder: (HomeChildController c) {
      return Stateful(
          bind: () => [c.likeTabIndex],
          builder: (ctx) {
            return Container(
              margin: EdgeInsets.only(left: 6, right: 6, top: 20, bottom: 8),
              child: Row(
                children: <Widget>[
                  _buildItem("猜你喜欢", c.likeTabIndex == 0, () {
                    c.onLikeTabItemClick(0);
                  }),
                  _buildItem("猜我喜欢", c.likeTabIndex == 1, () {
                    c.onLikeTabItemClick(1);
                  }),
                  _buildItem("猜谁喜欢", c.likeTabIndex == 2, () {
                    c.onLikeTabItemClick(2);
                  }),
                ],
              ),
            );
          });
    });
  }
}

//猜你喜欢列表item
class LikeGridItem extends StatelessWidget {
  final String title;
  final String url;
  final String price;
  final String shopName;

  static double ratio = 168 / 259;

  LikeGridItem({this.title, this.url, this.price, this.shopName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: Image.network(url)),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      inherit: false, color: Color(0xff3c3c3c), fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "¥",
                      style: TextStyle(
                          color: Color(0xffff6644), fontSize: 14, height: 1),
                    ),
                    Text(
                      "${price}",
                      style: TextStyle(
                          color: Color(0xffff6644), fontSize: 18, height: 1),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${shopName}",
                      style: TextStyle(
                          color: Color(0xff999999), fontSize: 13, height: 1),
                    ),
                    Container(
                      width: 33,
                      height: 18,
                      margin: EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: Color(0xffeeeeee))),
                      child: Center(
                        child: Text(
                          "更多",
                          style: TextStyle(
                              inherit: false,
                              color: Color(0xffaaaaaa),
                              fontSize: 11,
                              height: 1.2),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Contain extends StatelessWidget with KeepAliveParentDataMixin {
  Widget child;

  Contain({this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  void detach() {}

  @override
  // TODO: implement keptAlive
  bool get keptAlive => true;
}
