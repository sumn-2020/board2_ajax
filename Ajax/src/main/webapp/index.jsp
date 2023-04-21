<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<script>
	var request = new XMLHttpRequest();
	function searchFunction() {
		request.open("Post", "./UserSearchServlet?userName=" + encodeURIComponent(document.getElementById("userName").value), true); // 요청: UserSearchServlet으로 userName이라는 아이디값을 가진 input에 적힌 텍스트를 파라미터 값으로 보내기 
		request.onreadystatechange = searchProcess; // 응답:ㅣ 요청이 끝나면 searchProcess함수를 실행해서 데이터 받아오기 
		request.send(null);
		
	}
	function searchProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = ""; // 안에 들어있는 내용물 다 지우기 
		
		if(request.readyState == 4 && request.status == 200) { // 성공적으로 통신이 이루어졌을 경우 
			var object = eval('(' + request.responseText  + ')'); //request.responseText: JSON /// 넘어온 JSON안에 들어있는 내용중에 result값만 가져오겠다 
			console.log("object"+ object);
			
			
			var result = object.result; //넘어온 JSON에서 result값을 가져오겠다 
			console.log("result"+result);
			
			for (var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for (var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					cell.innerHTML = result[i][j].value;
				}
			}	
		}		
	}
	
	window.onload=function() {
		searchFunction();
	}
</script>


</head>
<body>

	<br>
	<div class="container">
	
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id="userName" onkeyup="searchFunction()"  type="text" size="20">
				<!--  onkeyup : 입력할때마다 searchFunction이라는 함수가 실행됨 -->
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button>
			</div>
			<table class="table" style="text-align:center; border: 1px solid #ddd;">
				<thead>
					<tr>
						<th style="background-color: #fafafa;text-align: center;">이름</th>
						<th style="background-color: #fafafa;text-align: center;">나이</th>
						<th style="background-color: #fafafa;text-align: center;">성별</th>
						<th style="background-color: #fafafa;text-align: center;">이름</th>
					</tr>
				</thead>
				<tbody id="ajaxTable">
					<!-- <tr>
						<td>이이이</td>
						<td>22</td>
						<td>남자</td>
						<td>abcd@naver.com</td>
					</tr> -->
				</tbody>
			</table>
		</div>
	
	</div>



</body>
</html>