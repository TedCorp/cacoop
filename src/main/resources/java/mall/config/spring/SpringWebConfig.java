package mall.config.spring;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.accept.PathExtensionContentNegotiationStrategy;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.xml.MarshallingView;

import com.google.common.util.concurrent.AbstractScheduledService.Scheduler;

import mall.common.interceptor.AdminLoginCheckInterceptor;
import mall.common.interceptor.UserLoginCheckInterceptor;
import mall.web.domain.Customers;

@Configuration
@PropertySource(value={"classpath:/system.properties"}, ignoreResourceNotFound=true)
@EnableWebMvc
@EnableAsync
@EnableScheduling
@EnableTransactionManagement
@ComponentScan(basePackages="mall.web")
@EnableAspectJAutoProxy(proxyTargetClass=true)
public class SpringWebConfig extends WebMvcConfigurerAdapter {	

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		registry.addResourceHandler("/template/**").addResourceLocations("/template/");
		registry.addResourceHandler("/layout/**").addResourceLocations("/layout/");
	}
	
	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
		configurer.favorPathExtension(true)
			.ignoreAcceptHeader(true)
			.useJaf(false)
			.mediaType("xml", MediaType.APPLICATION_XML)
			.mediaType("atom", MediaType.APPLICATION_ATOM_XML)
			.mediaType("html", MediaType.TEXT_HTML)
			.mediaType("json", MediaType.APPLICATION_JSON_UTF8)
			.defaultContentType(MediaType.TEXT_HTML)
			.favorParameter(false)
			.favorPathExtension(true);
	}
	
	@Bean(name="pathExtensionContentNegotiationStrategy")
	public PathExtensionContentNegotiationStrategy pathExtensionContentNegotiationStrategy() {
		Map<String, MediaType> mediaTypes = new HashMap<String, MediaType>();
		mediaTypes.put("xml", MediaType.APPLICATION_XML);
		mediaTypes.put("atom",  MediaType.APPLICATION_ATOM_XML);
		mediaTypes.put("html",  MediaType.TEXT_HTML);
		mediaTypes.put("json",  MediaType.APPLICATION_JSON_UTF8);
		
		PathExtensionContentNegotiationStrategy pathExtensionContentNegotiationStrategy = new PathExtensionContentNegotiationStrategy(mediaTypes);
		return pathExtensionContentNegotiationStrategy;
	}
	
	@Bean(name="contentNegotiationManager")
	public ContentNegotiationManager ContentNegotiationManager() {
		return new ContentNegotiationManager(pathExtensionContentNegotiationStrategy());
	}
	
	@Bean(name="contentNegotiationViewResolver")
	public ViewResolver contentNegotiatingViewResolver() {
		ContentNegotiatingViewResolver contentNegotiationViewResolver = new ContentNegotiatingViewResolver();
		contentNegotiationViewResolver.setContentNegotiationManager(ContentNegotiationManager());
		
		List<ViewResolver> viewResolvers = new ArrayList<ViewResolver>();
		viewResolvers.add(urlBasedViewResolver());
		viewResolvers.add(internalResourceViewResolver());
		viewResolvers.add(beanNameViewResolver());
		contentNegotiationViewResolver.setViewResolvers(viewResolvers);
		
		List<View> defaultViews = new ArrayList<View>();
		defaultViews.add(mappingJackson2JsonView());
		defaultViews.add(marshallingView());
		contentNegotiationViewResolver.setDefaultViews(defaultViews);
		
		return contentNegotiationViewResolver;
	}
	
	@Bean(name="urlBasedViewResolver")
	public UrlBasedViewResolver urlBasedViewResolver() {
		UrlBasedViewResolver urlBasedViewResolver = new UrlBasedViewResolver();
		urlBasedViewResolver.setViewClass(TilesView.class);
		urlBasedViewResolver.setOrder(1);
		return urlBasedViewResolver;
	}
	
	@Bean(name="internalResourceViewResolver")
	public InternalResourceViewResolver internalResourceViewResolver() {
		InternalResourceViewResolver internetResourceViewResolver = new InternalResourceViewResolver();
		internetResourceViewResolver.setViewClass(JstlView.class);
		internetResourceViewResolver.setPrefix("/WEB-INF/jsp/");
		internetResourceViewResolver.setSuffix(".jsp");
		internetResourceViewResolver.setOrder(2);
		return internetResourceViewResolver;
	}
	
	@Bean(name="beanNameViewResolver")
	public BeanNameViewResolver beanNameViewResolver() {
		BeanNameViewResolver beanNameViewResolver = new BeanNameViewResolver();
		beanNameViewResolver.setOrder(3);
		return beanNameViewResolver;
	}
	
	@Bean(name="mappingJackson2JsonView")
	public View mappingJackson2JsonView() {
		MappingJackson2JsonView mappingJackson2JsonView = new MappingJackson2JsonView();
		return mappingJackson2JsonView;
	}
	
	@Bean(name="marshallingView")
	public View marshallingView() {
		Jaxb2Marshaller jaxb2Marshaller = new Jaxb2Marshaller();
		jaxb2Marshaller.setClassesToBeBound(Customers.class);
		MarshallingView marshallingView = new MarshallingView(jaxb2Marshaller);
		return marshallingView;
	}
	
	@Bean(name="resourceBundleMessageSource")
	public MessageSource resourceBundleMessageSource() {
		// ReloadableResourceBundleMessageSource resourceBundleMessageSource = new ReloadableResourceBundleMessageSource();
		ResourceBundleMessageSource resourceBundleMessageSource = new ResourceBundleMessageSource();
		resourceBundleMessageSource.setBasename("locale/messages");
		resourceBundleMessageSource.setUseCodeAsDefaultMessage(true);
		resourceBundleMessageSource.setDefaultEncoding("UTF-8");
		resourceBundleMessageSource.setCacheSeconds(60);
		return resourceBundleMessageSource;
	}
	
	@Bean(name="localeResolver")
	public LocaleResolver localeResolver() {
		SessionLocaleResolver resolver = new SessionLocaleResolver();
		resolver.setDefaultLocale(Locale.KOREAN);
		// Asia/Seoul : 서울 
		// UTC : Universal Time Coordinated : 세계협정시
		resolver.setDefaultTimeZone(TimeZone.getTimeZone("UTC"));
		
		/* 쿠키기준 로케일 설정 (세션이 끊겨도 브라우저 쿠키 기준으로 설정)
		CookieLocaleResolver resolver = new CookieLocaleResolver();
		resolver.setDefaultLocale(Locale.KOREAN);
		resolver.setCookieName("LocaleCookie");
		resolver.setCookieMaxAge(4800);
		*/
		return resolver;
	}
	@Bean
	public CommonsMultipartResolver multipartResolver() throws IOException {
		/* tomcat context 설정 추가 allowCasualMultipartParsing="true" */
		CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
		commonsMultipartResolver.setDefaultEncoding("UTF-8");
		commonsMultipartResolver.setMaxUploadSize(20480000);
		commonsMultipartResolver.setMaxInMemorySize(20480000);
		commonsMultipartResolver.setMaxUploadSizePerFile(20480000);
		commonsMultipartResolver.setUploadTempDir(new FileSystemResource("/tmp"));
		return commonsMultipartResolver;
	}
    
	@Bean(name="mailSender")
	public JavaMailSenderImpl javaMailSenderImpl() {
		Properties javaMailProperties = new Properties();
		javaMailProperties.setProperty("mail.smtp.auth", "true");
		javaMailProperties.setProperty("mail.smtp.starttls.enable",  "true");
		
		JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
		javaMailSender.setHost("smtp.gmail.com");
		javaMailSender.setPort(587);
		javaMailSender.setUsername("");
		javaMailSender.setPassword("");
		javaMailSender.setDefaultEncoding("UTF-8");
		javaMailSender.setJavaMailProperties(javaMailProperties);
		
		return javaMailSender;
	}
	
	@Bean(name="tilesConfigurer")
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer tilesConfigurer = new TilesConfigurer();
		tilesConfigurer.setDefinitions("/WEB-INF/tiles/*.xml");
		tilesConfigurer.setCheckRefresh(true);
		return tilesConfigurer;
	}

	@Bean(name="localeChangeInterceptor")
	public LocaleChangeInterceptor localeChangeInterceptor() {
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		localeChangeInterceptor.setParamName("lang");
		return localeChangeInterceptor;
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(localeChangeInterceptor());
		registry.addInterceptor(adminLoginCheckInterceptor()).addPathPatterns("/adm/**").excludePathPatterns("/adm/loginForm");
		registry.addInterceptor(userLoginCheckInterceptor()).addPathPatterns("/**").excludePathPatterns("/adm/**");
	}
	
	@Bean
	public AdminLoginCheckInterceptor adminLoginCheckInterceptor(){
		AdminLoginCheckInterceptor adminInterceptor = new AdminLoginCheckInterceptor(); 
		return adminInterceptor; 
	}
	@Bean
	public UserLoginCheckInterceptor userLoginCheckInterceptor(){
		UserLoginCheckInterceptor userInterceptor = new UserLoginCheckInterceptor(); 
		return userInterceptor; 
	}
	@Bean
	public TaskScheduler scheduler() {
		ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
		scheduler.setPoolSize(10);
		return scheduler;
	}
	
}
