package com;

import javax.servlet.ServletContext;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.multipart.support.MultipartFilter;

public class Securityinitializer extends AbstractSecurityWebApplicationInitializer{

	protected void beforeSpringSecurityFilterChain(ServletContext servletContext) {

		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
		characterEncodingFilter.setForceEncoding(true);
		insertFilters(servletContext,characterEncodingFilter);
		
		MultipartFilter multipartFilter = new MultipartFilter();
		multipartFilter.setMultipartResolverBeanName("multipartResolver");
		insertFilters(servletContext,multipartFilter);
		
	}
	
	

}
