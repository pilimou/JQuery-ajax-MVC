package com.web.store.model;

import java.io.Serializable;

public class Employee implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String name;
	private String addr;
	private String birthday;
	private String sex;
	private int id;
	
	
	
	
	
	public Employee(String name, String addr, String birthday, String sex, int id) {
		super();
		this.name = name;
		this.addr = addr;
		this.birthday = birthday;
		this.sex = sex;
		this.id = id;
	}

	public Employee() {

	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
	
	

}
