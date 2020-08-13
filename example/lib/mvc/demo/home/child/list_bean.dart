class ListBean {
   int status;
   String message;
   ListDataBean data;

   Map<String,dynamic> toJson()=>jsonFromChildListBean(this);
   ListBean(Map<String,dynamic> json){
       jsonToChildListBean(json,this);
   }
}
class ListDataBean {
   List<String> banner;
   List<ListDataClassifyBean> classify;
   List<String> trend;
   List<ListDataLikeBean> like;

   Map<String,dynamic> toJson()=>jsonFromChildListDataBean(this);
   ListDataBean(Map<String,dynamic> json){
       jsonToChildListDataBean(json,this);
   }
}
class ListDataClassifyBean {
   String name;
   String url;

   Map<String,dynamic> toJson()=>jsonFromChildListDataClassifyBean(this);
   ListDataClassifyBean(Map<String,dynamic> json){
       jsonToChildListDataClassifyBean(json,this);
   }
}
class ListDataLikeBean {
   String title;
   String url;
   String price;
   String shop;

   Map<String,dynamic> toJson()=>jsonFromChildListDataLikeBean(this);
   ListDataLikeBean(Map<String,dynamic> json){
       jsonToChildListDataLikeBean(json,this);
   }
}

//-------------------------------解析方法---------------------------------

void jsonToChildListBean(Map<String,dynamic> json,ListBean bean){
   if(json==null) return;
   bean.status=int.parse(json["status"]?.toString()??"0");
   bean.message=json["message"]?.toString()??"";
   bean.data=ListDataBean(json["data"]);
}
void jsonToChildListDataBean(Map<String,dynamic> json,ListDataBean bean){
   if(json==null) return;
   bean.banner=[];
   for(var item in json["banner"]){
      bean.banner.add(item?.toString()??"");
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
void jsonToChildListDataClassifyBean(Map<String,dynamic> json,ListDataClassifyBean bean){
   if(json==null) return;
   bean.name=json["name"]?.toString()??"";
   bean.url=json["url"]?.toString()??"";
}
void jsonToChildListDataLikeBean(Map<String,dynamic> json,ListDataLikeBean bean){
   if(json==null) return;
   bean.title=json["title"]?.toString()??"";
   bean.url=json["url"]?.toString()??"";
   bean.price=json["price"]?.toString()??"";
   bean.shop=json["shop"]?.toString()??"";
}

Map<String,dynamic> jsonFromChildListBean(ListBean bean)=>{
   "status":bean.status,
   "message":bean.message,
   "data":bean.data.toJson()
};

Map<String,dynamic> jsonFromChildListDataBean(ListDataBean bean)=>{
   "banner":bean.banner,
   "classify":bean.classify.map((e)=>e.toJson()).toList(),
   "trend":bean.trend,
   "like":bean.like.map((e)=>e.toJson()).toList()
};

Map<String,dynamic> jsonFromChildListDataClassifyBean(ListDataClassifyBean bean)=>{
   "name":bean.name,
   "url":bean.url
};

Map<String,dynamic> jsonFromChildListDataLikeBean(ListDataLikeBean bean)=>{
   "title":bean.title,
   "url":bean.url,
   "price":bean.price,
   "shop":bean.shop
};


