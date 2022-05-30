package mall.config.orm;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.AutoMappingBehavior;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.LocalCacheScope;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

@Configuration
@MapperScan("mall.web.mapper")
@PropertySource(value={"classpath:/jdbc.prod.properties"}, ignoreResourceNotFound=true)
@Profile("prod")
public class MyBatisProdConfiguration implements InitializingBean {
	
	@Autowired
	private Environment environment;
	
	@Override
	public void afterPropertiesSet() throws Exception {
	}
	
	@Bean(name="dataSource", destroyMethod="close")
	public DataSource dataSource() {
		BasicDataSource dataSource = new BasicDataSource();

		dataSource.setDriverClassName(environment.getRequiredProperty("jdbc.driverClass"));
		dataSource.setUrl(environment.getRequiredProperty("jdbc.url"));
		dataSource.setUsername(environment.getRequiredProperty("jdbc.username"));
		dataSource.setPassword(environment.getRequiredProperty("jdbc.password"));
		dataSource.setMaxIdle(10);
		dataSource.setMaxWaitMillis(1000);
		dataSource.setDefaultAutoCommit(true);
		
		return dataSource;
	}
	
	@Bean(name="transactionManager")
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
	@Bean(name="sqlSessionFactory")
	public SqlSessionFactory sqlSessionFactoryBean(DataSource dataSource, ApplicationContext applicationContext) throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource);
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:mall/sql/**/*.xml"));
		sqlSessionFactoryBean.setTypeAliasesPackage("mall.web.domain");
		
		sqlSessionFactoryBean.getObject().getConfiguration().setCacheEnabled(true);		
		sqlSessionFactoryBean.getObject().getConfiguration().setLazyLoadingEnabled(true);
		sqlSessionFactoryBean.getObject().getConfiguration().setAggressiveLazyLoading(true);
		sqlSessionFactoryBean.getObject().getConfiguration().setMultipleResultSetsEnabled(true);
		sqlSessionFactoryBean.getObject().getConfiguration().setUseColumnLabel(true);
		sqlSessionFactoryBean.getObject().getConfiguration().setUseGeneratedKeys(false);
		sqlSessionFactoryBean.getObject().getConfiguration().setAutoMappingBehavior(AutoMappingBehavior.PARTIAL);
		sqlSessionFactoryBean.getObject().getConfiguration().setDefaultExecutorType(ExecutorType.SIMPLE);
		sqlSessionFactoryBean.getObject().getConfiguration().setDefaultStatementTimeout(25000);
		sqlSessionFactoryBean.getObject().getConfiguration().setMapUnderscoreToCamelCase(true);
		sqlSessionFactoryBean.getObject().getConfiguration().setLocalCacheScope(LocalCacheScope.SESSION);
		sqlSessionFactoryBean.getObject().getConfiguration().setJdbcTypeForNull(JdbcType.NULL);
				
		return sqlSessionFactoryBean.getObject();
	}
	
	@Bean(name="sqlSessionTemplate")
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory, ExecutorType.SIMPLE);
		return sqlSessionTemplate;
	}
}
