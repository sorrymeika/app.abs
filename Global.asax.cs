using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace SL.Web
{
    // 注意: 有关启用 IIS6 或 IIS7 经典模式的说明，
    // 请访问 http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            #region 默认

            routes.MapRoute(
               "APIDefault",
               "API/{catalog}/{handle}",
               new { controller = "Core", action = "APIAction", catalog = "", handle = "" }
            );

            routes.MapRoute(
               "Manage",
               "Manage/{catalog}/{handle}",
               new { controller = "Core", action = "Manage", catalog = "Login", handle = "" }
            );

            routes.MapRoute(
               "base64Image",
               "base64/{*image}",
               new { controller = "Core", action = "Base64Image" }
            );

            routes.MapRoute(
               "compressImage",
               "compress/{*image}",
               new { controller = "Core", action = "CompressImage" }
            );

            routes.MapRoute(
               "ImagePreview",
               "ImagePreview",
               new { controller = "Core", action = "ImagePreview" }
            );

            routes.MapRoute(
               "captcha",
               "captcha/{id}.jpg",
               new { controller = "Core", action = "Captcha", id = @"\d+" }
            );
            #endregion

            #region 支付宝
            routes.MapRoute(
                "AlipayDirectPay",
                "AlipayDirect/Pay/{orderid}",
                new { controller = "AlipayDirect", action = "Pay", orderid = 0 },
                new { orderid = "^\\d+$" }
            );

            routes.MapRoute(
                "AlipayDirect",
                "AlipayDirect/{action}",
                new { controller = "AlipayDirect", action = "Callback" }
            );
            #endregion

            routes.MapRoute(
                "Default",
                "{catalog}/{handle}",
                new { controller = "Core", action = "Index", catalog = "Core", handle = "Index" }
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);
        }
    }
}