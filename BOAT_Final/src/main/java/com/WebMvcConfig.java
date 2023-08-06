package com;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{

private static final String[] CLASSPATH_RESOURCE_LOCATIONS
	= {
			"classpath:/static/",
			"classpath:/resources/",
			"classpath:/META-INF/resources"
			
	};
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		//url mapping"/"로 접속하면 "/memeber/login"로 이동합니다.
		registry.addViewController("/").setViewName("forword:/mainpage");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**")
		.addResourceLocations(CLASSPATH_RESOURCE_LOCATIONS);
	}

	
	

}
