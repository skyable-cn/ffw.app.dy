package com.ffw.app.dy.util;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;

public class AliPayUtil {
	public static String getUrl(String subject, String body, String snid, String money, String passbackParams) {
		String result = null;
		// 实例化客户端
		// AlipayClient alipayClient = new
		// DefaultAlipayClient("https://openapi.alipay.com/gateway.do",
		// "2019061065505851",
		// "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCFWqBYmW6tcMlXBz41zQcFtQlqRKmpOiDRdp3V+5oClWQILZeJ4EAmIcYxF4J+H6PbLKm9Yt4/Y5WgK/60mvK0wrdhi0McHzcQLvQ8s0p8wToNIHwuMwe4BfMU1pGUMZ0yGpiFOzGDAi/TKXINLEd6QPtjxPUw/RPKjmrbF0OAWV0rx7/0yjxBHj++s6v5pehlg10ZflXXdoufzZ+HSyezIbJLKoFsMMM5k4vArOMKvqK9y9BgbCebaB+x40B1jC6TGinlVH5dnJFpOs2QTdPKKDqR1KzkFxe4p8ZBImpa31tEyckPyrpYzBKoELVZa9J5tokOK+fRrw31GxZ30SsJAgMBAAECggEAHo7385WlYSVZXhIQ1W9YTpx/vdRiNJ9XaeiOnrx7PGBTffREp5m12YcfzZwfkRtbBxyjAP0pBMmjPgMW6Pgg6f882qN5C3azvYek/Evxo8j7roplKokTGb5zR7ErxxPfe93QWaeI3wafQvpaYl5lOsStVt2JemJkKKSeI/qew0hh2pULcVj1YrlrGu4m9ve1/vgh2rp46l9YzIRltPllraa/zHyxzSh6beYmtCHarZeJ1PUPIv7mE4/Hse6RtNkSbloI/9Tlm9Dq5LkgIv2s9Q5nt3LEEyaXemeOWAbfqaS285DefO2SBP0cvwXxAVcgBPBus2yyRaudsIvWgXbLKQKBgQDQ0bXjc9iTWzUWLw5Z6iTJJUWM5L9TquZz5pqxXADhlQfhbnE44lkrc9qZoMZwG4r9AM+5/z2scV+ANqOFUTIHQ8SCsdbelMi6GV0yjGCtCGIheYY4Ve71T1a0dbJLqyw3gdSVrcwUvdjb7LsTnRHkN/NrYiyH/dNtcpLc+gsZqwKBgQCje/E8BiLgcKc7Aq+vujpLsiRdxvaEW898D0vHp8be3iuWX2RAfsHiDaXGjLa0rIwgh9qBOW3f7vzxI0B8uozTwlq+dFYWJCbyQEj7ZINugk36LPVPzhpQ9vP8BEiLOlAoxLMYNu9bepO5tmnZHTSk/b12c3LRAhbShU06DHZiGwKBgENQNrfZcikeL6C1DoVBixYkI6VlX5+S6bLW1Wry433UUrQCrBDQNjphoEgBobYlysn/5vZoJvNdoJFuC4xAPkZFPCV9OmyJvaLv5jETO17L4wYzbGbgnKULLEID5rOpvBkwitytJ6pQAIX0a+HIsinFN3yYKw6zbeJMGreNCuL9AoGBAJ48U9T+N3m3cBXM1tGm1c/4f/yInIil+KCiiX2ZJgMHVXb5o6ZNSkoLXZ5dCma77/F4rQSQ2ol53zdjIILZaX95Sa24Gq7ZlRy7Hii9M/2df+4a3+G7onslXChc2P5xla6wHIzedzS64wtIxRDRlOfxdRWWTtaASCjBv2rlLxxrAoGASvM0gTJgYlw8aq7lRRIHEolufnM/hMsJ3jNlx8HPM9Rvn5UbIXs83kDG0ZvYppgURa85enOIoDsTY9t+NNJ2KshmIfCEllLN6Sg5SutPkPbeCymH5996IQbqyXg1T/Lp/Q86Zuq19yPgE6Ub5pxsfwV4uHEjBlPSv9HuPos8M74=",
		// "json", "utf-8",
		// "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh2oFdhWbt6t+d/jCYdLc3/7V7h9RT08eM0uHuhajmTLwTCsQXWGcpVvw1qwlqwvOMy3y3embhtoJ+MwFK/Y/+BYmwOjAMaimDizOxAMWrvo8RVG3kbvZjN/uVDvrcxsxRwNR5xGt8TNm+p+4AFK0Rm/7ucBvhyDoNHBea2eJsmm4tvfxEy5nUIUYpYtr5xSkgld5nC5gPWexTBj5uKlDQWOsa6AoxUGFNMhjxChCvJVfqvupfuLYAYiz76Wtp+1oprTgwy0PMecrlRu5izkJpHJHNQ3G0JzeL/sT3Vr5POOJ4iLrsiJIeEE54dHiglJJrKdkcmTd/efrFcImRDKRZwIDAQAB",
		// "RSA2");
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", "2019070165728317",
				"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCGzPsHKwP7KpNh20T3QTkY4iaQZPN2LN6sBQLvdRlrNmqkowFHHosmq6gzxRmRqTi/FcFkg24FacjBWjfMyPh7Sk9kV44m8xT7iBzYSISt9gMVCLJoyEeR0fVUltzDOQy31BZ1ikNNm3vaBB6zYTFeW1OeciUxgch73XF2/nmthC+C13nL0lD8NsvB40fPJMb6hXNP0bUP7nBHoP1pkl0xPxN2nrHmNTeNWUVsQTVhWIDlRaidzQF7AabehFzduNZ0PruKTE0M1IXY/Bi4RT0CpbJWok70cavxLi4QetuBRU3Yj9IuZSv5t7ktmplLotajLPWv40SLdO/MFeA5hQkvAgMBAAECggEAS18prSRcIX/40Gpt8WJCrqskrPAFQTptdvmGXqW3BL90eYG7ISzu2Tx53BiE53EbDZz4eV8TkWtImPP850Anz6gJJC3gid65CLtehYBmz24S4xvtxbDWc65V4mpIHdA0UEUCGc6pOyeI5KoREHNzyzJ9WsawDTJoCvoSi1pWZrIDS+ePFGcG4XtK4xUZNeAOwsYoP4yP68uI0NMDSf1QFbKabzAtPzvzpro5gDBDu087sUR6l20rYrBxaJKRLiFw2sCesAFsI6qySxb/OGcNqVHs9AEfs0P5Vjg8+MTrv2LHVhep3A5ksbUWZb5AdKUZgAw7pbeswB4KS53Ju3lrYQKBgQDeiIjzBA5Nt4WFOu6U1USaIN6hcjnP6wyrrM2nfzrhEwYfS4J7KMALkjUSmyENR6m/U0ISA9RxkzEuc2UPa9xEJ8gSulK1eCPo4lNZQixlnxxajSKrEqZQhYtEKRHFahugWdkLU2u6c0z0OSnlDrMtBSgzILwY8PyEXs46cy5BvQKBgQCbEsQm9XC3D1vuJmEthSR3nCrPCAHrn+zxCLuN00+sfzoni8CNe+tbaYJeupcIhqVKNziSd2CUfUp5wLBLZmLS/SyuHhRHNGavpVwGIyRIwdorrVgLeEAFecPr/iTl4k1Q4XL0qI+HQ+WHbdrSdCvzsLOOJkgn1RQcG9IoxR2HWwKBgQC7T7nWtEdF64AcEOrZpFpGUfyTcI5xEKxtpNrGbjWlVloE5Y5DFJ3yH3NE4gcEIpojTXWDrG2Z3Ae9zav3OxcA12t1OBh+X036rObzbtvn/fHj1oCj9uK/TGlZSiiHPzVZ18b13ZYELyFLQQKep6zx7DFWN+ucItyqnxJ/6Iu7EQKBgDJfuTpSlofQxHMrInwv+PWl1D4mgsEw1T5DMPHUR9hoB9Ma0bTkIUMzlfcBs9hALOdb4tOpVcVGoe/FCT+lBcs2FNKG0N2Ehyrdk3Qm7D16Q03W5HftWxasRFmf2AqZJbZ1Vetl6iHti10f8WpV9IUXzGwLwXq2++5Zlz5JMdtrAoGADnFCkptDslKTAFA5u88DvrpctN9AGbFR3iWMY1u+2wX6T1iK9jSvSblMWQCEdZWoyiTTgCnY6Hzg2VXsjdocwHFi6P00dJg83RJGyodnotKUiYtnOT7eFUYzfE9UJ7iRbULpJAQjh2IwrhuTMlqZWJQkPAc0NeF2gV3S3Op2cJ0=",
				"json", "utf-8",
				"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArUs9NDZUVU2kF6iSdrbwoDXGPXw7WxyTSa2jYZKnESba2cX10iPZpl2C8J1Ir8s/DbjYIHvm1jco+TygW1iGA7CjgHORChemxQtzEl35rjU+fxnHoJpn103e/udrL956JLwI0xd1B7b44cN+A7y8Ax+R51Ah7/CITXN9Ngp87ObG89HADj3HiixZAKTwkzCW0om8HjFS4IN5PtLFPLPnGciDvHuavFfg+28hf5+XjKxkbvO8uKEeh+klLxgZX/64az9BWotq/0iENA1MYNwhc0e7kteUmPtwkd3Exrfll+Cz01z0q4Z40AY/DzYo88k9pm9GNST6hn1rddMUuQpeIQIDAQAB",
				"RSA2");
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
