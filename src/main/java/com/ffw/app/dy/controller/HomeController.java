package com.ffw.app.dy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.Page;
import com.ffw.api.model.PageData;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.util.RestTemplateUtil;

@Controller
public class HomeController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/home" })
	public ModelAndView index() {
		logger.info("进入首页");
		ModelAndView mv = new ModelAndView();

		if (null == getSession().getAttribute(IConstant.STRING_SHOW_FLAG)) {
			mv.addObject("showNotice", "yes");
			getSession().setAttribute(IConstant.STRING_SHOW_FLAG, IConstant.STRING_SHOW_FLAG);
		} else {
			mv.addObject("showNotice", "no");
		}

		mv.setViewName("home/index");
		mv.addObject("nav", "home");
		return mv;
	}

	@RequestMapping(value = { "/home/search" })
	@ResponseBody
	public PageData indexSearch() {
		logger.info("进入首页查询");
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pd1 = new PageData();
		pd1.put("keywords", pd.getString("keywords"));
		pd1.put("MARKET_ID", marketId());
		pd1.put("DYFLAG", IConstant.STRING_1);
		pd1.put("STATE", IConstant.STRING_1);
		pd1.put("SEARCHTYPE", IConstant.STRING_1);
		pd1.put("page_currentPage", pd.getString("page_currentPage"));
		Page page = rest.post(IConstant.FFW_SERVICE_KEY, "goods/listPage", pd1, Page.class);

		pd.put("page", page);
		return pd;
	}

}
