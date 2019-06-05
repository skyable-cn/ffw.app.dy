package com.ffw.app.dy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.api.util.DoubleUtil;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.model.ReturnModel;
import com.ffw.app.dy.util.RestTemplateUtil;

@Controller
public class MyController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/my" })
	public ModelAndView index() {
		logger.info("进入我的");
		ModelAndView mv = new ModelAndView();

		PageData old = (PageData) getSession().getAttribute(IConstant.USER_SESSION);
		old = rest.post(IConstant.FFW_SERVICE_KEY, "member/find", old, PageData.class);
		getSession().setAttribute(IConstant.USER_SESSION, old);

		mv.setViewName("my/index");
		mv.addObject("nav", "my");
		return mv;
	}

	@RequestMapping(value = { "/my/account" })
	public ModelAndView indexAccount() {
		logger.info("进入我的钱包");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("FROMWXOPEN_ID", userSession().getString("WXOPEN_ID"));
		pd.put("SQLCONDITION", " and os.GIVEMONEY is not null ");

		pd.put("CLASS", IConstant.STRING_CLASS_DY);
		List<PageData> orderData = rest.postForList(IConstant.FFW_SERVICE_KEY, "orders/listAll", pd,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("orderData", orderData);

		mv.setViewName("my/account");

		return mv;
	}

	@RequestMapping(value = { "/withdraw/save" })
	@ResponseBody
	public ReturnModel complateSave() {
		logger.info("进入提现信息保存");
		ReturnModel rm = new ReturnModel();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MEMBER_ID", memberId());
		pd.put("CDT", DateUtil.getTime());
		pd.put("STATE", IConstant.STRING_0);
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "withdraw/save", pd, PageData.class);

		PageData pdm = new PageData();
		pdm.put("MEMBER_ID", memberId());
		pdm.put("WAITACCOUNT", String.valueOf(DoubleUtil.sub(Double.parseDouble(userSession().getString("WAITACCOUNT")),
				Double.parseDouble(pd.getString("MONEY")))));
		pdm.put("ALREADYACCOUNT",
				String.valueOf(DoubleUtil.sum(Double.parseDouble(userSession().getString("ALREADYACCOUNT")),
						Double.parseDouble(pd.getString("MONEY")))));
		rest.post(IConstant.FFW_SERVICE_KEY, "member/edit", pdm, PageData.class);

		rm.setFlag(true);
		rm.setData(pd);
		return rm;
	}
}
