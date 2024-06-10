<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - login</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/css/ver_02/login.css">
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
				}else if (document.referrer.includes("/user/login.do")){
					location.href = "/";
				}else {
					location.href = document.referrer;
				}

        	}else {
        		alert("메일인증을 완료 후 시도해주세요.");
        		location.href = "/";
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
	<div class="login-container w-100 py-5">
		<div class="container mb-5">
			<div class="login-box p-5 w-50 mx-auto">
				<form id="login_form">
					<div class="px-5 d-flex flex-column gap-3">
						<div class="d-flex flex-column text-center pb-4">
							<h3 class="text-white fw-bold">로그인 하고</h3>
							<h3 class="text-white fw-bold">다양한 기능을 사용해보세요</h3>
						</div>
						<div class="d-flex flex-column gap-2">
							<h6 class="text-white">아이디</h6>
							<input type="text" placeholder="아이디를 입력해주세요" class="form-control login-inputs p-3" id="id" name="id" onkeyup="javascript:comnOnKeyUp()" autocomplete="off">
						</div>
						<div class="d-flex flex-column gap-2">
							<h6 class="text-white">비밀번호</h6>
							<input type="password" placeholder="비밀번호를 입력해주세요" class="form-control login-inputs p-3" id="pw" name="pw" onkeyup="javascript:comnOnKeyUp()">
						</div>
						<div class="d-flex justify-content-between align-items-center pb-4">
							<div class="d-flex gap-2 align-items-center">
								<input type="checkbox" name="" id="login-cb" class="form-check-input bg-dark m-0">
								<label for="login-cb"><h6 class="text-white m-0">로그인 유지</h6></label>
							</div>
							<h6 class="m-0"><a href="#" onclick="javascript:void(0)" class="text-decoration-none">비밀번호 찾기</a></h6>
						</div>
		
						<button type="button" class="btn btn-lg btn-light w-100 fw-bold py-3 mb-2" onclick="javascript:login()">로그인</button>
						
						<div class="d-flex gap-3 align-items-center justify-content-center pb-3">
							<h6 class="text-white">아직 회원이 아니시라면</h6>
							<h6 class="text-primary"><a href="/user/signUp.do" class="text-decoration-none">회원가입 하기</a></h6>
						</div>
					</div>
				</form>
			</div>

		</div>
	</div>
	
	<%@ include file="./common/footer.jsp" %>

</body>
</html>
