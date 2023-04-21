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

	//목록 띄우기 
	var searchRequest = new XMLHttpRequest();
	function searchFunction() {
		searchRequest.open("Post", "./UserSearchServlet?userName=" + encodeURIComponent(document.getElementById("userName").value), true); // 요청: UserSearchServlet으로 userName이라는 아이디값을 가진 input에 적힌 텍스트를 파라미터 값으로 보내기 
		searchRequest.onreadystatechange = searchProcess; // 응답:ㅣ 요청이 끝나면 searchProcess함수를 실행해서 데이터 받아오기 
		searchRequest.send(null);
	}
	function searchProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = ""; // 안에 들어있는 내용물 다 지우기 
		
		if(searchRequest.readyState == 4 && searchRequest.status == 200) { // 성공적으로 통신이 이루어졌을 경우 
			var object = eval('(' + searchRequest.responseText  + ')'); //request.responseText: JSON /// 넘어온 JSON안에 들어있는 내용중에 result값만 가져오겠다 
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
	
	
	//회원등록
	var registerRequest = new XMLHttpRequest();
	function registerFunction() {
		registerRequest.open("Post", "./UserRegisterServlet?userName=" + encodeURIComponent(document.getElementById("registerName").value) + 
							"&userAge=" + encodeURIComponent(document.getElementById("registerAge").value)  + 
							"&userGender=" + encodeURIComponent($('input[name=registerGender]:checked').val()) +
							"&userEmail=" + encodeURIComponent(document.getElementById("registerEmail").value) , true);  
		registerRequest.onreadystatechange = registerProcess; // 응답:성공적으로 통신이 이루어졌다면 registerProcess함수를 실행해서 데이터 받아오기 
		registerRequest.send(null);
	}
	
	function registerProcess() {
		if(registerRequest.readyState == 4 && registerRequest.status == 200) { 
			var result = registerRequest.responseText; // 성공적으로 통신 이루어졌으면 return 1받아옴
			console.log(result);
			if(result != 1) {
				alert("등록실패");
			}else {// 등록에 성공했다면 모든 칸들 전부 공백으로 변경
				var userName = document.getElementById("userName");
				var registerName = document.getElementById("registerName");
				var registerAge = document.getElementById("registerAge");
				var registerEmail = document.getElementById("registerEmail");
				userName.value="";
				registerName.value="";
				registerAge.value="";
				registerEmail.value="";
				searchFunction();
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
	
	
	
	
	
	
		<!-- 회원등록  -->
		<div class="container">
			<table class="table" style="text-align:center; border: 1px solid #ddd;">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #fafafa; text-align: center;">회원등록양식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="background-color: #fafafa; text-align: center;"><h5>이름</h5></td>
						<td><input class="form-control" type="text" id="registerName" size="20"></td>
					</tr>
					<tr>
						<td style="background-color: #fafafa; text-align: center;"><h5>나이</h5></td>
						<td><input class="form-control" type="text" id="registerAge" size="20"></td>
					</tr>
					<tr>
						<td style="background-color: #fafafa; text-align: center;"><h5>성별</h5></td>
						<td class="form-group" style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<lable class="btn btn-primary active">
									<input type="radio" name="registerGender" autocomplete="off" value="남자" checked>남자
								</lable>
								<lable class="btn btn-primary">
									<input type="radio" name="registerGender" autocomplete="off" value="여자" >여자
								</lable>
							</div>
						</td>
					</tr>
					<tr>
						<td style="background-color: #fafafa; text-align: center;"><h5>이메일</h5></td>
						<td><input class="form-control" type="text" id="registerEmail" size="20"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="button" class="btn btn-primary pull-right" onclick="registerFunction();">등록</button>
						</td>
					</tr>
				</tbody>
			</table>
		
		</div>
	
	
	
	
	
	
	
	
	</div>



</body>
</html>