<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - login</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css" />
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>

    $(function() {

    });
    
function login() {
	
	if(!validationCheck()) {
		return false;
	}
	
    var form = $("#login_form").serialize();
    
    $.ajax({
        type: "post",
        url: "/user/loginLogic.do",
        data: form,
        async: false,
        dataType: 'json',
        success: function (data) {
        	result = data.mailConfirm;
        	if("fail" == result) {
        		alert("아이디 혹은 비밀번호가 잘못되었습니다.");
        	}else if("Y" == result) {
        		// 로그인 성공
        		//location.href = "/";
				if(document.referrer.includes("/user/signUp.do")){
					location.href = "/";
				}else {
					location.href = document.referrer;
				}

        	}else {
        		alert("메일인증을 완료 후 시도해주세요.");
        		//location.href = "/";
        		location.href = document.referrer;
        	}
        }
    });
}

function validationCheck() {
	if($('#id').val().trim() == "") {
		alert("아이디를 입력하세요");
		return false;
	}
	
	if($('#pw').val() == "" || $('#pw').val() == null) {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	return true;
}

function comnOnKeyUp() {
	if (window.event.keyCode == 13) {
		login();
    }
}

</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="" style="width: 70%!important;">
				<div class="estimateCalc_background p-5 mb-5">
					<div class="container">
						<form id="login_form">
							<div class="form-floating mb-3 col-6 mx-auto mt-5">
								<input type="text" class="form-control" id="id" name="id" onkeyup="javascript:comnOnKeyUp()">
								<label for="floatingInput">ID</label>
							</div>
							<div class="form-floating mb-5 col-6 mx-auto">
								<input type="password" class="form-control" id="pw" name="pw" onkeyup="javascript:comnOnKeyUp()">
								<label for="floatingPassword">Password</label>
							</div>
							<div class="d-grid gap-2 mb-3 col-6 mx-auto">
								<button class="btn btn-outline-secondary btn-lg" type="button" onclick="javascript:login()">Login</button>
							</div>
							<div class="d-flex justify-content-center mb-2">
								<nav class="navbar navbar-expand-md">
									<div class="container-fluid">
										<div class="collapse navbar-collapse">
											<div class="navbar-nav">
												<a class="nav-link" href="/user/signUp.do">회원가입</a>
												<span class="navbar-text">|</span>
												<a class="nav-link" href="javascript:alert('준비중')">아이디 찾기</a>
												<span class="navbar-text">|</span>
												<a class="nav-link" href="javascript:alert('준비중')">비밀번호 찾기</a>
											</div>
										</div>
									</div>
								</nav>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		</div>
	</div>
	
	<%@ include file="./common/footer.jsp" %>

</body>
</html>
