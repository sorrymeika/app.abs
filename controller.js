define("template/index",["util"],function(require){var T=(require("util"),{html:function($data){var __="";with($data||{})__+='\ufeff<div class="main"> <h1 sn-binding="html:title"></h1> <div style="font-size:30px; margin: 30px" sn-binding="html:content"> </div> </div> ';return __},helpers:{}});return T.template=T.html,T});define("views/index",[],function(e,t,n){var s=(e("$"),e("util"),e("core/model")),a=e("common/page"),o=e("common/menu");e("components/form"),e("components/grid");return a.extend({events:{},onCreate:function(){this.model=new s.ViewModel(this.$el,{title:"目的地管理",content:"欢迎使用ABS APP后台"})},onShow:function(){this.menu=o.get("/"),this.$el.before(this.menu.$el)},onDestory:function(){}})});define("template/login",["util"],function(require){var T=(require("util"),{html:function($data){var __="";with($data||{})__+='\ufeff<div class="main"> <h1 sn-binding="html:title"></h1> <div class="action"> <b class="button" sn-repeat="button in buttons" sn-on="click:button.click"> <em sn-binding="class:button.ico"></em><text sn-binding="html:button.value"></text> </b> </div> </div> ';return __},helpers:{}});return T.template=T.html,T});define("views/login",[],function(e,t,n){var s=(e("$"),e("util"),e("core/page")),a=e("core/model"),o=e("models/api").API,l=e("components/form");return s.extend({events:{},onCreate:function(){var e=this;e.$el.siblings().hide(),this.model=new a.ViewModel(this.$el,{title:"登录",buttons:[{value:"确认",click:function(){n.submit(function(t){t.success?(sl.tip("登录成功"),e.back("/")):(sl.tip(t.msg),e.model.set({captcha:"/captcha/"+Date.now()+".jpg"}))})}}]});var t=o.url("/api/manage/login"),n=new l({model:this.model,name:"user",title:"test",useIframe:t.match(/http\:\/\/([^\/]+)/)[1]==location.host,url:t,validator:"userValid",enctype:"",fields:[{label:"账号",field:"username",emptyAble:!1,emptyText:"不可为空"},{label:"密码",field:"password",type:"password",emptyAble:!1,emptyText:"不可为空"},{label:"验证码",field:"captcha",type:"captcha",captcha:o.url("/captcha/1.jpg"),emptyAble:!1,emptyText:"不可为空",render:function(){}}]});this.model.before(".action",n.$el)},onShow:function(){},onDestory:function(){}})});