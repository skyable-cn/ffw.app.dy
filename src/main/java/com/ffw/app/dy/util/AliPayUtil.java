package com.ffw.app.dy.util;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;

public class AliPayUtil {

	private String mchid;

	private String privatekey;

	private String alipublickey;

	public AliPayUtil(String mchid, String privatekey, String alipublickey) {
		this.mchid = mchid;
		this.privatekey = privatekey;
		this.alipublickey = alipublickey;
	}

	public String getUrl(String subject, String body, String snid, String money, String passbackParams) {
		String result = null;
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", mchid, privatekey,
				"json", "utf-8", alipublickey, "RSA2");
		// 实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
		AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
		// SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
		AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
		model.setSubject(subject);
		model.setBody(body);
		model.setOutTradeNo(snid);
		model.setTimeoutExpress("5d");
		model.setTotalAmount(money);
		model.setProductCode("QUICK_MSECURITY_PAY");
		model.setPassbackParams(passbackParams);
		request.setBizModel(model);
		request.setNotifyUrl("https://fanfan.skyable.cn/appdy/dyNotify");
		try {
			// 这里和普通的接口调用不同，使用的是sdkExecute
			AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
			result = response.getBody();// 就是orderString
										// 可以直接给客户端请求，无需再做处理。
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}
		return result;
	}
}
