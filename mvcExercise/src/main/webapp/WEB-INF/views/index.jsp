<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>Insert title here</title>
</head>
<body>
	<button id="dialog-querybtn" >查詢</button>
	<button id="diqlog-insertbtn" >新增</button>
	
	<hr>
	<div id="showData"></div>	
	
	
	<!-- 查詢-彈出視窗 -->
	<div id="dialog-query" style="display:none">
		<div id="nameText">
			<a>姓名:</a><input id="queryName" type="text" size="10">
		</div>
		<div id="sexCheckbox">
			<ul>
				<li><input class="sex" type="checkbox" value="男"  name="sexGroup">男<br></li>
				<li><input class="sex" type="checkbox" value="女" name="sexGroup">女<br></li>
			</ul>
		</div>		
	</div>
	
	<!-- 新增-彈出視窗 -->
	<div id="dialog-insert" style="display:none">
		<div id="insertText">
			<a>姓名:</a><input id="insertName" type="text" size="10"><br>
			<a>地址:</a><input id="insertAddr" type="text" size="10"><br>
			<a>生日:</a><input id="insertBirthday" type="text" size="10"><br>
			<a>性別:</a><input id="insertSex" type="text" size="10"><br>
			<input id="insertId" type="text" size="10" style="display:none">
		</div>
	</div>
	
	<!-- 刪除-彈出視窗 -->
	<div id="dialog-delete">
		
	</div>
	
	<!-- 修改-彈出視窗 -->
	<div id="dialog-update" style="display:none">
		<div id="updateText">
			<a>姓名:</a><input id="updatetName" type="text" size="10"><br>
			<a>地址:</a><input id="updateAddr" type="text" size="10"><br>
			<a>生日:</a><input id="updateBirthday" type="text" size="10"><br>
			<a>性別:</a><input id="updateSex" type="text" size="10"><br>
			<input id="updateId" type="text" size="10" style="display:none">
		</div>
	</div>

<!-- JQuery	 -->

	<script>
	
	//checkbox單選
	$('#checkboxGroup li input').click(function(){
		if($(this).prop('checked')){
			$('#checkboxGroup li input:checkbox').prop('checked',false);
			$(this).prop('checked',true);
		}
	});
	
//============================= 彈出視窗 ===============================
	
	//查詢-彈出視窗
	$('#dialog-querybtn').click(function(){
		$('#dialog-querybtn').show();
		$('#dialog-query').dialog({
			buttons:{
				"Send":function(){
					
					//搜尋條件
					var Employee = new Object();				
					Employee.sex = $(":checkbox:checked").val();
					Employee.name = $("#queryName").val();

					//ajax
					initSubmitForm("queryEmp", Employee);				

					$(this).dialog("close");
				},
				"Close":function(){$(this).dialog("close");}
			}
		});
	});
	
	//新增-彈出視窗
	$('#diqlog-insertbtn').click(function(){
		$('#dialog-insertbtn').show();
		$('#insertId').attr("style","display:none");
		$('#dialog-insert').dialog({
			buttons:{
				"Send": function(){
					
					//新增的資料
					var Employee = new Object();
					Employee.name = $("#insertName").val();
					Employee.addr = $("#insertAddr").val();
					Employee.birthday = $("#insertBirthday").val();
					Employee.sex = $("#insertSex").val();

					//ajax
					initSubmitForm("insertEmp", Employee);
					
					$(this).dialog("close");
				},
				
				"Close":function(){$(this).dialog("close");}
			}
		});
		
	});

	//刪除-彈出視窗
	$('#showData').on('click','.deleteBtn',function(){
		var pkId = $(this).parent().parent().attr('id');
		$('#dialog-delete').dialog({
			title: "DeleteConfirm",
			buttons:{
				"Send": function(){  

					//刪除的資料
					var Employee = new Object();
					Employee.id = pkId;

					//ajax
					initSubmitForm("deleteEmp", Employee, pkId);
					
					$(this).dialog("close");
				},
				"Close":function(){$(this).dialog("close");}
			}
		});			
	});

	//修改-彈出視窗
	$('#showData').on('click','.updateBtn',function(){
		var pkId = $(this).parent().parent().attr('id'); //該筆資料<tr>的ID

		var td_length = $('#'+ pkId + ' td').length - 2; //該筆資料有幾個欄位(扣除兩個按鈕)

		var i;
		for(i = 0; i < td_length; i++){
			var tdData = $('#'+ pkId + ' td:eq(' + i + ')').text(); //TD資料
			$('#updateText').find('input').eq(i).val(tdData); 		//把TD資料放入修改彈出視窗
		}
		$('#updateText').find('input').eq(i).val(pkId);				//最後放入隱藏的ID
		
		$('#dialog-update').dialog({
			title: "updateConfirm",
			buttons:{
				"Send": function(){  

					//修改的資料
					var Employee = new Object();
					Employee.name = $('#updateText').find('input').eq(0).val();
					Employee.addr = $('#updateText').find('input').eq(1).val();
					Employee.birthday = $('#updateText').find('input').eq(2).val();
					Employee.sex = $('#updateText').find('input').eq(3).val();
					Employee.id = $('#updateText').find('input').eq(4).val();
					
// 					for(var i = 0; i < td_length + 1; i++){ //多加一個ID欄位要送
// 						$('#updateText').find('input').eq(i).val();
// 					}		

					//ajax
					initSubmitForm("updateEmp", Employee, pkId);
					
					$(this).dialog("close");
				},
				"Close":function(){$(this).dialog("close");}
			}
		});			
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
                  if(processURL == "deleteEmp"){
                  	deleteDataMapping(pkId);
                  }
                  
                  if(processURL == "insertEmp"){
                    insertDataMapping(data);
                  }
                  
                  if(processURL == "queryEmp"){
                    queryDataMapping(data);
                  }

				  if(processURL == "updateEmp"){
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
		var htmlSegment = "<table border='1'>";
		htmlSegment += "<tr><th>姓名</th><th>地址</th><th>生日</th><th>性別</th><th>修改</th><th>刪除</th>";

		for(var i = 0; i < empList.length; i++){
			var emp = empList[i];
			htmlSegment += "<tr id=\"" + emp.id + "\">" + "<td>" + emp.name + "</td>"
						+ "<td>" + emp.addr + "</td>"
						+ "<td>" + emp.birthday + "</td>"
						+ "<td>" + emp.sex + "</td>" 
						+ "<td>" + "<button class=\"updateBtn\">修改</button>" + "</td>" 
						+ "<td>" + "<button class=\"deleteBtn\">刪除</button>" + "</td>"
						+ "</tr>";
							
		}

		htmlSegment += "</table>";
		showData.innerHTML = htmlSegment;

	};	

    //新增-解包json寫入標籤資料
	function insertDataMapping(data){
		var empList = JSON.parse(data);
		var htmlSegment = "";

		for(var i = 0; i < empList.length; i++){
			var emp = empList[i];
			htmlSegment += "<tr id=\"" + emp.id + "\">" + "<td>" + emp.name + "</td>"
						+ "<td>" + emp.addr + "</td>"
						+ "<td>" + emp.birthday + "</td>"
						+ "<td>" + emp.sex + "</td>" 
						+ "<td>" + "<button class=\"updateBtn\">修改</button>" + "</td>" 
						+ "<td>" + "<button class=\"deleteBtn\">刪除</button>" + "</td>"
						+ "</tr>";						
		}
			
		$("table:last").append(htmlSegment); //加到原有資料後面
			
	};	
		
	//ajax刪除成功後再刪除畫面上的資料
	function deleteDataMapping(pkId){
		$("#"+pkId).remove();
	}	
		
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
	
	</script>
</body>
</html>