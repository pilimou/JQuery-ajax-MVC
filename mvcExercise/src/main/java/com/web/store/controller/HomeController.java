package com.web.store.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	//查詢(page)
	@RequestMapping("/queryEmpPage/{page}")
	public String queryEmpTest(@RequestBody Employee emp, HttpServletResponse response, @PathVariable int page) throws IOException {
		sendJson(response, empService.getQueryEmpPage(emp, page));
		return null;
	}
	
	//查詢
	@RequestMapping("/queryEmp")
	public String queryEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.getQueryEmp(emp));
		return null;
	}
	
	//新增
	@RequestMapping("/insertEmp")
	public String insertEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.setInsertEmp(
				new String[] {emp.getName(),emp.getAddr(),emp.getBirthday(),emp.getSex()}));
		return null;
	}
	
	//修改
	@RequestMapping("/updateEmp")
	public String updateEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.setUpdateEmp(
				new Object[] {emp.getName(),emp.getAddr(),emp.getBirthday(),emp.getSex(),emp.getId()}, emp.getId()));				
		return null;
	}
	
	//刪除
	@RequestMapping("/deleteEmp")
	public String deleteEmp(@RequestBody Employee emp, HttpServletResponse response) throws IOException {
		sendJson(response, empService.setDeleteEmp(new Integer[] {emp.getId()}));
		return null;
	}
	
	@RequestMapping("/")
	public String home(Model model) {
		return "index";
	}
	
	@RequestMapping("/index")
	public String home2(Model model) {
		return "index";
	}
	
	@RequestMapping("/version_3")
	public String version_3(Model model) {
		return "version_3";
	}
	
	@RequestMapping("/version_2")
	public String version_2(Model model) {
		return "version_2";
	}
	
	@RequestMapping("/version_1")
	public String version_1(Model model) {
		return "version_1";
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
