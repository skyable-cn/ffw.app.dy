package com.ffw.app.dy.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "toutiao.mini")
public class ToutiaoMiniConfig {

	private String appid;

	private String appsecret;

	private String mchid;

	private String mchkey;

	private String noticeurl;

	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getAppsecret() {
		return appsecret;
	}

	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}

	public String getMchid() {
		return mchid;
	}

	public void setMchid(String mchid) {
		this.mchid = mchid;
	}

	public String getMchkey() {
		return mchkey;
	}

	public void setMchkey(String mchkey) {
		this.mchkey = mchkey;
	}

	public String getNoticeurl() {
		return noticeurl;
	}

	public void setNoticeurl(String noticeurl) {
		this.noticeurl = noticeurl;
	}

}
