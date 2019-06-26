package com.ffw.app.dy.util;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;

public class AliPayUtil {
	public static String getUrl(String subject,String body,String snid,String money) {
		String result = null;
		// 实例化客户端
		// AlipayClient alipayClient = new
		// DefaultAlipayClient("https://openapi.alipay.com/gateway.do",
		// "2019061065505851",
		// "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCFWqBYmW6tcMlXBz41zQcFtQlqRKmpOiDRdp3V+5oClWQILZeJ4EAmIcYxF4J+H6PbLKm9Yt4/Y5WgK/60mvK0wrdhi0McHzcQLvQ8s0p8wToNIHwuMwe4BfMU1pGUMZ0yGpiFOzGDAi/TKXINLEd6QPtjxPUw/RPKjmrbF0OAWV0rx7/0yjxBHj++s6v5pehlg10ZflXXdoufzZ+HSyezIbJLKoFsMMM5k4vArOMKvqK9y9BgbCebaB+x40B1jC6TGinlVH5dnJFpOs2QTdPKKDqR1KzkFxe4p8ZBImpa31tEyckPyrpYzBKoELVZa9J5tokOK+fRrw31GxZ30SsJAgMBAAECggEAHo7385WlYSVZXhIQ1W9YTpx/vdRiNJ9XaeiOnrx7PGBTffREp5m12YcfzZwfkRtbBxyjAP0pBMmjPgMW6Pgg6f882qN5C3azvYek/Evxo8j7roplKokTGb5zR7ErxxPfe93QWaeI3wafQvpaYl5lOsStVt2JemJkKKSeI/qew0hh2pULcVj1YrlrGu4m9ve1/vgh2rp46l9YzIRltPllraa/zHyxzSh6beYmtCHarZeJ1PUPIv7mE4/Hse6RtNkSbloI/9Tlm9Dq5LkgIv2s9Q5nt3LEEyaXemeOWAbfqaS285DefO2SBP0cvwXxAVcgBPBus2yyRaudsIvWgXbLKQKBgQDQ0bXjc9iTWzUWLw5Z6iTJJUWM5L9TquZz5pqxXADhlQfhbnE44lkrc9qZoMZwG4r9AM+5/z2scV+ANqOFUTIHQ8SCsdbelMi6GV0yjGCtCGIheYY4Ve71T1a0dbJLqyw3gdSVrcwUvdjb7LsTnRHkN/NrYiyH/dNtcpLc+gsZqwKBgQCje/E8BiLgcKc7Aq+vujpLsiRdxvaEW898D0vHp8be3iuWX2RAfsHiDaXGjLa0rIwgh9qBOW3f7vzxI0B8uozTwlq+dFYWJCbyQEj7ZINugk36LPVPzhpQ9vP8BEiLOlAoxLMYNu9bepO5tmnZHTSk/b12c3LRAhbShU06DHZiGwKBgENQNrfZcikeL6C1DoVBixYkI6VlX5+S6bLW1Wry433UUrQCrBDQNjphoEgBobYlysn/5vZoJvNdoJFuC4xAPkZFPCV9OmyJvaLv5jETO17L4wYzbGbgnKULLEID5rOpvBkwitytJ6pQAIX0a+HIsinFN3yYKw6zbeJMGreNCuL9AoGBAJ48U9T+N3m3cBXM1tGm1c/4f/yInIil+KCiiX2ZJgMHVXb5o6ZNSkoLXZ5dCma77/F4rQSQ2ol53zdjIILZaX95Sa24Gq7ZlRy7Hii9M/2df+4a3+G7onslXChc2P5xla6wHIzedzS64wtIxRDRlOfxdRWWTtaASCjBv2rlLxxrAoGASvM0gTJgYlw8aq7lRRIHEolufnM/hMsJ3jNlx8HPM9Rvn5UbIXs83kDG0ZvYppgURa85enOIoDsTY9t+NNJ2KshmIfCEllLN6Sg5SutPkPbeCymH5996IQbqyXg1T/Lp/Q86Zuq19yPgE6Ub5pxsfwV4uHEjBlPSv9HuPos8M74=",
		// "json", "utf-8",
		// "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh2oFdhWbt6t+d/jCYdLc3/7V7h9RT08eM0uHuhajmTLwTCsQXWGcpVvw1qwlqwvOMy3y3embhtoJ+MwFK/Y/+BYmwOjAMaimDizOxAMWrvo8RVG3kbvZjN/uVDvrcxsxRwNR5xGt8TNm+p+4AFK0Rm/7ucBvhyDoNHBea2eJsmm4tvfxEy5nUIUYpYtr5xSkgld5nC5gPWexTBj5uKlDQWOsa6AoxUGFNMhjxChCvJVfqvupfuLYAYiz76Wtp+1oprTgwy0PMecrlRu5izkJpHJHNQ3G0JzeL/sT3Vr5POOJ4iLrsiJIeEE54dHiglJJrKdkcmTd/efrFcImRDKRZwIDAQAB",
		// "RSA2");
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", "2019062665696131",
				"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCB3Zm6K8OKyvz4BrKp+kP0e6JU2BH7yPO7owqssb5fCQ0a2HF4HHVMT3JaqI3SVrobc/yi5VCYr96EPbnTGdyMuTWmnb2gKKErbTdmE08K+Dd4Pg10oavispXSW+bmlLGxClv6+ZgkFfidKpksnbi5UffRf4F+RIbELbDYRP/o4t8/x04QzBxM7fRE1M4r7D3NO5fxcVVaU/nkAWoVWPAJgnq/2NwrWux0Pgl3gVNR7AWS5hJeRZZo9gpYzLjrXPFn4EA94JP2Q9ZXLQPLBBY7ofYkdHCv1V4OrUK6kksPFiYBsqj1cWLIA+uP76oCBKU7WmPWvpwesCtT0vhFa8uRAgMBAAECggEAZJ4mUklAKxQVJbJC0VHXPuBfqK70WAmdVj7/sUfRwN5JaghS+gXKmAJiDn3TzCln7odSMX/Mj1CL7hfJFxdNezawq9RBrIpuPTBUoODK+CvTBnXFhR0SCQXm8OJFp1eDyTDGjVC/IQ5o3pS3swrMqcEpagcJdKRxaiQghaAISw4J6hTRgqg6dERoAMU33YqiUBX5aZOMRx6DHMVOtOytT3xh/sWRhq2QDQ2+9e9t5WbiAFj+2KJ9Is1/FcX64kpAoxmzB/RLF0eDN0LBLgjfbEMEOIWzyJbRUsF8EDToFYnirU8xqiDbZrMDoLUrB9MA3MsFclep885KkCTDQjmk8QKBgQC5C0vUPK51DaVE44v0aq3dR2qmf765Ly95jzHHgbtpps6JyAVu/SfTCq+IYaW1iZB/ePygmNaE5MJ8w9Rgyn0HXuuPnIlFKU/lrjhpGMw6JAbXIkk8XvpyqoDHyhe/bqZpFFNov/o9USsYOPZhUU/pQxv4T4/M/9eNQAgXOw3jXQKBgQCzqcCk9mpfH7VxNy480ICR05J4MdSKhPXvd9K/lxUBgcaxnSdp89tua+wWWu5888b/78dggq5BsWbSetLhpzvo28afq/9Z1XmsJm1f9kPfJt1kJurya4Mrg2CkX4vkbE+cizELULPtA91tSwVinpig7WPFvda+uktRei/Td+rZxQKBgQCuBiOgTBk92EFvkhgTGyi8C+gPAeCaQ/f/+F02ZZmdeNSQ213QzaBgZ5JBTqQLIH6Wg3ACkPpeLM2DjJ/1DzmabvhWLT8jngCX3ssKe9nFbBBKzuHVNvWOVS+btUG0NRmnhQgUYUez1twSga+kQlZG52gslJaGkq1jF68EOfOLuQKBgQCTefBseOlwE/M4b/dAbFZdXbKJfz3cRrAqVc1k/3t6tTCIc1v7GPUyetxcrV++qczcIdMjYaHwwtKIS9H28PO4fU9ZmjINZ7JsoU5+ywODlb99ioSpYZ9WhI074EJQyqe+9HLZuvE2yUllgYN2JIFc+ABCPUadYQaaZxYDHBhnkQKBgAg73YFWKQ74lIxS1lgF3x/HlCWM6acNui7Ncmk4X02cZJ7gRwsKsKYJEFcC60/amCh862eMLoSb5/hGu4cybGnVySub7IJaxsBt3ApZzJgNQ6jNVW+Jbp7FWXQfpVwps2R6FeWpocx93cLJ+wfFiicT525/nAP5xV9x0Czj63vz",
				"json", "utf-8",
				"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh4HxP2ufwp/fzecCiw75C88cJciixEZtHehnltw1QECeAr/j+vqey1dJpiFnWKTKJwUNqQ3yWzOotbIX+swLKGGvnQrQQ2k6ZOISl3BzlLsHUcyGQ9nbgLXwVbwZGDKt4GDNJWLbBpVtpse4remZbUmUfJJkLr4a9j9pCVShwSt0lTzOIPryu/Oy8SZMdPUZddn92AEoPFirdUC6US6bMH6F7+foTI99icDg4PgbTDoErnMdrVJ+nkYU9Xdypndm5047KQeHtvMG1VmoZ4yh4CS0V89GSMLv6+19qmQNzEDKH6uWyUur8BU6djfSxJycANKVEl0MlCV6/EE9ETeHGwIDAQAB",
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
