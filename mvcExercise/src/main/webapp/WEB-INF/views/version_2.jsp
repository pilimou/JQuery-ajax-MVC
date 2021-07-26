<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<title>ajax+bootstrap</title>
</head>
<body>
	
	
	<button class="btn-primary" data-bs-toggle="modal" data-bs-target="#queryModal">查詢</button>
	<button class="btn-primary" data-bs-toggle="modal" data-bs-target="#insertModal">新增</button>
	<button id="cleanData">清除</button>
	<a href="index">回首頁</a>
	<hr>
	<div id="showData" style="width:80%"></div>	
	
	
	<!-- 查詢-彈出視窗 -->
	<div class="modal fade" id="queryModal" tabindex="-1" aria-labelledby="queryModalLabel" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title" id="queryModalLabel">查詢</h5>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			
      			<div class="modal-body">
      				<div class="input-group mb-3">
  						<span class="input-group-text" id="query-addon1">姓名</span>
  						<input id="queryName" type="text" class="form-control" placeholder="name" aria-label="name" aria-describedby="basic-addon1">
					</div>
					<div id="sexQueryRadio">
						<ul>
							<li><input class="sex" type="radio" value="男"  name="sexGroup">男<br></li>
							<li><input class="sex" type="radio" value="女" name="sexGroup">女<br></li>
						</ul>
					</div>
					<button id="cleanQuery">清除資料</button>
      			</div>
      			
      			<div class="modal-footer">
        			<button id="dialog-querybtn" type="button" class="btn btn-primary" data-bs-dismiss="modal">Send</button>
       				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<!-- 新增-彈出視窗 -->
	<div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true" style="z-index:8888">
  		<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title" id="insertModalLabel">新增</h5>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			
      			<div class="modal-body">
        			<div id="insertText">
        				<div class="input-group flex-nowrap">
  							<span class="input-group-text" id="insert-addon1">姓名</span>
  							<input id="insertName" type="text" class="form-control" placeholder="name" aria-label="name" aria-describedby="addon-wrapping">
						</div>
        				<div class="input-group flex-nowrap">
  							<span class="input-group-text" id="insert-addon2">地址</span>
  							<input id="insertAddr" type="text" class="form-control" placeholder="address" aria-label="address" aria-describedby="addon-wrapping">
						</div>
        				<div class="input-group flex-nowrap">
        					<span class="input-group-text" id="insert-addon3">生日</span>
  							<input id="insertBirthday" type="text" class="form-control dateSelect" placeholder="birthday" aria-label="birthday" aria-describedby="addon-wrapping" readonly="readonly" style="background-color:#ffffff;">
        				</div>
        				<div class="input-group flex-nowrap">
        					<span class="input-group-text" id="insert-addon4">性別</span>
  							<input id="insertSex" type="text" class="form-control" placeholder="sex" aria-label="sex" aria-describedby="addon-wrapping">
        				</div>
						<input id="insertId" type="text" size="10" style="display:none">
					</div>
      			</div>
      			
      			<div class="modal-footer">
        			<button id="dialog-insertbtn" type="button" class="btn btn-primary" data-bs-dismiss="modal">Send</button>
       				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	
	
	<!-- 刪除-彈出視窗 -->
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title" id="deleteModalLabel">刪除</h5>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			
      			<div class="modal-body">
        			<div id="deleteText">
        				<a>確定刪除?</a>
						<input id="deleteId" type="text" size="10" style="display:none">
					</div>
      			</div>
      			
      			<div class="modal-footer">
        			<button id="dialog-deletebtn" type="button" class="btn btn-danger" data-bs-dismiss="modal">Send</button>
       				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<div id="dialog-delete">
		
	</div>
	
	<!-- 修改-彈出視窗 -->
	<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true" style="z-index:8888">
  		<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title" id="updateModalLabel">修改</h5>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
      			
      			<div class="modal-body">
        			<div id="updateText">
        				<div class="input-group flex-nowrap">
  							<span class="input-group-text" id="update-addon1">姓名</span>
  							<input id="updateName" type="text" class="form-control" placeholder="name" aria-label="name" aria-describedby="addon-wrapping">
						</div>
        				<div class="input-group flex-nowrap">
  							<span class="input-group-text" id="update-addon2">地址</span>
  							<input id="updateAddr" type="text" class="form-control" placeholder="address" aria-label="address" aria-describedby="addon-wrapping">
						</div>
        				<div class="input-group flex-nowrap">
        					<span class="input-group-text" id="update-addon3">生日</span>
  							<input id="updateBirthday" type="text" class="form-control dateSelect" placeholder="birthday" aria-label="birthday" aria-describedby="addon-wrapping" readonly="readonly" style="background-color:#ffffff;">
        				</div>
        				<div class="input-group flex-nowrap">
        					<span class="input-group-text" id="update-addon4">性別</span>
  							<input id="updateSex" type="text" class="form-control" placeholder="sex" aria-label="sex" aria-describedby="addon-wrapping" style="z-index: 100000;">
        				</div>
						<input id="updateId" type="text" size="10" style="display:none">
					</div>
      			</div>
      			
      			<div class="modal-footer">
        			<button id="dialog-updatebtn" type="button" class="btn btn-primary" data-bs-dismiss="modal">Send</button>
       				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	
   
	
	

<!-- JQuery	 -->

	<script>

	//日期選擇器
	$(function() {
	    $( ".dateSelect" ).datepicker({
	      dateFormat: 'yy/mm/dd',
	      changeMonth: true,
	      changeYear: true,
	      beforeShow:function(input) { 
	            $(input).css({ 
	                "position": "relative", 
	                "z-index": 999999 
	            }); 
	        } 
	    });
	 });
	
//============================= 彈出視窗 ===============================
	
	//查詢送出
	$('#dialog-querybtn').click(function(){
		

		//查詢條件
		var Employee = new Object();				
// 		$('input[name=sexGroup]:checked').val();
		Employee.sex = $(":radio:checked").val();
		Employee.name = $("#queryName").val();
		
		//ajax
		initSubmitForm("queryEmp", Employee);
		
	});

	//清除查詢條件
	$("#cleanQuery").click(function(){
		$("#queryName").val("");
		$("input[name='sexGroup']").prop("checked",false);
	});
	
	//新增送出
	$('#dialog-insertbtn').click(function(){

		//新增的資料
		var Employee = new Object();
		Employee.name = $("#insertName").val();
		Employee.addr = $("#insertAddr").val();
		Employee.birthday = $("#insertBirthday").val();
		Employee.sex = $("#insertSex").val();

		//ajax
		initSubmitForm("insertEmp", Employee);
		
	});
	

	//刪除-寫入彈出視窗的資料
	$('#showData').on('click','.deleteBtn',function(){
		var pkId = $(this).parent().parent().attr('id'); //該筆資料<tr>的id
		$("#deleteId").val(pkId);  //隱藏欄位寫入id
	});

	//刪除送出
	$("#dialog-deletebtn").click(function(){
		
		//刪除的資料
		var Employee = new Object();
		Employee.id = $("#deleteId").val();

		//ajax
		initSubmitForm("deleteEmp", Employee, Employee.id);
	});
	

	//修改-寫入彈出視窗的資料
	$('#showData').on('click','.updateBtn',function(){
		var pkId = $(this).parent().parent().attr('id'); //該筆資料<tr>的ID
		var td_length = $('#'+ pkId + ' td').length - 2; //該筆資料有幾個欄位(扣除兩個按鈕)

		var i;
		for(i = 0; i < td_length; i++){
			var tdData = $('#'+ pkId + ' td:eq(' + i + ')').text(); //TD資料
			$('#updateText').find('input').eq(i).val(tdData); 		//把TD資料放入修改彈出視窗
		}
		$('#updateText').find('input').eq(i).val(pkId);				//最後放入隱藏的ID
	});

	//修改送出 
	$("#dialog-updatebtn").click(function(){
		
		//修改的資料
		var Employee = new Object();
		Employee.name = $('#updateText').find('input').eq(0).val();
		Employee.addr = $('#updateText').find('input').eq(1).val();
		Employee.birthday = $('#updateText').find('input').eq(2).val();
		Employee.sex = $('#updateText').find('input').eq(3).val();
		Employee.id = $('#updateText').find('input').eq(4).val();

		//ajax
		initSubmitForm("updateEmp", Employee, Employee.id);

	});		
	

//=========================== ajax交換資料 ===================================

	//ajax傳送接收json
	function initSubmitForm(processURL, processData, pkId) {
          $.ajax({
              url: "/mvcExercise/" + processURL + "/",
              type: "POST",
              datatype: "json",
              contentType: "application/json; charset=utf-8",
              traditional:true,
              data: JSON.stringify(processData),
              success: function(data) {
				
                  //成功後判斷要給哪隻方法處理
              	if("deleteEmp" === processURL){
                  	
                	deleteDataMapping(pkId);
                	
                } else if("insertEmp" === processURL){
                    
                	insertDataMapping(data);	
                	
                } else if("queryEmp" === processURL){

                	queryDataMapping(data);
                	
                } else if("updateEmp" === processURL){

                	updateDataMapping(data);
                	
                }
                              
                  console.log(data);
              },
              error: function(XMLHttpRequest, status, error) {
                  console.log(error)
              }
          })
      };
	
//===========================解包json寫入標籤資料=============================	
	
	//查詢-解包json寫入標籤資料
	function queryDataMapping(data){
		$(".empData").remove();
		var empList = JSON.parse(data);
		var htmlSegment = "<table class=\"table table-hover table-sm\">";
		htmlSegment += theadData();			//組合表格欄位
		htmlSegment += "<tbody id=\"empList\">";
		for(var i = 0; i < empList.length; i++){
			var emp = empList[i];
			htmlSegment += tbodyData(emp);	//組合標籤資料					
		}
		htmlSegment += "</tbody>";
		htmlSegment += "</table>";
		$("#showData").html(htmlSegment);

	};	

    //新增-解包json寫入標籤資料
	function insertDataMapping(data){
		var empList = JSON.parse(data);
		var htmlSegment = "";

		if($("#empList").length > 0){     //如果已經有查詢資料
			for(var i = 0; i < empList.length; i++){
				var emp = empList[i];
				
				htmlSegment = tbodyData(emp);  //組合標籤資料
			}
			$("#empList").append(htmlSegment); //加到原有資料後面
		} else {			//如果畫面上沒資料就先建立表格
			
			htmlSegment += "<table class=\"table table-hover table-sm\">";
			htmlSegment += theadData();			//組合表格欄位
			
			htmlSegment += "<tbody id=\"empList\">";
			for(var i = 0; i < empList.length; i++){
				var emp = empList[i];
				htmlSegment += tbodyData(emp);	//組合標籤資料					
			}
			htmlSegment += "</tbody>";
			
			htmlSegment += "</table>";
			$("#showData").html(htmlSegment);
		}
		
			
	};	
		
	//ajax刪除成功後再刪除畫面上的資料
	function deleteDataMapping(pkId){
		$("#"+pkId).remove();
	}	

	//ajax修改成功後再修改畫面上的資料	
	function updateDataMapping(data){
		var empList = JSON.parse(data);
		var td_length = $('#'+ pkId + ' td').length - 2; //該筆資料有幾個欄位(扣除兩個按鈕)
		
		for(var i = 0; i < empList.length; i++){
			var emp = empList[i];
			var pkId = emp.id;
			$('#'+ pkId + ' td:eq(0)').text(emp.name); 
			$('#'+ pkId + ' td:eq(1)').text(emp.addr); 
			$('#'+ pkId + ' td:eq(2)').text(emp.birthday);	
			$('#'+ pkId + ' td:eq(3)').text(emp.sex);		
		}	
	}

	//清除畫面資料
	$("#cleanData").click(function(){
		$("#showData").html("");
	});
	
	//組合表格欄位
	function theadData(){
		var htmlSegment = "<thead class=\"table-light\"><tr>"
						+  "<th class=\"col-1\" scope=\"col\">姓名</th>"
						+  "<th class=\"col-4\" scope=\"col\">地址</th>"
						+  "<th class=\"col-2\" scope=\"col\">生日</th>"
						+  "<th class=\"col-1\" scope=\"col\">性別</th>"
						+  "<th class=\"col-1\" scope=\"col\">修改</th>"
						+  "<th class=\"col-1\" scope=\"col\">刪除</th>"
						+  "</tr></thead>";
		return htmlSegment
	}
	
	//組合標籤資料
	function tbodyData(emp){
		var htmlSegment = "<tr id=\"" + emp.id + "\">" + "<td>" + emp.name + "</td>"
						+ "<td>" + emp.addr + "</td>"
						+ "<td>" + emp.birthday + "</td>"
						+ "<td>" + emp.sex + "</td>" 
						+ "<td>" + "<button class=\"updateBtn\" data-bs-toggle=\"modal\" data-bs-target=\"#updateModal\">修改</button>" + "</td>" 
						+ "<td>" + "<button class=\"deleteBtn btn-danger\" data-bs-toggle=\"modal\" data-bs-target=\"#deleteModal\">刪除</button>" + "</td>"
						+ "</tr>";
		return htmlSegment;					
	}

	
	</script>
	
<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
</body>
</html>