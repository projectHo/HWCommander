<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 회원가입</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<!-- 23.06.17 다음 카카오 주소 api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

var targetId = null;

    $(function() {
        $('#btn_signUp').on("click", function () {
        	// todo wonho
        	alert("현재는 회원가입이 불가능합니다.");
        	return false;
        	
        	if(!validationCheck()) {
        		return false;
        	}
        	goSignUp();
        });
        
        // id 중복확인
        $('#btn_id_dupli_chk').on("click", function () {
        	idDupliChk($('#id').val().trim());
        });
        
        // 주소찾기
        $('#btn_addr_search').on("click", function () {
        	findDaumAddr();
        });
        
        // 핸드폰인증
        $('#btn_hpNumber_chk').on("click", function () {
        	alert("핸드폰인증해");
        	return false;
        	
        });
    });
    
function goSignUp() {
    var form = $("#signUp_form").serialize();
    
    $.ajax({
        type: "post",
        url: "/user/signUpLogic.do",
        data: form,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("회원가입이 완료되었습니다.\n이메일 인증 후 이용해주세요.");
        	}else {
        		alert("회원가입이 정상적으로 처리되지 않았습니다.\n고객센터로 문의해주세요.");
        	}
        	window.location = "/";
            console.log(data);
        }
    });
}

function validationCheck() {
	const numberCheck = /^[0-9]+$/;
	
	if($('#id').val().trim() == "") {
		alert("아이디를 입력하세요");
		$('#id').focus();
		return false;
	}
	
	if(targetId == null || targetId != $('#id').val().trim()) {
		alert("아이디 중복확인이 되지 않았습니다.");
		$('#id').focus();
		return false;
	}
	
	if($('#pw').val() == "" || $('#pw').val() == null) {
		alert("비밀번호를 입력하세요.");
		$('#pw').focus();
		return false;
	}
	
	if($('#pw').val() != $('#pwConfirm').val()) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	if($('#name').val().trim() == "" || $('#name').val().trim() == null) {
		alert("이름을 입력하세요.");
		$('#name').focus();
		return false;
	}
	
	if($('#birth').val() == "" || $('#birth').val() == null) {
		alert("생년월일을 입력하세요.");
		$('#birth').focus();
		return false;
	}
	
	if (!numberCheck.test($('#birth').val())) {
	    alert("생년월일은 숫자만 입력 가능합니다.");
	    $('#birth').focus();
	    return false;
	}
	
	if(8 != $('#birth').val().length) {
		alert("생년월일은 8자리여야 합니다.");
		$('#birth').focus();
		return false;
	}
	
	if($('#hpNumber').val().trim() == "" || $('#hpNumber').val().trim() == null) {
		alert("휴대폰번호를 입력하세요.");
		$('#hpNumber').focus();
		return false;
	}
	
	if (!numberCheck.test($('#hpNumber').val())) {
	    alert("휴대폰번호는 숫자만 입력 가능합니다.");
	    $('#hpNumber').focus();
	    return false;
	}
	
	if(10 != $('#hpNumber').val().length && 11 != $('#hpNumber').val().length) {
		alert("휴대폰번호는 10자리 또는 11자리여야 합니다.");
		$('#hpNumber').focus();
		return false;
	}
	
	if($('#zipcode').val().trim() == "" || $('#zipcode').val().trim() == null) {
		alert("주소를 입력하세요.");
		$('#btn_addr_search').focus();
		return false;
	}
	
	if($('#jibunAddr').val().trim() == "" || $('#jibunAddr').val().trim() == null) {
		alert("주소를 입력하세요.");
		$('#btn_addr_search').focus();
		return false;
	}
	
	if($('#roadAddr').val().trim() == "" || $('#roadAddr').val().trim() == null) {
		alert("주소를 입력하세요.");
		$('#btn_addr_search').focus();
		return false;
	}
	
	if($('#detailAddr').val().trim() == "" || $('#detailAddr').val().trim() == null) {
		alert("상세주소를 입력하세요.");
		$('#detailAddr').focus();
		return false;
	}
	
	if($('#mail').val().trim() == "" || $('#mail').val().trim() == null) {
		alert("이메일을 입력하세요.");
		$('#mail').focus();
		return false;
	}
	
	const mailCheckRegExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

	if (!mailCheckRegExp.test($('#mail').val())) {
		alert("올바른 이메일을 입력하세요.");
		$('#mail').focus();
		return false;
	}
	
	return true;
}

function idDupliChk(id) {
	
	if(id == "") {
		alert("아이디를 입력하세요.");
		return false;
	}
	
	$.ajax({
        type: "post",
        url: "/user/idDupliChk.do",
        data: {
        	"id" : id
        },
        dataType: 'json',
        success: function (data) {
        	if(data == 0) {
        		targetId = id;
        		alert("사용가능한 ID 입니다.");
        		$("#id").removeClass("is-invalid");
				$("#id").prev().removeClass("border-danger");
        	}else {
        		targetId = null;
        		$("#id").addClass("is-invalid");
				$("#id").prev().addClass("border-danger");
        		alert("중복된 ID 입니다.");
        	}
        }
    });
}

function findDaumAddr() {
	new daum.Postcode({
        oncomplete: function(data) {
        	console.log(data);
        	
            $("#zipcode").val(data.zonecode);
            $("#jibunAddr").val(data.jibunAddress);
            $("#roadAddr").val(data.roadAddress);
            $("#detailAddr").val("");
        }
    }).open();
}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
				<div class="estimateCalc_background p-5 mb-4" style="width: 70% !important">
					<div class="w-75 container">
						<form id="signUp_form">
							<div class="mt-5 row justify-content-center">
							<!-- <label for="id" class="col-sm-2 col-form-label">아이디</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" id="id" name="id" maxlength="25" required>
							</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M5 19C5 16.7909 6.79086 15 9 15H15C17.2091 15 19 16.7909 19 19C19 20.1046 18.1046 21 17 21H7C5.89543 21 5 20.1046 5 19Z" stroke="#000000" stroke-width="0.8399999999999999"></path> <circle cx="12" cy="7" r="4" stroke="#000000" stroke-width="0.8399999999999999"></circle> </g></svg>
									</span>
									<input type="text" id="id" class="form-control border-start-0 join-members" placeholder="아이디" required autocomplete="off">
									<button type="button" class="btn btn-outline-secondary" maxlength="25" id="btn_id_dupli_chk">중복확인</button>
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="pw" class="col-sm-2 col-form-label">비밀번호</label>
								<div class="col-sm-5">
									<input type="password" class="form-control" id="pw" name="pw" maxlength="30" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M12 14.5V16.5M7 10.0288C7.47142 10 8.05259 10 8.8 10H15.2C15.9474 10 16.5286 10 17 10.0288M7 10.0288C6.41168 10.0647 5.99429 10.1455 5.63803 10.327C5.07354 10.6146 4.6146 11.0735 4.32698 11.638C4 12.2798 4 13.1198 4 14.8V16.2C4 17.8802 4 18.7202 4.32698 19.362C4.6146 19.9265 5.07354 20.3854 5.63803 20.673C6.27976 21 7.11984 21 8.8 21H15.2C16.8802 21 17.7202 21 18.362 20.673C18.9265 20.3854 19.3854 19.9265 19.673 19.362C20 18.7202 20 17.8802 20 16.2V14.8C20 13.1198 20 12.2798 19.673 11.638C19.3854 11.0735 18.9265 10.6146 18.362 10.327C18.0057 10.1455 17.5883 10.0647 17 10.0288M7 10.0288V8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8V10.0288" stroke="#000000" stroke-width="1.176" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
									</span>
									<input type="password" id="pw" class="form-control border-start-0 join-members" maxlength="30" placeholder="비밀번호" required>
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="pwConfirm" class="col-sm-2 col-form-label">비밀번호확인</label>
								<div class="col-sm-5">
									<input type="password" class="form-control" id="pwConfirm" maxlength="30" name="pwConfirm" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Check"> <path id="Vector" d="M6 12L10.2426 16.2426L18.727 7.75732" stroke="#000000" stroke-width="1.176" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg>
									</span>
									<input type="password" id="pwConfirm" class="form-control border-start-0 join-members" maxlength="30" placeholder="비밀번호 확인" required>
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="name" class="col-sm-2 col-form-label">이름</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="name" name="name" maxlength="25" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M5 19C5 16.7909 6.79086 15 9 15H15C17.2091 15 19 16.7909 19 19C19 20.1046 18.1046 21 17 21H7C5.89543 21 5 20.1046 5 19Z" stroke="#000000" stroke-width="0.8399999999999999"></path> <circle cx="12" cy="7" r="4" stroke="#000000" stroke-width="0.8399999999999999"></circle> </g></svg>
									</span>
									<input type="text" id="name" class="form-control border-start-0 join-members" placeholder="이름" maxlength="25" required autocomplete="off">
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="birth" class="col-sm-2 col-form-label">생년월일</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="birth" name="birth" placeholder="8자 ex)20220105" maxlength="8" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M21 10H3M16 2V6M8 2V6M10.5 14L12 13V18M10.75 18H13.25M7.8 22H16.2C17.8802 22 18.7202 22 19.362 21.673C19.9265 21.3854 20.3854 20.9265 20.673 20.362C21 19.7202 21 18.8802 21 17.2V8.8C21 7.11984 21 6.27976 20.673 5.63803C20.3854 5.07354 19.9265 4.6146 19.362 4.32698C18.7202 4 17.8802 4 16.2 4H7.8C6.11984 4 5.27976 4 4.63803 4.32698C4.07354 4.6146 3.6146 5.07354 3.32698 5.63803C3 6.27976 3 7.11984 3 8.8V17.2C3 18.8802 3 19.7202 3.32698 20.362C3.6146 20.9265 4.07354 21.3854 4.63803 21.673C5.27976 22 6.11984 22 7.8 22Z" stroke="#000000" stroke-width="1.248" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
									</span>
									<input type="text" id="birth" class="form-control border-start-0 join-members" placeholder="생년월일 8자 ex)20220105" maxlength="8" required autocomplete="off">
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="birth" class="col-sm-2 col-form-label">성별</label>
								<div class="col-sm-5 d-flex gap-3">
									<div class="form-check">
									<input class="form-check-input" type="radio" name="sexCd" id="sexCd1" value="01" checked required>
									<label class="form-check-label" for="sexCd1">남성</label>
									</div>
									<div class="form-check">
									<input class="form-check-input" type="radio" name="sexCd" id="sexCd2" value="02" required>
									<label class="form-check-label" for="sexCd2">여성</label>
									</div>
								</div> -->
								<div class="input-group mb-3 w-50">
									<div class="col-1"></div>
									<div class="col-4">
										<input type="radio" class="btn-check" name="sexCd" id="sexCd1" value="01" autocomplete="off">
										<label class="btn btn-outline-secondary w-100 join-members" for="sexCd1">남자</label>
									</div>
									<div class="col-2"></div>
									<div class="col-4">
										<input type="radio" class="btn-check" name="sexCd" id="sexCd2" value="02" autocomplete="off">
										<label class="btn btn-outline-secondary w-100 join-members" for="sexCd2">여자</label>
									</div>
									<div class="col-1"></div>
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="hpNumber" class="col-sm-2 col-form-label">휴대폰번호</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="hpNumber" name="hpNumber" placeholder="'-'를 빼고 입력해주세요." maxlength="11" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" transform="rotate(180)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M18.9998 17.5V6.5C19.0627 5.37366 18.6774 4.2682 17.9279 3.42505C17.1784 2.5819 16.1258 2.06958 14.9998 2H8.99981C7.87387 2.06958 6.82121 2.5819 6.07175 3.42505C5.32228 4.2682 4.9369 5.37366 4.99982 6.5V17.5C4.9369 18.6263 5.32228 19.7317 6.07175 20.5748C6.82121 21.418 7.87387 21.9303 8.99981 21.9999H14.9998C16.1258 21.9303 17.1784 21.418 17.9279 20.5748C18.6774 19.7317 19.0627 18.6263 18.9998 17.5V17.5Z" stroke="#000000" stroke-width="0.9600000000000002" stroke-linecap="round" stroke-linejoin="round"></path> <path d="M14 5H10" stroke="#000000" stroke-width="0.9600000000000002" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
									</span>
									<input type="text" id="hpNumber" class="form-control border-start-0 join-members" placeholder="'-'를 빼고 입력해주세요." maxlength="11" required autocomplete="off">
									<button type="button" class="btn btn-outline-secondary" id="btn_hpNumber_chk">인증하기</button>
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="mail" class=" col-sm-2 col-form-label">이메일</label>
								<div class="col-sm-5">
									<input type="email" class="form-control" id="mail" name="mail" placeholder="email@example.com" maxlength="100" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M2 12C2 8.22876 2 6.34315 3.17157 5.17157C4.34315 4 6.22876 4 10 4H14C17.7712 4 19.6569 4 20.8284 5.17157C22 6.34315 22 8.22876 22 12C22 15.7712 22 17.6569 20.8284 18.8284C19.6569 20 17.7712 20 14 20H10C6.22876 20 4.34315 20 3.17157 18.8284C2 17.6569 2 15.7712 2 12Z" stroke="#1C274C" stroke-width="1.056"></path> <path d="M6 8L8.1589 9.79908C9.99553 11.3296 10.9139 12.0949 12 12.0949C13.0861 12.0949 14.0045 11.3296 15.8411 9.79908L18 8" stroke="#1C274C" stroke-width="1.056" stroke-linecap="round"></path> </g></svg>
									</span>
									<input type="email" class="form-control border-start-0 join-members" id="mail" name="mail" placeholder="email@example.com" maxlength="100" required autocomplete="off">
								</div>
								<!-- <div class="col-auto">
									<button type="button" class="btn btn-outline-secondary" id="btn_email_chk">이메일인증</button>
								</div> -->
							</div>
							<div class="row justify-content-center" style="height: 38px;">
								<!-- <label for="zipcode" class="col-sm-2 col-form-label">주소</label> -->
								<!-- <div class="col-sm-2"> -->
									<!-- <input type="text" class="form-control" id="zipcode" name="zipcode" readonly="readonly" required>
									<button type="button" class="btn btn-outline-secondary" id="btn_addr_search">주소찾기</button> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M9 20L3 17V4L9 7M9 20L15 17M9 20V7M15 17L21 20V7L15 4M15 17V4M9 7L15 4" stroke="#000000" stroke-width="1.128" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
									</span>
									<input type="text" class="form-control border-start-0 join-members" id="zipcode" name="zipcode" readonly="readonly" placeholder="주소" required>
									<button type="button" class="btn btn-outline-secondary" id="btn_addr_search">주소찾기</button>
								</div>
								<!-- </div> -->
							</div>
							<div class="row justify-content-center" style="height: 38px;">
								<!-- <label for="jibunAddr" class="col-sm-2 col-form-label">지번주소</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="jibunAddr" name="jibunAddr" readonly="readonly" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Check"> <path id="Vector" d="M6 12L10.2426 16.2426L18.727 7.75732" stroke="#000000" stroke-width="1.176" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg>
									</span>
									<input type="text" class="form-control border-start-0 join-members" id="jibunAddr" name="jibunAddr" readonly="readonly" placeholder="지번주소" required>
								</div>
							</div>
							<div class="row justify-content-center" style="height: 38px;">
								<!-- <label for="roadAddr" class="col-sm-2 col-form-label">도로명주소</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="roadAddr" name="roadAddr" readonly="readonly" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Check"> <path id="Vector" d="M6 12L10.2426 16.2426L18.727 7.75732" stroke="#000000" stroke-width="1.176" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg>
									</span>
									<input type="text" class="form-control border-start-0 join-members" id="roadAddr" name="roadAddr" readonly="readonly" placeholder="도로명주소" required>
								</div>
							</div>
							<div class="row justify-content-center">
								<!-- <label for="detailAddr" class="col-sm-2 col-form-label">상세주소</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="detailAddr" name="detailAddr" maxlength="500" required>
								</div> -->
								<div class="input-group mb-3 w-50">
									<span class="input-group-text bg-white pe-1">
										<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Check"> <path id="Vector" d="M6 12L10.2426 16.2426L18.727 7.75732" stroke="#000000" stroke-width="1.176" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg>
									</span>
									<input type="text" class="form-control border-start-0 join-members" id="detailAddr" name="detailAddr" maxlength="500" placeholder="상세주소" required autocomplete="off">
								</div>
							</div>
							<div class="d-grid gap-2 mb-5 col-6 mx-auto mt-3">
							<button class="btn btn-outline-secondary btn-lg" type="button" id="btn_signUp">회원가입</button>
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
