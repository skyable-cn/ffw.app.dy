package com.ffw.app.dy.controller;

import java.net.URLEncoder;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ffw.api.model.PageData;
import com.ffw.app.dy.config.FileConfig;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.util.AliPayUtil;
import com.ffw.app.dy.util.HttpUtils;
import com.ffw.app.dy.util.RestTemplateUtil;

import net.sf.json.JSONObject;

@Controller
public class PayController extends BaseController {

	@Autowired
	FileConfig fileConfig;

	@Autowired
	RestTemplateUtil rest;

	private String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			int index = ip.indexOf(",");
			if (index != -1) {
				return ip.substring(0, index);
			} else {
				return ip;
			}
		}
		ip = request.getHeader("X-Real-IP");
		if (StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			return ip;
		}
		return request.getRemoteAddr();
	}

	@RequestMapping("dyPay")
	@ResponseBody
	public Map<String, String> wxPay() throws Exception {

		logger.info("进入下单处理");
		PageData pd = new PageData();
		pd = this.getPageData();

		String SNID = null;
		String SUBJECT = "字节跳动小程序在线支付";
		String BODYDESC = null;

		// 返回给小程序端需要的参数
		Map<String, String> response = new HashMap<String, String>();

		String type = pd.getString("TYPE");

		if ("goods".equals(type)) {
			pd.put("ORDER_ID", pd.getString("ID"));
			pd = rest.post(IConstant.FFW_SERVICE_KEY, "orders/find", pd, PageData.class);

			PageData pdtest = new PageData();
			pdtest.put("GOODS_ID", pd.getString("GOODS_ID"));
			pdtest = rest.post(IConstant.FFW_SERVICE_KEY, "goods/find", pdtest, PageData.class);

			if (!IConstant.STRING_1.equals(pdtest.getString("STATE"))
					|| Integer.parseInt(pdtest.getString("STORE")) - Integer.parseInt(pd.getString("NUMBER")) < 0) {
				response.put("STATEFLAG", "NO");
				response.put("STATEMESSAGE", "产品售卖标识异常");
				return response;
			}

			SNID = pd.getString("ORDERSN");
			BODYDESC = "饭饭网产品消费";
		} else if ("product".equals(type)) {
			pd.put("RECHARGE_ID", pd.getString("ID"));
			pd = rest.post(IConstant.FFW_SERVICE_KEY, "recharge/find", pd, PageData.class);
			SNID = pd.getString("RECHARGESN");
			BODYDESC = "饭饭网会员充值";
		} else {

		}

		if (null == pd) {
			response.put("STATEFLAG", "NO");
			response.put("STATEMESSAGE", "参数异常");
			return response;
		}

		if (StringUtils.isNotEmpty(pd.getString("WEIXINSN"))) {
			response.put("STATEFLAG", "NO");
			response.put("STATEMESSAGE", "订单已支付");
			return response;
		}

		String MONEY = pd.getString("MONEY");
		String fee = String.valueOf(Float.parseFloat(MONEY) * 100);
		fee = fee.substring(0, fee.indexOf(".")) + "";

		// 获取客户端的ip地址
		String spbill_create_ip = getIpAddr(getRequest());

		PageData market = marketSession();
		String MCHID = market.getString("DYMCHID");
		String MAPPID = market.getString("DYMAPPID");
		String MAPPSECRET = market.getString("DYMAPPSECRET");

		System.out.println("========================开始签名==============================");

		String dl = new Date().getTime() + "";

		String biz_content = "{\"out_order_no\":\"" + SNID + "\",\"uid\":\"" + openId() + "\",\"merchant_id\":\""
				+ MCHID + "\",\"total_amount\":\"" + fee + "\",\"currency\":\"CNY\",\"subject\":\"" + SUBJECT
				+ "\",\"body\":\"" + BODYDESC + "\",\"trade_time\":\"" + dl
				+ "\",\"valid_time\":\"1800\",\"notify_url\":\"https://fanfan.skyable.cn/appdy/dyNotify\",\"risk_info\":{\"ip\":\""
				+ spbill_create_ip + "\",\"device_id\":\"10001\"}}";
		String param0 = "app_id=" + MAPPID + "&biz_content=" + biz_content
				+ "&charset=utf-8&format=JSON&method=tp.trade.create&sign_type=MD5&timestamp=" + dl + "&version=1.0";
		param0 = param0 + MAPPSECRET;
		String sign = DigestUtils.md5Hex(param0);

		Map<String, String> param = new LinkedHashMap<String, String>();
		param.put("app_id", MAPPID);
		param.put("biz_content", biz_content);
		param.put("charset", "utf-8");
		param.put("format", "JSON");
		param.put("method", "tp.trade.create");
		param.put("sign", sign);
		param.put("sign_type", "MD5");
		param.put("timestamp", dl);
		param.put("version", "1.0");
		String str = HttpUtils.post("https://tp-pay.snssdk.com/gateway", param);
		System.err.println(str);

		JSONObject obj = JSONObject.fromObject(str);
		String r_sign = obj.getString("sign");
		String r_trade_no = obj.getJSONObject("response").getString("trade_no");

		System.out.println("========================二次签名==============================");

		String p0 = "app_id=" + MAPPID + "&biz_content={\"subject\":\"" + SUBJECT + "\",\"out_trade_no\":\"" + SNID
				+ "\",\"total_amount\":\"" + fee
				+ "\",\"product_code\":\"QUICK_MSECURITY_PAY\"}&charset=utf-8&format=JSON&method=alipay.trade.app.pay&notify_url=https://fanfan.skyable.cn/appdy/dyNotify&sign_type=RSA&timestamp="
				+ dl + "&version=1.0";

		p0 = URLEncoder.encode(p0, "utf-8").replaceAll("%3D", "=").replaceAll("%26", "&");

		p0 = p0.replace("sign_type", "sign=" + r_sign + "&sign_type");

		p0 = AliPayUtil.getUrl(SUBJECT, BODYDESC, SNID, MONEY);

		System.err.println("支付宝URL:" + p0);

		String result0 = "app_id=" + MAPPID + "&merchant_id=" + MCHID + "&params={\"url\":\"" + p0
				+ "\"}&sign_type=MD5&timestamp=" + dl + "&total_amount=" + fee + "&trade_no=" + r_trade_no + "&uid="
				+ openId();

		result0 = result0 + MAPPSECRET;
		String result0sign = DigestUtils.md5Hex(result0);

		response.put("app_id", MAPPID);
		response.put("sign", result0sign);
		response.put("timestamp", dl);
		response.put("trade_no", r_trade_no);
		response.put("merchant_id", MCHID);
		response.put("uid", openId());
		response.put("total_amount", fee);
		response.put("url", p0);
		response.put("ip", spbill_create_ip);

		response.put("STATEFLAG", "OK");

		System.err.println("支付调用参数:" + response);
		return response;
	}

	@RequestMapping(value = "/dyNotify")
	@ResponseBody
	public String wxNotify(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// String requestJson = IOUtils.toString(request.getInputStream(),
		// "utf-8");
		// logger.info("支付宝支付结果通知接口请求数据json:" + requestJson);

		try {
			Enumeration enu = request.getParameterNames();
			while (enu.hasMoreElements()) {
				String paraName = (String) enu.nextElement();
				System.out.println(paraName + ": " + request.getParameter(paraName));
			}
		} catch (Exception e4) {
			e4.printStackTrace();
			return "fail";
		}

		// 获取支付宝POST过来反馈信息
		Map<String, String> receiveMap = getReceiveMap(request);
		logger.info("支付宝支付回调参数:" + receiveMap);

		return "success";
	}

	private String randomNumber(int length) {
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
		String s = "0123456789";
		for (int i = 0; i < length; i++) {
			sb.append(s.charAt(r.nextInt(s.length())));
		}
		return sb.toString();
	}

	private static Map<String, String> getReceiveMap(HttpServletRequest request) {
		Map<String, String> params = new HashMap<String, String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。
			// valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}

		return params;
	}

}
