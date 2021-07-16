package com.web.store.dao;

import java.util.List;

import com.web.store.model.Employee;

public interface EmpDao {
	List<Employee> queryById(Object[] params);
	
	List<Employee> querEmp(Object obj);
	
	List<Employee> insertEmp(Object[] params);
	
	List<Employee> updateEmp(Object[] params, int id);
	
	int deleteEmp(Object[] params);
}
