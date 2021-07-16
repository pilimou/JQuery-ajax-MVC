package com.web.store.config;

import java.beans.PropertyVetoException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
public class ServiceConfig {

	
	@Bean
	public ComboPooledDataSource datasource(){
		ComboPooledDataSource datasource = new ComboPooledDataSource();
        try {
			datasource.setDriverClass("com.mysql.cj.jdbc.Driver");
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
        datasource.setJdbcUrl("jdbc:mysql://localhost:3306/jdbcdb?useSSL=false&useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Taipei&allowPublicKeyRetrieval=true");
        datasource.setUser("root");
        datasource.setPassword("Do!ng123");
        datasource.setInitialPoolSize(4);
        datasource.setMaxPoolSize(8);
       
        return datasource;
	}
	
	@Bean
	public JdbcTemplate jdbcTemplate(){
		return new JdbcTemplate(datasource()); //Dependency Injection只需要呼叫方法即可
	}
}
