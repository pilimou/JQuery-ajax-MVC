package com.web.store.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.store.model.Employee;
import com.web.store.service.EmpService;

@Controller
public class HomeController {

	@Autowired
	EmpService empService;
	
	//查詢
	@RequestMapping("/queryEmp")
	public String queryEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.getQueryEmp(emp));
		return "index";
	}
	
	//新增
	@RequestMapping("/insertEmp")
	public String insertEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.setInsertEmp(
				new String[] {emp.getName(),emp.getAddr(),emp.getBirthday(),emp.getSex()}));
		return "index";
	}
	
	//修改
	@RequestMapping("/updateEmp")
	public String updateEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.setUpdateEmp(
				new Object[] {emp.getName(),emp.getAddr(),emp.getBirthday(),emp.getSex(),emp.getId()}, emp.getId()));				
		return "index";
	}
	
	//刪除
	@RequestMapping("/deleteEmp")
	public String deleteEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.setDeleteEmp(new Integer[] {emp.getId()}));
		return "index";
	}
	
	@RequestMapping("/")
	public String home(Model model) {
		return "index";
	}
	
	//轉成json
	public void sendJson(HttpServletResponse response,Object o) throws IOException {
		ObjectMapper objectMapper = new ObjectMapper();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String json = objectMapper.writeValueAsString(o);
		out.write(json);
		out.flush();
		out.close();
		
	}

	

	
}
