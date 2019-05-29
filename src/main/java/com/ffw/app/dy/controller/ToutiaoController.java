package com.ffw.app.dy.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ffw.api.model.PageData;
import com.ffw.app.dy.config.ToutiaoMiniConfig;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.model.ReturnModel;
import com.ffw.app.dy.util.HttpUtils;
import com.ffw.app.dy.util.RestTemplateUtil;

import net.sf.json.JSONObject;

@Controller
public class ToutiaoController extends BaseController {

	@Autowired
	ToutiaoMiniConfig toutiaoMiniConfig;

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
			str = HttpUtils
					.get("https://developer.toutiao.com/api/apps/jscode2session?appid=" + toutiaoMiniConfig.getAppid()
							+ "&secret=" + toutiaoMiniConfig.getAppsecret() + "&code=" + pd.getString("CODE"));
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
			pd.put("WAITACCOUNT", IConstant.STRING_0);
			pd.put("ALREADYACCOUNT", IConstant.STRING_0);
			if (null == pd.get("FROMWXOPEN_ID") || pd.getString("FROMWXOPEN_ID").equals("null")) {
				pd.remove("FROMWXOPEN_ID");
			}

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
