package com.web.store.service;

import java.util.List;

import com.web.store.model.Employee;

public interface EmpService {
	
	List<Employee> setUpdateEmp(Object[] params, int id);
	
	List<Employee> getQueryEmp(Object obj);
	
	List<Employee> setInsertEmp(Object[] params);
	
	int setDeleteEmp(Object[] params);
	
}
