define("template/login",["util"],function(require){var T=(require("util"),{html:function($data){var __="";with($data||{})__+='<div class="main"> <h1 sn-binding="html:title"></h1> <div class="action"> <b class="button" sn-repeat="button in buttons" sn-on="click:button.click"> <em sn-binding="class:button.ico"></em><text sn-binding="html:button.value"></text> </b> </div> </div> ';return __},helpers:{}});return T.template=T.html,T});define("template/index",["util"],function(require){var T=(require("util"),{html:function($data){var __="";with($data||{})__+='<div class="main"> <h1 sn-binding="html:title"></h1> <div style="font-size:30px; margin: 30px" sn-binding="html:content"> </div> </div> ';return __},helpers:{}});return T.template=T.html,T});define("views/index",["images/style.css","$","util","core/model","common/page","common/menu","components/form","components/grid"],function(t,e,i){{var a=(t("$"),t("util"),t("core/model")),o=t("common/page"),l=t("common/menu");t("components/form"),t("components/grid")}return o.extend({events:{},onCreate:function(){this.model=new a.ViewModel(this.$el,{title:"目的地管理",content:"欢迎使用ABS APP后台"})},onShow:function(){this.menu=l.get("/"),this.$el.before(this.menu.$el)},onDestory:function(){}})});define("views/login",["images/style.css","$","util","core/page","core/model","components/form"],function(t,e,i){var o=(t("$"),t("util"),t("core/page")),a=t("core/model"),l=t("components/form");return o.extend({events:{},onCreate:function(){var t=this;t.$el.siblings().hide(),this.model=new a.ViewModel(this.$el,{title:"登录",buttons:[{value:"确认",click:function(){e.submit(function(e){e.success?(sl.tip("登录成功"),t.back("/")):(sl.tip(e.msg),t.model.set({captcha:"/captcha/"+Date.now()+".jpg"}))})}}]});var e=new l({model:this.model,name:"user",title:"test",useIframe:!0,url:"/api/manage/login",validator:"userValid",enctype:"",fields:[{label:"账号",field:"username",emptyAble:!1,emptyText:"不可为空"},{label:"密码",field:"password",type:"password",emptyAble:!1,emptyText:"不可为空"},{label:"验证码",field:"captcha",type:"captcha",captcha:"/captcha/1.jpg",emptyAble:!1,emptyText:"不可为空",render:function(){}}]});this.model.before(".action",e.$el);var i={asdf:1,asdf1:1},n={asdf:1,asdf1:1};delete i.adsf,n.asdf=null;for(var r=[],c=0;1e6>c;c++)r[c]=1;console.log(Date.now());for(var d=Date.now(),c=0;1e6>c;c++);console.log(Date.now()-d),d=Date.now();for(var c=0;1e6>c;c++);console.log(Date.now()-d),console.log(r.length)},onShow:function(){},onDestory:function(){}})});