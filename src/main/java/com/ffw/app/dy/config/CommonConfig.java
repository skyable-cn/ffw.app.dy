package com.ffw.app.dy.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.filter.DelegatingFilterProxy;

import com.ffw.app.dy.filter.CommonFilter;



@Configuration
public class CommonConfig {

	@Bean(name = "messageSource")
	public ResourceBundleMessageSource resourceBundleMessageSource() {
		ResourceBundleMessageSource resourceBundleMessageSource = new ResourceBundleMessageSource();
		resourceBundleMessageSource.setDefaultEncoding("UTF-8");
		resourceBundleMessageSource.setBasename("i18n/messages");
		return resourceBundleMessageSource;

	}

	@Bean
	public CommonFilter commonFilter() {
		return new CommonFilter();
	}

	@Bean
	public FilterRegistrationBean testFilterRegistration() {

		FilterRegistrationBean registration = new FilterRegistrationBean();
		registration.setFilter(new DelegatingFilterProxy("commonFilter"));
		registration.addUrlPatterns("/*");
		registration.setName("commonFilter");
		registration.setOrder(1);
		return registration;
	}
}
