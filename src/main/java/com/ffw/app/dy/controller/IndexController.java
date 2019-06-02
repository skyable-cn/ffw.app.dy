package com.ffw.app.dy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController extends BaseController {

	@RequestMapping(value = { "/index" })
	public ModelAndView index() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/home");
		return mv;
	}

	@RequestMapping(value = { "/mini" })
	public ModelAndView mini() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mini/index");
		return mv;
	}

}
