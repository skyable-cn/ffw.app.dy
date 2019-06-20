package com.ffw.app.dy.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.app.dy.config.FileConfig;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.model.ReturnModel;
import com.ffw.app.dy.util.HttpUtils;
import com.ffw.app.dy.util.RestTemplateUtil;

import net.sf.json.JSONObject;

@Controller
public class ToutiaoController extends BaseController {

	@Autowired
	FileConfig fileConfig;

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/toutiao/user" })
	@ResponseBody
	public JSONObject index() {
		logger.info("获取用户信息");
		PageData pd = new PageData();
		pd = this.getPageData();
		String str = null;
		try {

			PageData market = new PageData();
			market.put("MARKET_ID", pd.getString("MARKET_ID"));
			market = rest.post(IConstant.FFW_SERVICE_KEY, "market/find", market, PageData.class);

			str = HttpUtils
					.get("https://developer.toutiao.com/api/apps/jscode2session?appid=" + market.getString("DYAPPID")
							+ "&secret=" + market.getString("DYAPPSECRET") + "&code=" + pd.getString("CODE"));
		} catch (Exception e) {

		}
		JSONObject obj = JSONObject.fromObject(str);
		return obj;
	}

	@RequestMapping(value = { "/system/init" })
	@ResponseBody
	public ReturnModel init() {
		logger.info("系统信息初始化");
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pdm = new PageData();
		pdm.put("WXOPEN_ID", pd.getString("WXOPEN_ID"));
		pdm = rest.post(IConstant.FFW_SERVICE_KEY, "member/findBy", pdm, PageData.class);
		if (null == pdm) {
			pd.put("MEMBERTYPE_ID", IConstant.STRING_1);
			pd.put("CLASS", "dy");
			pd.put("MARKET_ID", pd.getString("MARKET_ID"));
			pd.put("WAITACCOUNT", IConstant.STRING_0);
			pd.put("ALREADYACCOUNT", IConstant.STRING_0);
			if (null == pd.get("FROMWXOPEN_ID") || pd.getString("FROMWXOPEN_ID").equals("null")) {
				pd.remove("FROMWXOPEN_ID");
			}
			pd.put("CDT", DateUtil.getTime());
			rest.post(IConstant.FFW_SERVICE_KEY, "member/save", pd, PageData.class);
		} else {
			pdm.put("NICKNAME", pd.getString("NICKNAME"));
			pdm.put("SEX", pd.getString("SEX"));
			pdm.put("PHOTO", pd.getString("PHOTO"));
			pdm.put("SEX", pd.getString("SEX"));

			if (null != pd.get("FROMWXOPEN_ID") && !pd.getString("FROMWXOPEN_ID").equals("null")) {
				if (null == pdm.getString("FROMWXOPEN_ID") || StringUtils.isEmpty(pdm.getString("FROMWXOPEN_ID"))) {
					if (!pd.getString("FROMWXOPEN_ID").equals(pd.getString("WXOPEN_ID"))) {
						pdm.put("FROMWXOPEN_ID", pd.getString("FROMWXOPEN_ID"));
					}
				}
			}
			rest.post(IConstant.FFW_SERVICE_KEY, "member/edit", pdm, PageData.class);
		}
		return new ReturnModel();
	}

}
