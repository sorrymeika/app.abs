using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SL.Web.Service;
using System.IO;
using System.Globalization;
using System.Web.Script.Serialization;
using System.Drawing;
using SL.Util;
using System.Collections.Specialized;
using System.Xml;
using Alipay.APP;

namespace SL.Web.Controllers
{
    public class AlipayAppController : Controller
    {

        #region 支付宝（App）
        private Dictionary<string, object> GetOrder(int orderid)
        {
            return null;
        }

        public ActionResult Pay(string order_no)
        {
            var data = SL.Data.SQL.QuerySingle("select PUR_CODE,PUR_PUS_ID,PUR_PAS_ID,PUR_AMOUNT,PUR_EXP_IN_AMOUNT from BPurchase where PUR_CODE=@p0", order_no);

            if (data == null)
            {
                return Json(new { retcode = -1, retmsg = "订单不存在" }, JsonRequestBehavior.AllowGet);
            }
            if (data.Status == 0)
            {
                return Json(new { retcode = -1, retmsg = "订单已被取消" }, JsonRequestBehavior.AllowGet);
            }

            var showUrl = "http://m.abs.cn";

            var productName = "爱彼此家居商品:" + data.PUR_CODE;
            var amount = (data.PUR_AMOUNT + data.PUR_EXP_IN_AMOUNT).ToString("0.##");

            Alipay.APP.Config.Partner = System.Configuration.ConfigurationManager.AppSettings["Alipay_Partner"];
            Alipay.APP.Config.Private_key = System.Configuration.ConfigurationManager.AppSettings["ALIPAY_PRIVATE_KEY"];
            string seller_email = System.Configuration.ConfigurationManager.AppSettings["Alipay_Seller_Email"];

            /*
            *生成订单信息及签名
            */
            //将商品信息赋予AlixPayOrder的成员变量
            dynamic order = new SL.Data.DynamicRecord();
            order.partner = Alipay.APP.Config.Partner;
            order.seller = seller_email;
            order.tradeNO = order_no; //订单ID（由商家自行制定）
            order.productName = productName; //商品标题
            order.productDescription = productName; //商品描述
            order.amount = amount; //商品价格
            order.notifyURL = SL.Util.RequestFile.FullUrl("AlipayApp/Notify"); //回调URL

            order.service = "mobile.securitypay.pay";
            order.paymentType = "1";
            order.inputCharset = Alipay.APP.Config.Input_charset;
            order.itBPay = "30m";
            order.showUrl = showUrl;

            //将商品信息拼接成字符串
            String orderSpec = this.description(order);

            //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
            String signedString = RSAFromPkcs8.sign(orderSpec, Alipay.APP.Config.Private_key, Alipay.APP.Config.Input_charset);

            return Json(new { retcode = 0, retmsg = "", orderSpec = orderSpec, signedString = signedString }, JsonRequestBehavior.AllowGet);
        }

        private string description(dynamic self)
        {
            String discription = "";
            if (!string.IsNullOrEmpty(self.partner))
            {
                discription += "partner=\"" + self.partner + "\"";
            }

            if (!string.IsNullOrEmpty(self.seller))
            {
                discription += "&seller_id=\"" + self.seller + "\"";
            }
            if (!string.IsNullOrEmpty(self.tradeNO))
            {
                discription += "&out_trade_no=\"" + self.tradeNO + "\"";
            }
            if (!string.IsNullOrEmpty(self.productName))
            {
                discription += "&subject=\"" + self.productName + "\"";
            }
            if (!string.IsNullOrEmpty(self.productDescription))
            {
                discription += "&body=\"" + self.productDescription + "\"";
            }
            if (!string.IsNullOrEmpty(self.amount))
            {
                discription += "&body=\"" + self.amount + "\"";
            }
            if (!string.IsNullOrEmpty(self.amount))
            {
                discription += "&total_fee=\"" + self.amount + "\"";
            }
            if (!string.IsNullOrEmpty(self.notifyURL))
            {
                discription += "&notify_url=\"" + self.notifyURL + "\"";
            }
            if (!string.IsNullOrEmpty(self.service))
            {
                discription += "&service=\"" + self.service + "\"";
            }
            if (!string.IsNullOrEmpty(self.paymentType))
            {
                discription += "&payment_type=\"" + self.paymentType + "\"";
            }
            if (!string.IsNullOrEmpty(self.inputCharset))
            {
                discription += "&_input_charset=\"" + self.inputCharset + "\"";
            }
            if (!string.IsNullOrEmpty(self.itBPay))
            {
                discription += "&it_b_pay=\"" + self.itBPay + "\"";
            }
            if (!string.IsNullOrEmpty(self.showUrl))
            {
                discription += "&show_url=\"" + self.showUrl + "\"";
            }
            if (!string.IsNullOrEmpty(self.rsaDate))
            {
                discription += "&sign_date=\"" + self.rsaDate + "\"";
            }
            if (!string.IsNullOrEmpty(self.appID))
            {
                discription += "&app_id=\"" + self.appID + "\"";
            }

            return discription;
        }

        public ActionResult Notify(int orderid)
        {
            SortedDictionary<string, string> sPara = GetRequestPost();

            if (sPara.Count > 0)//判断是否有带返回参数
            {
                Alipay.APP.Notify aliNotify = new Alipay.APP.Notify();
                bool verifyResult = aliNotify.Verify(sPara, Request.Form["notify_id"], Request.Form["sign"]);

                if (verifyResult)//验证成功
                {
                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //请在这里加上商户的业务逻辑程序代码


                    //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                    //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表

                    string out_trade_no = Request.Form["out_trade_no"];//商户订单号                

                    //支付宝交易号                string trade_no = Request.Form["trade_no"];

                    //交易状态
                    string trade_status = Request.Form["trade_status"];


                    if (Request.Form["trade_status"] == "TRADE_FINISHED")
                    {
                        //判断该笔订单是否在商户网站中已经做过处理
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序

                        //注意：
                        //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
                        //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的

                        SL.Data.SQL.Execute("update BPurchase set PUR_PAS_ID=2 where PUR_CODE=@p0", out_trade_no);

                    }
                    else if (Request.Form["trade_status"] == "TRADE_SUCCESS")
                    {
                        //判断该笔订单是否在商户网站中已经做过处理
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序

                        //注意：
                        //付款完成后，支付宝系统发送该交易状态通知
                        //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的

                        SL.Data.SQL.Execute("update BPurchase set PUR_PAS_ID=2 where PUR_CODE=@p0", out_trade_no);

                    }
                    else
                    {
                    }

                    //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                    return Content("success");  //请不要修改或删除

                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }
                else//验证失败
                {
                    return Content("fail");
                }
            }
            else
            {
                return Content("无通知参数");
            }
        }

        /// <summary>
        /// 获取支付宝POST过来通知消息，并以“参数名=参数值”的形式组成数组
        /// </summary>
        /// <returns>request回来的信息组成的数组</returns>
        public SortedDictionary<string, string> GetRequestPost()
        {
            int i = 0;
            SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
            NameValueCollection coll;
            //Load Form variables into NameValueCollection variable.
            coll = Request.Form;

            // Get names of all forms into a string array.
            String[] requestItem = coll.AllKeys;

            for (i = 0; i < requestItem.Length; i++)
            {
                sArray.Add(requestItem[i], Request.Form[requestItem[i]]);
            }

            return sArray;
        }
        #endregion

    }
}