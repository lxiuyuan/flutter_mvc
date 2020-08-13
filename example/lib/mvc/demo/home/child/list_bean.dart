class ListBean {
  int status;
  String message;
  ListDataBean data;

  Map<String, dynamic> toJson() => jsonFromHomeListBean(this);

  ListBean(Map<String, dynamic> json) {
    jsonToHomeListBean(json, this);
  }
}

class ListDataBean {
  List<String> banner;
  List<ListDataClassifyBean> classify;
  List<String> trend;
  List<ListDataLikeBean> like;

  Map<String, dynamic> toJson() => jsonFromHomeListDataBean(this);

  ListDataBean(Map<String, dynamic> json) {
    jsonToHomeListDataBean(json, this);
  }
}

class ListDataClassifyBean {
  String name;
  String url;

  Map<String, dynamic> toJson() => jsonFromHomeListDataClassifyBean(this);

  ListDataClassifyBean(Map<String, dynamic> json) {
    jsonToHomeListDataClassifyBean(json, this);
  }
}

class ListDataLikeBean {
  String title;
  String url;
  String price;
  String shop;

  Map<String, dynamic> toJson() => jsonFromHomeListDataLikeBean(this);

  ListDataLikeBean(Map<String, dynamic> json) {
    jsonToHomeListDataLikeBean(json, this);
  }
}

//-------------------------------解析方法---------------------------------

void jsonToHomeListBean(Map<String, dynamic> json, ListBean bean) {
  if (json == null) return;
  bean.status = int.parse(json["status"]?.toString() ?? "0");
  bean.message = json["message"]?.toString() ?? "";
  bean.data = ListDataBean(json["data"]);
}

void jsonToHomeListDataBean(Map<String, dynamic> json, ListDataBean bean) {
  if (json == null) return;
  bean.banner = [];
  for (var item in json["banner"]) {
    bean.banner.add(item?.toString() ?? "");
  }
  bean.classify=[];
  for(var item in json["classify"]){
  bean.classify.add(ListDataClassifyBean(item));
  }
  bean.trend=[];
  for(var item in json["trend"]){
  bean.trend.add(item?.toString()??"");
  }
  bean.like=[];
  for(var item in json["like"]){
  bean.like.add(ListDataLikeBean(item));
  }
}

void jsonToHomeListDataClassifyBean(Map<String, dynamic> json,
    ListDataClassifyBean bean) {
  if (json == null) return;
  bean.name = json["name"]?.toString() ?? "";
  bean.url = json["url"]?.toString() ?? "";
}

void jsonToHomeListDataLikeBean(Map<String, dynamic> json,
    ListDataLikeBean bean) {
  if (json == null) return;
  bean.title = json["title"]?.toString() ?? "";
  bean.url = json["url"]?.toString() ?? "";
  bean.price = json["price"]?.toString() ?? "";
  bean.shop = json["shop"]?.toString() ?? "";
}

Map<String, dynamic> jsonFromHomeListBean(ListBean bean) =>
    {
      "status": bean.status,
      "message": bean.message,
      "data": bean.data.toJson()
    };

Map<String, dynamic> jsonFromHomeListDataBean(ListDataBean bean) =>
    {
      "banner": bean.banner,
      "classify": bean.classify.map((e) => e.toJson()).toList(),
      "trend": bean.trend,
      "like": bean.like.map((e) => e.toJson()).toList()
    };

Map<String, dynamic> jsonFromHomeListDataClassifyBean(
    ListDataClassifyBean bean) =>
    {
      "name": bean.name,
      "url": bean.url
    };

Map<String, dynamic> jsonFromHomeListDataLikeBean(ListDataLikeBean bean) =>
    {
      "title": bean.title,
      "url": bean.url,
      "price": bean.price,
      "shop": bean.shop
    };


