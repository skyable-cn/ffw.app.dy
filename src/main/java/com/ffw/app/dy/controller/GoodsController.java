package com.ffw.app.dy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ffw.api.model.PageData;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.util.RestTemplateUtil;

@Controller
public class GoodsController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/goods/info" })
	public ModelAndView info() {
		logger.info("进入商品详情");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String FROMWXOPEN_ID = pd.getString("fromopenid");
		mv.addObject("FROMWXOPEN_ID", FROMWXOPEN_ID);

		pd = rest.post(IConstant.FFW_SERVICE_KEY, "goods/find", pd, PageData.class);

		PageData pdp = new PageData();
		pdp.put("GOODS_ID", pd.getString("GOODS_ID"));
		List<PageData> peopleDataList = rest.postForList(IConstant.FFW_SERVICE_KEY, "ordersitem/listAllPeople", pdp,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("peopleDataList", peopleDataList);

		PageData pds = new PageData();
		pds.put("SHOP_ID", pd.getString("SHOP_ID"));
		pds = rest.post(IConstant.FFW_SERVICE_KEY, "shop/find", pds, PageData.class);
		mv.addObject("shop", pds);

		PageData pdm3 = new PageData();
		pdm3.put("REFERENCE_ID", pd.getString("GOODS_ID"));
		pdm3.put("FILETYPE", IConstant.STRING_1);
		List<PageData> fileDataList = rest.postForList(IConstant.FFW_SERVICE_KEY, "file/listAll", pdm3,
				new ParameterizedTypeReference<List<PageData>>() {
				});
		mv.addObject("fileDataList", fileDataList);

		mv.addObject("pd", pd);
		mv.setViewName("goods/info");
		return mv;
	}

}
