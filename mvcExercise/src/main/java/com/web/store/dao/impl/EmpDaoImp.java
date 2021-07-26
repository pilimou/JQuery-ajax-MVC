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
	

	int countPerPage = 5;
	
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
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from employee where 1=1 ");
		
		Map<String, Object> queryData = null; //key:querySQL ,key:queryParams
		queryData = getQuerySQL_2(obj, sql);	
		RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<Employee>(Employee.class);
		return jdbcTemplate.query((String)queryData.get("querySQL"), rowMapper, (Object[])queryData.get("queryParams"));
		
	}
	
	//查詢(page)
	@Override
	public List<Employee> queryEmpPage(Object obj, int page) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from employee where 1=1 ");
		
		Map<String, Object> queryData = null; 
		queryData = getQuerySQL_2(obj, sql);	//key:querySQL ,key:queryParams
		
		int limitStart = ((page - 1) * countPerPage);
		int limitEnd = countPerPage;
		
		String sqlStr = (String)queryData.get("querySQL") + " order by id limit " + limitStart + "," + limitEnd;

		RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<Employee>(Employee.class);
		return jdbcTemplate.query(sqlStr, rowMapper, (Object[])queryData.get("queryParams"));
	}
	
	//把物件的屬性和值取出判斷有哪些需要查詢(第二種)
	public Map<String, Object> getQuerySQL_2(Object obj, StringBuffer sql){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Object> valueList = new ArrayList<>(); //屬性如果有值,拿來暫時存放
		
		Employee emp = new Employee();
		emp = (Employee) obj;

		if (emp.getName() != null && !emp.getName().equals("")) {
			sql.append(" and name like ? ");
			valueList.add("%" + emp.getName() + "%");
		}
		
		if (emp.getAddr() != null && !emp.getAddr().equals("")) {
			sql.append(" and addr = ? ");
			valueList.add(emp.getAddr());
		}
		
		if (emp.getBirthday() != null && !emp.getBirthday().equals("")) {
			sql.append(" and birthday = ? ");
			valueList.add(emp.getBirthday());
		}
		
		if (emp.getSex() != null && !emp.getSex().equals("")) {
			sql.append(" and sex = ? ");
			valueList.add(emp.getSex());
		}
		
		Object[] params = new Object[valueList.size()];
		params = valueList.toArray(params);
		
		map.put("querySQL", sql.toString());
		map.put("queryParams", params);
		
		return map;
	}
	
	//把物件的屬性和值取出判斷有哪些需要查詢(第一種)
	public Map<String, Object> getQuerySQL(Object obj, StringBuffer sql) throws IllegalArgumentException, IllegalAccessException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<Object> valueList = new ArrayList<>(); //屬性如果有值,拿來暫時存放

		Class<?> cla = obj.getClass();
		
		//java.lang.Class類別的getDeclaredFields()方法用於獲取此類別的字段
		//Class.getDeclaredFields()返回 Field 物件的一個數組，該陣列包含此 Class 物件所表示的類別或介面所宣告的所有欄位（包括私有成員）。
		Field[] fields = cla.getDeclaredFields();
		
		for(Field field : fields) {
			
			//Field繼承自AccessibleObject類，AccessibleObject是Field、Method、Constuctor類的父類。
			//簡單理解意思就是 如果類型是private修飾的，你不可以直接訪問，就需要設置訪問權限為true.如果是public則不需要設置。
			//set和get調用的時候都需要確保可以訪問，不然如果不能訪問拋出IllegalAccessException。
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
			}
		}
		
		Object[] params = new Object[valueList.size()];
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
	
	//查詢總筆數
	@Override
	public int queryCount(Object obj) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from Employee where 1=1 ");
		Map<String, Object> queryData = null; //key:querySQL ,key:queryParams
		queryData = getQuerySQL_2(obj, sql);	
		return jdbcTemplate.queryForObject((String)queryData.get("querySQL"), (Object[])queryData.get("queryParams"), Integer.class);
	}

	

	

}
