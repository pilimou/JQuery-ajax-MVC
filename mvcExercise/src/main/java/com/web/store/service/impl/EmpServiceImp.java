package com.web.store.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.store.dao.EmpDao;
import com.web.store.model.Employee;
import com.web.store.model.QueryBean;
import com.web.store.service.EmpService;

@Service
@Transactional
public class EmpServiceImp implements EmpService {
	
	@Autowired
	EmpDao empDao;
	
	//新增
	@Override
	public List<Employee> setInsertEmp(Object[] params) {
		List<Employee> beans = empDao.insertEmp(params);
		return beans;
	}
	
	//刪除
	@Override
	public int setDeleteEmp(Object[] params) {
		int deleteRows = empDao.deleteEmp(params);
		return deleteRows;
	}
	
	//查詢
	@Override
	public List<Employee> getQueryEmp(Object obj) {
		List<Employee> beans = empDao.querEmp(obj);
		return beans;
	}
	
	//修改
	@Override
	public List<Employee> setUpdateEmp(Object[] params, int id) {
		List<Employee> beans = empDao.updateEmp(params, id);
		return beans;
	}
	
	//查詢(筆數和資料)
	@Override
	public QueryBean getQueryEmpPage(Object obj, int page) {
		List<Employee> beans = empDao.queryEmpPage(obj, page); //資料
		int queryCount = empDao.queryCount(obj); 	//總資料筆數
		int countPerPage = 5;						//每頁顯示筆數
		return new QueryBean(queryCount, countPerPage, beans);
	}

}
