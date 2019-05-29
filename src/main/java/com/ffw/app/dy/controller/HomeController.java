package com.ffw.app.dy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.app.dy.util.RestTemplateUtil;

@Controller
public class HomeController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/home" })
	public ModelAndView index() {
		logger.info("进入首页");
		ModelAndView mv = new ModelAndView();

		mv.setViewName("home/index");
		mv.addObject("nav", "home");
		return mv;
	}

}
