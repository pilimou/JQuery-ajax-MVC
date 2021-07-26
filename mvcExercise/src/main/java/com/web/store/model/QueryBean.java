package com.web.store.model;

import java.io.Serializable;
import java.util.List;

public class QueryBean implements Serializable{
	private static final long serialVersionUID = 1L;
	
	int queryCount;
	int countPerPage;
	List<Employee> employee;
	
	public QueryBean() {

	}

	public QueryBean(int queryCount, int countPerPage, List<Employee> employee) {
		super();
		this.queryCount = queryCount;
		this.countPerPage = countPerPage;
		this.employee = employee;
	}
	
	
	public int getQueryCount() {
		return queryCount;
	}
	public void setQueryCount(int queryCount) {
		this.queryCount = queryCount;
	}
	
	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public List<Employee> getEmployee() {
		return employee;
	}
	public void setEmployee(List<Employee> employee) {
		this.employee = employee;
	}
	
}
