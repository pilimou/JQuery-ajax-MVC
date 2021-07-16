package com.web.store.dao.impl;

import java.lang.reflect.Field;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.SqlUpdate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.stereotype.Repository;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.web.store.dao.EmpDao;
import com.web.store.model.Employee;

@Repository
public class EmpDaoImp implements EmpDao{
	
	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	@Autowired
	ComboPooledDataSource ds;
	
	
	//依id查詢
	@Override
	public List<Employee> queryById(Object[] params) {
		String sql = "select * from employee where id = ?";
		RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<Employee>(Employee.class);		 
        return jdbcTemplate.query(sql, rowMapper, params);
	}
	
	//依id刪除
	@Override
	public int deleteEmp(Object[] params) {
		String sql = "delete from employee where id = ?";
		return jdbcTemplate.update(sql, params);
	}
	
	//新增之後拿回該筆新增資料的PK，再用PK撈出該筆完整資料
	@Override
	public List<Employee> insertEmp(Object[] params) {

		SqlUpdate insert = new SqlUpdate(ds, "insert into employee(name, addr, birthday, sex) values(?, ?, ?, ?)");
		insert.declareParameter(new SqlParameter("name",Types.VARCHAR));
		insert.declareParameter(new SqlParameter("addr",Types.VARCHAR));
		insert.declareParameter(new SqlParameter("birthday",Types.VARCHAR));
		insert.declareParameter(new SqlParameter("sex",Types.VARCHAR));
		insert.setReturnGeneratedKeys(true);
		insert.setGeneratedKeysColumnNames(new String[] {"id"});
		insert.compile();
		GeneratedKeyHolder keyHolder = new GeneratedKeyHolder();
		insert.update(params, keyHolder);
		 
        return queryById(new Long[] {keyHolder.getKey().longValue()});	
	}
	
	//查詢
	@Override
	public List<Employee> querEmp(Object obj) {

		Map<String, Object> queryData = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from Employee where 1=1 ");
		
		try {
			queryData = getQuerySQL(obj, sql);	
			RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<Employee>(Employee.class);		
			return jdbcTemplate.query((String)queryData.get("querySQL"), rowMapper, (Object[])queryData.get("queryParams"));
		} catch (IllegalAccessException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	
	//把物件的屬性和值取出判斷有哪些需要查詢
	public Map<String, Object> getQuerySQL(Object obj, StringBuffer sql) throws IllegalArgumentException, IllegalAccessException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<Object> valueList = new ArrayList<>(); //屬性如果有值,拿來暫時存放

		Class<?> cla = obj.getClass();
		Field[] fields = cla.getDeclaredFields();
		
		int i = 0;
		for(Field field : fields) {
			field.setAccessible(true);
			String keyName = field.getName();
			Object value = field.get(obj);
			
			if(keyName != "serialVersionUID" && keyName != "id" && value != null) {
				if(keyName.equals("name")) {
					sql.append(" and " + keyName + " like ? ");
					valueList.add("%" + value + "%");
				} else {
					sql.append(" and " + keyName + " = ? ");
					valueList.add(value);	
				}
				i++;
			}
		}
		
		Object[] params = new Object[i];
		params = valueList.toArray(params);
		
		map.put("querySQL" , sql.toString());
		map.put("queryParams", params);
		
		return map;
	}
	
	//修改
	@Override
	public List<Employee> updateEmp(Object[] params, int id) {
		String sql = "update employee set name = ? , addr = ? , birthday = ? , sex = ? where id = ?";
		jdbcTemplate.update(sql, params);
		return queryById(new Object[] {id});
	}

	

}
