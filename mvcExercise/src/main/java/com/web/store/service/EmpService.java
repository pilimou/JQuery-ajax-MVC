package com.web.store.service;

import java.util.List;

import com.web.store.model.Employee;
import com.web.store.model.QueryBean;

public interface EmpService {
	
	List<Employee> setUpdateEmp(Object[] params, int id);
	
	List<Employee> getQueryEmp(Object obj);
	
	List<Employee> setInsertEmp(Object[] params);
	
	QueryBean getQueryEmpPage(Object obj, int page);
	
	int setDeleteEmp(Object[] params);
	
}
