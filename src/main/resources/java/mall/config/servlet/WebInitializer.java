package mall.config.servlet;

import java.util.EnumSet;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.apache.commons.fileupload.servlet.FileCleanerCleanup;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.filter.HttpPutFormContentFilter;
import org.springframework.web.multipart.support.MultipartFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import mall.config.filter.ErrorHandlerFilter;
import mall.config.orm.MyBatisDevConfiguration;
import mall.config.orm.MyBatisProdConfiguration;
import mall.config.spring.SpringWebConfig;

public class WebInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
	
	/**
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Class	: mall.config.servlet.WebInitializer.java
	 * @Method	: onStartup
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @Desc	: 설명입력
	 * @Company	: YT Corp.
	 * @Author	: Your Name (your@email.com)
	 * @Date	: 2016-07-13 (오후 9:07:47)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	 * @see org.springframework.web.servlet.support.AbstractDispatcherServletInitializer#onStartup(javax.servlet.ServletContext)
	 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	*/
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
		super.onStartup(servletContext);
		
		// Define profile active mode
		servletContext.setInitParameter("spring.profiles.active",  "dev");
		
		rootContext.setDisplayName("식자재 쇼핑몰");
		
		// JSTL Formatter
		servletContext.setInitParameter("javax.servlet.jsp.jstl.fmt.locale", "ko_KR");
		servletContext.addListener(FileCleanerCleanup.class);
		
		// Manage the lifecycle of the root application
		servletContext.addListener(new ContextLoaderListener(rootContext));
		servletContext.setInitParameter("defaultHtmlEscape",  "true");

		// Filters
		registerCharacterEncodingFilter(servletContext);
		
		//registerMultipartFilter(servletContext);
		
		registerHiddenHttpMethodFilter(servletContext);
	}

	@Override
	protected String getServletName() {
		return "dispatcherServlet";
	}
	
	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class [] {
				SpringWebConfig.class,
				MyBatisDevConfiguration.class,
				MyBatisProdConfiguration.class
		};
	}

	@Override
	protected String[] getServletMappings() {
		return new String [] {"/"};
	}
	
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class [] {
		};
	}

	@Override
	protected Filter[] getServletFilters() {
		return new Filter [] {
				new ErrorHandlerFilter(),
				new HttpPutFormContentFilter()
		};
	}
	
	@Override
	protected boolean isAsyncSupported() {
		return true;
	}
	
	private void registerHiddenHttpMethodFilter(ServletContext servletContext) {
		HiddenHttpMethodFilter hiddenHttpMethodFilter = new HiddenHttpMethodFilter();
		FilterRegistration.Dynamic httpMethodFilter = servletContext.addFilter("httpMethodFilter",  hiddenHttpMethodFilter);
		httpMethodFilter.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST),  true,  "/*");
	}

	private void registerMultipartFilter(ServletContext servletContext) {
		MultipartFilter multipartFilter = new MultipartFilter();
		multipartFilter.setMultipartResolverBeanName("multipartResolver");
		FilterRegistration.Dynamic multipart = servletContext.addFilter("multipartFilter", multipartFilter);
		multipart.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");
	}

	private void registerCharacterEncodingFilter(ServletContext servletContext) {
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
		characterEncodingFilter.setForceEncoding(true);
		FilterRegistration.Dynamic characterEncoding = servletContext.addFilter("characterEncodingFilter", characterEncodingFilter);
		characterEncoding.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");
	}
}
