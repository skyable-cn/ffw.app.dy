package com.ffw.app.dy.util;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import net.sf.json.JSONObject;

import org.apache.commons.codec.digest.DigestUtils;

public class JSSDKUtil {

	private static String appId = "wx1927131d08fe2a04";

	private static String appSecret = "2f0d28354ccb7290ca1ac16c4dda02e3";

	public static String AccessToken(String appid, String appsecret) {
		String rs = null;
		try {
			String str = HttpUtils
					.get("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="
							+ appid + "&secret=" + appsecret);
			JSONObject obj = JSONObject.fromObject(str);
			rs = obj.getString("access_token");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public static String JsapiTicket(String accessToken) {
		String rs = null;
		try {
			String str = HttpUtils
					.get("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="
							+ accessToken + "&type=jsapi");
			JSONObject obj = JSONObject.fromObject(str);
			rs = obj.getString("ticket");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public static Map<String, String> config(String url) {
		String accessToken = AccessToken(appId, appSecret);
		String ticket = JsapiTicket(accessToken);
		String noncestr = UUID.randomUUID().toString().replace("-", "");
		String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
		String str = "jsapi_ticket=" + ticket + "&noncestr=" + noncestr
				+ "&timestamp=" + timestamp + "&url=" + url;

		String signature = DigestUtils.sha1Hex(str.getBytes());

		Map<String, String> map = new HashMap<String, String>();
		map.put("timestamp", timestamp);
		map.put("accessToken", accessToken);
		map.put("ticket", ticket);
		map.put("noncestr", noncestr);
		map.put("signature", signature);
		map.put("appId", appId);
		System.err.println(map);
		return map;
	}
}
