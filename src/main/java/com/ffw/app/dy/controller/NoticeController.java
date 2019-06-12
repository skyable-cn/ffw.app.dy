package com.ffw.app.dy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ffw.api.model.PageData;
import com.ffw.api.util.DateUtil;
import com.ffw.app.dy.constant.IConstant;
import com.ffw.app.dy.model.ReturnModel;
import com.ffw.app.dy.util.RestTemplateUtil;

@Controller
public class NoticeController extends BaseController {

	@Autowired
	RestTemplateUtil rest;

	@RequestMapping(value = { "/notice/listAllUnRead" })
	@ResponseBody
	public List<PageData> sellerSave() throws Exception {
		logger.info("查询未读通知");
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdn = new PageData();
		pdn.put("MARKET_ID", marketId());
		pdn.put("MEMBER_ID", memberId());
		List<PageData> noticeData = rest.postForList(IConstant.FFW_SERVICE_KEY, "notice/listAllUnRead", pdn,
				new ParameterizedTypeReference<List<PageData>>() {
				});

		return noticeData;
	}

	@RequestMapping(value = { "/notice/saveRecord" })
	@ResponseBody
	public ReturnModel recordSave() {
		logger.info("进入订单核销信息保存");
		ReturnModel rm = new ReturnModel();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MEMBER_ID", memberId());
		pd.put("SCDT", DateUtil.getTime());
		pd = rest.post(IConstant.FFW_SERVICE_KEY, "notice/saveRecord", pd, PageData.class);
		return rm;
	}
}
