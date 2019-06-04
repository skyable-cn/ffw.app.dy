package com.ffw.app.dy.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.app.dy.config.FileConfig;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.model.ReturnModel;
import com.ffw.app.dy.util.RestTemplateUtil;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

@Controller
public class OrdersController extends BaseController {

	@Autowired
	FileConfig fileConfig;

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/goBuy" })
	public ModelAndView index() {
		logger.info("进入立即购买");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String FROMWXOPEN_ID = pd.getString("FROMWXOPEN_ID");
		mv.addObject("FROMWXOPEN_ID", FROMWXOPEN_ID);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "goods/find", pd, PageData.class);
		mv.addObject("pd", pd);

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		pd2.put("STATE", IConstant.STRING_0);
		List<PageData> cardsData = rest.postForList(IConstant.FFW_SERVICE_KEY, "cards/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("cardsData", cardsData);

		mv.addObject("ZSFLAG", IConstant.STRING_0);
		if (DateUtil.getWeek() == 4) {
			mv.addObject("ZSFLAG", IConstant.STRING_1);
		}

		PageData vipinfo = new PageData();
		vipinfo.put("MEMBER_ID", memberId());
		vipinfo = rest.post(IConstant.FFW_SERVICE_KEY, "vipinfo/findBy", vipinfo, PageData.class);
		mv.addObject("vipinfo", vipinfo);

		PageData pd1 = new PageData();
		List<PageData> product = rest.postForList(IConstant.FFW_SERVICE_KEY, "product/listAll", pd1,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("product", product.get(0));

		mv.setViewName("orders/index");
		return mv;
	}

	@RequestMapping(value = { "/orders/save" })
	@ResponseBody
	public ReturnModel sellerSave() throws Exception {
		logger.info("提交订单保存");
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("CLASS", IConstant.STRING_CLASS_DY);

		String CARD_ID = pd.getString("CARD_ID");
		String GOODS_ID = pd.getString("GOODS_ID");
		String NUMBER = pd.getString("NUMBER");

		String VIPMONEY = pd.getString("VIPMONEY");
		if (!VIPMONEY.equals("0")) {
			pd.put("VIPFLAG", IConstant.STRING_1);
		} else {
			pd.put("VIPFLAG", IConstant.STRING_0);
		}

		String ORDERSN = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + randomNumber(5);
		pd.put("ORDERSN", ORDERSN);
		pd.put("MEMBER_ID", memberId());
		pd.put("CDT", DateUtil.getTime());
		pd.put("USEID", DigestUtils.md5Hex(ORDERSN + IConstant.KEY_SLAT));
		pd.put("USEKEY", randomNumber(8));
		if (Double.parseDouble(pd.getString("MONEY")) > 0) {
			pd.put("STATE", IConstant.STRING_0);
		} else {
			pd.put("STATE", IConstant.STRING_1);

			if (!VIPMONEY.equals("0")) {
				PageData pd1 = new PageData();
				List<PageData> product = rest.postForList(IConstant.FFW_SERVICE_KEY, "product/listAll", pd1,
						new ParameterizedTypeReference<List<PageData>>() {
						});

				PageData pd0 = new PageData();
				pd0.put("RECHARGESN", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + randomNumber(5));
				pd0.put("PRODUCT_ID", product.get(0).getString("PRODUCT_ID"));
				pd0.put("MEMBER_ID", memberId());
				pd0.put("ORIGINAL", product.get(0).getString("PRODUCTMONEY"));
				pd0.put("MONEY", product.get(0).getString("PRODUCTMONEY"));
				pd0.put("DERATE", IConstant.STRING_0);
				pd0.put("CDT", DateUtil.getTime());
				pd0.put("STATE", IConstant.STRING_1);
				rest.post(IConstant.FFW_SERVICE_KEY, "recharge/save", pd0, PageData.class);

				PageData pd2 = new PageData();
				pd2.put("VIPSN", DateUtil.getNumber());
				pd2.put("MEMBER_ID", memberId());
				pd2.put("CDT", DateUtil.getTime());
				pd2.put("LASTTIME", DateUtil.getAfterDayDate(product.get(0).getString("PRODUCTTIME")));
				rest.post(IConstant.FFW_SERVICE_KEY, "vipinfo/save", pd2, PageData.class);

				PageData pd21 = new PageData();
				pd21.put("MEMBER_ID", memberId());
				pd21 = rest.post(IConstant.FFW_SERVICE_KEY, "member/find", pd21, PageData.class);
				if (IConstant.STRING_1.equals(pd21.getString("MEMBERTYPE_ID"))) {
					pd21.put("MEMBERTYPE_ID", IConstant.STRING_2);
					rest.post(IConstant.FFW_SERVICE_KEY, "member/edit", pd21, PageData.class);
				} else if (IConstant.STRING_3.equals(pd21.getString("MEMBERTYPE_ID"))) {
					pd21.put("MEMBERTYPE_ID", IConstant.STRING_4);
					rest.post(IConstant.FFW_SERVICE_KEY, "member/edit", pd21, PageData.class);
				} else {

				}
			}

			PageData pdg = new PageData();
			pdg.put("GOODS_ID", GOODS_ID);
			pdg = rest.post(IConstant.FFW_SERVICE_KEY, "goods/find", pdg, PageData.class);
			pdg.put("BUYNUMBER", Integer.parseInt(pdg.getString("BUYNUMBER")) + Integer.parseInt(NUMBER));
			rest.post(IConstant.FFW_SERVICE_KEY, "goods/edit", pdg, PageData.class);

		}

		ReturnModel rm = new ReturnModel();
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "orders/save", pd, PageData.class);
		rm.setFlag(true);
		rm.setMessage(getMessage("MSG_CODE_ADD_SUCCESS", new Object[] { "订单" }, ""));
		rm.setData(pd);

		PageData pdc = new PageData();
		pdc.put("CARD_ID", CARD_ID);
		pdc.put("STATE", IConstant.STRING_1);
		pdc.put("ORDER_ID", pd.getString("ORDER_ID"));
		rest.post(IConstant.FFW_SERVICE_KEY, "cards/edit", pdc, PageData.class);

		PageData pdoi = new PageData();
		pdoi.put("ORDER_ID", pd.getString("ORDER_ID"));
		pdoi.put("GOODS_ID", GOODS_ID);
		pdoi.put("NUMBER", NUMBER);
		rest.post(IConstant.FFW_SERVICE_KEY, "ordersitem/save", pdoi, PageData.class);

		return rm;
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

	@RequestMapping(value = { "/orders/waitpay" })
	public ModelAndView waitPay() {
		logger.info("进入待支付");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		pd2.put("STATE", IConstant.STRING_0);
		List<PageData> ordersData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("ordersData", ordersData);

		mv.setViewName("orders/waitpay");
		return mv;
	}

	@RequestMapping(value = { "/orders/payed" })
	public ModelAndView payed() {
		logger.info("进入已支付");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		pd2.put("STATE", IConstant.STRING_1);
		List<PageData> ordersData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("ordersData", ordersData);

		mv.setViewName("orders/payed");
		return mv;
	}

	@RequestMapping(value = { "/orders/waituse" })
	public ModelAndView waitUse() {
		logger.info("进入待使用");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		pd2.put("STATE", IConstant.STRING_2);
		List<PageData> ordersData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("ordersData", ordersData);

		mv.setViewName("orders/waituse");
		return mv;
	}

	@RequestMapping(value = { "/orders/waitrecive" })
	public ModelAndView waitRecive() {
		logger.info("进入待收货");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		pd2.put("STATE", IConstant.STRING_11);
		List<PageData> ordersData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("ordersData", ordersData);

		mv.setViewName("orders/waitrecive");
		return mv;
	}

	@RequestMapping(value = { "/orders/waitrate" })
	public ModelAndView waitRate() {
		logger.info("进入待评价");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		pd2.put("STATE", IConstant.STRING_3);
		List<PageData> ordersData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("ordersData", ordersData);

		mv.setViewName("orders/waitrate");
		return mv;
	}

	@RequestMapping(value = { "/orders/complate" })
	public ModelAndView waitUsed() {
		logger.info("进入已完成");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		pd2.put("SQLCONDITION", " and os.STATE IN ( '4' , '5' ) ");
		List<PageData> ordersData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("ordersData", ordersData);

		mv.setViewName("orders/complate");
		return mv;
	}

	@RequestMapping(value = { "/orders/all" })
	public ModelAndView all() {
		logger.info("进入全部订单");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		pd2.put("MEMBER_ID", memberId());
		List<PageData> ordersData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("ordersData", ordersData);

		mv.setViewName("orders/all");
		return mv;
	}

	@RequestMapping(value = { "/orders/useinfo" })
	public ModelAndView complate() {
		logger.info("进入订单确认信息");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "orders/find", pd, PageData.class);
		mv.addObject("pd", pd);

		mv.setViewName("orders/useinfo");
		return mv;
	}

	@RequestMapping(value = { "/orders/useinfo/save" })
	@ResponseBody
	public ReturnModel complateSave() {
		logger.info("进入订单确认信息保存");
		ReturnModel rm = new ReturnModel();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STATE", IConstant.STRING_2);
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "orders/edit", pd, PageData.class);
		rm.setFlag(true);
		rm.setData(pd);
		return rm;
	}

	@RequestMapping(value = { "/orders/refund" })
	public ModelAndView refund() {
		logger.info("进入订单退款信息");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd2 = new PageData();
		List<PageData> refundTypeData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAllRefund", pd2,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("refundTypeData", refundTypeData);
		mv.addObject("pd", pd);

		mv.setViewName("orders/refund");
		return mv;
	}

	@RequestMapping(value = { "/orders/refund/save" })
	@ResponseBody
	public Map<String, String> refundSave() {
		logger.info("进入订单退款信息保存");
		PageData pd = new PageData();
		pd = this.getPageData();

		Map<String, String> refund = new HashMap<String, String>();

		return refund;
	}

	@RequestMapping(value = { "/orders/info" })
	public ModelAndView info() {
		logger.info("进入订单详情");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData order = new PageData();
		order.put("ORDER_ID", pd.getString("ORDER_ID"));
		order = rest.post(IConstant.FFW_SERVICE_KEY, "orders/find", order, PageData.class);

		PageData pdu = new PageData();
		pdu.put("ORDER_ID", pd.getString("ORDER_ID"));
		List<PageData> useData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orderuse/listAll", pdu,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("useData", useData);

		mv.addObject("order", order);

		mv.setViewName("orders/info");
		return mv;
	}

	@RequestMapping(value = { "/orders/barcode" })
	public void barcode() throws Exception {
		logger.info("进入条码生成");
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData order = new PageData();
		order.put("USEID", pd.getString("USEID"));
		order = rest.post(IConstant.FFW_SERVICE_KEY, "orders/findBy", order, PageData.class);

		PageData orderOUT = new PageData();
		orderOUT.put("USEID", order.getString("USEID"));
		orderOUT.put("USEKEY", DigestUtils.md5Hex(order.getString("USEKEY") + IConstant.KEY_SLAT));

		int width = 200; // 图像宽度
		int height = 200; // 图像高度
		String format = "png";// 图像类型
		Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		hints.put(EncodeHintType.MARGIN, 1);
		BitMatrix bitMatrix = new MultiFormatWriter().encode(JSONObject.toJSONString(orderOUT), BarcodeFormat.QR_CODE,
				width, height, hints);// 生成矩阵
		MatrixToImageWriter.writeToStream(bitMatrix, format, getResponse().getOutputStream());
	}

	@RequestMapping(value = { "/orders/verification" })
	public ModelAndView use() {
		logger.info("进入订单核销确认");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData order = new PageData();
		order.put("USEID", pd.getString("USEID"));
		order = rest.post(IConstant.FFW_SERVICE_KEY, "orders/findBy", order, PageData.class);

		if (!pd.getString("SHOP_ID").equals(order.getString("SHOP_ID"))) {
			order = null;
		}

		if (pd.getString("FROM").equals("CODE")) {
			pd.put("USEKEY", DigestUtils.md5Hex(pd.getString("USEKEY") + IConstant.KEY_SLAT));
		}

		if (null != order
				&& !pd.getString("USEKEY").equals(DigestUtils.md5Hex(order.getString("USEKEY") + IConstant.KEY_SLAT))) {
			order = null;
		}
		mv.addObject("order", order);
		mv.setViewName("orders/verification");
		return mv;
	}

	@RequestMapping(value = { "/orders/verification/info" })
	@ResponseBody
	public ReturnModel verificationInfo() {
		logger.info("进入订单核销信息查询");
		ReturnModel rm = new ReturnModel();
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData rs = new PageData();
		PageData order = new PageData();
		order.put("USEID", pd.getString("USEID"));
		order = rest.post(IConstant.FFW_SERVICE_KEY, "orders/findBy", order, PageData.class);
		if (null != order) {
			rs.put("STATE", order.getString("STATE"));
		}

		rm.setFlag(true);
		rm.setData(rs);
		return rm;
	}

	@RequestMapping(value = { "/orders/verification/save" })
	@ResponseBody
	public ReturnModel verificationSave() {
		logger.info("进入订单核销信息保存");
		ReturnModel rm = new ReturnModel();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STATE", IConstant.STRING_3);
		pd.put("UDT", DateUtil.getTime());
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "orders/edit", pd, PageData.class);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "orders/find", pd, PageData.class);

		PageData pdu = new PageData();
		pdu.put("ORDER_ID", pd.getString("ORDER_ID"));
		pdu.put("SHOP_ID", pd.getString("SHOP_ID"));
		pdu.put("MEMBER_ID", memberId());
		pdu.put("CDT", DateUtil.getTime());
		rest.post(IConstant.FFW_SERVICE_KEY, "orderuse/save", pdu, PageData.class);

		PageData shop = new PageData();
		shop.put("SHOP_ID", pd.getString("SHOP_ID"));
		shop = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", shop, PageData.class);

		PageData pds = new PageData();
		pds.put("SHOP_ID", pd.getString("SHOP_ID"));

		Double addMoney = Integer.parseInt(pd.getString("NUMBER")) * Double.parseDouble(pd.getString("BALANCEMONEY"));

		pds.put("WAITACCOUNT", Double.parseDouble(shop.getString("WAITACCOUNT")) + addMoney);
		rest.post(IConstant.FFW_SERVICE_KEY, "shop/edit", pds, PageData.class);

		PageData pdst = new PageData();
		pdst.put("ORDER_ID", pd.getString("ORDER_ID"));
		pdst.put("SETTLEMONEY", String.valueOf(addMoney));
		pdst.put("CDT", DateUtil.getTime());
		rest.post(IConstant.FFW_SERVICE_KEY, "settle/save", pdst, PageData.class);

		rm.setFlag(true);
		rm.setData(pd);
		return rm;
	}
}
