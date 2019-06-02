package com.ffw.app.dy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.app.dy.util.RestTemplateUtil;

@Controller
public class MyController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/my" })
	public ModelAndView index() {
		logger.info("进入我的");
		ModelAndView mv = new ModelAndView();

		mv.setViewName("my/index");
		mv.addObject("nav", "my");
		return mv;
	}
}
