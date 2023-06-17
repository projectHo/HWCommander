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
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<!-- 23.06.17 다음 카카오 주소 api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

var targetId = null;

    $(function(){
        $('#btn_signUp').on("click", function () {
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
		return false;
	}
	
	if(targetId == null || targetId != $('#id').val().trim()) {
		alert("아이디 중복확인이 되지 않았습니다.");
		return false;
	}
	
	if($('#pw').val() == "" || $('#pw').val() == null) {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	
	if($('#pw').val() != $('#pwConfirm').val()) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	if($('#name').val().trim() == "" || $('#name').val().trim() == null) {
		alert("이름을 입력하세요.");
		return false;
	}
	
	if($('#birth').val() == "" || $('#birth').val() == null) {
		alert("생년월일을 입력하세요.");
		return false;
	}
	
	if (!numberCheck.test($('#birth').val())) {
	    alert("생년월일은 숫자만 입력 가능합니다.");
	    return false;
	}
	
	if(8 != $('#birth').val().length) {
		alert("생년월일은 8자리여야 합니다.");
		return false;
	}
	
	if($('#hpNumber').val().trim() == "" || $('#hpNumber').val().trim() == null) {
		alert("휴대폰번호를 입력하세요.");
		return false;
	}
	
	if (!numberCheck.test($('#hpNumber').val())) {
	    alert("휴대폰번호는 숫자만 입력 가능합니다.");
	    return false;
	}
	
	if(10 != $('#hpNumber').val().length && 11 != $('#hpNumber').val().length) {
		alert("휴대폰번호는 10자리 또는 11자리여야 합니다.");
		return false;
	}
	
	if($('#zipcode').val().trim() == "" || $('#zipcode').val().trim() == null) {
		alert("주소를 입력하세요.");
		return false;
	}
	
	if($('#jibunAddr').val().trim() == "" || $('#jibunAddr').val().trim() == null) {
		alert("주소를 입력하세요.");
		return false;
	}
	
	if($('#roadAddr').val().trim() == "" || $('#roadAddr').val().trim() == null) {
		alert("주소를 입력하세요.");
		return false;
	}
	
	if($('#detailAddr').val().trim() == "" || $('#detailAddr').val().trim() == null) {
		alert("상세주소를 입력하세요.");
		return false;
	}
	
	if($('#mail').val().trim() == "" || $('#mail').val().trim() == null) {
		alert("이메일을 입력하세요.");
		return false;
	}
	
	const mailCheckRegExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

	if (!mailCheckRegExp.test($('#mail').val())) {
		alert("올바른 이메일을 입력하세요.");
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
        	}else {
        		targetId = null;
        		$("#id").addClass("is-invalid");
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
			<div class="h-25 justify-content-start" style="width: 30%!important;"></div>
			<div class="" style="width: 40%!important;">
				<form id="signUp_form">
					<div class="mb-3 mt-5 row">
					  <label for="id" class="text-light col-sm-2 col-form-label">아이디</label>
					  <div class="col-sm-5">
					    <input type="text" class="form-control" id="id" name="id" maxlength="25" required>
					  </div>
					  <div class="col-auto">
					    <button type="button" class="btn btn-outline-light" id="btn_id_dupli_chk">중복확인</button>
					  </div>
					</div>
					<div class="mb-3 row">
					  <label for="pw" class="text-light col-sm-2 col-form-label">비밀번호</label>
					  <div class="col-sm-5">
					    <input type="password" class="form-control" id="pw" name="pw" maxlength="30" required>
					  </div>
					</div>
					<div class="mb-3 row">
					  <label for="pwConfirm" class="text-light col-sm-2 col-form-label">비밀번호확인</label>
					  <div class="col-sm-5">
					    <input type="password" class="form-control" id="pwConfirm" maxlength="30" name="pwConfirm" required>
					  </div>
					</div>
					<div class="mb-3 row">
					  <label for="name" class="text-light col-sm-2 col-form-label">이름</label>
					  <div class="col-sm-5">
					    <input type="text" class="form-control" id="name" name="name" maxlength="25" required>
					  </div>
					</div>
					<div class="mb-3 row">
					  <label for="birth" class="text-light col-sm-2 col-form-label">생년월일</label>
					  <div class="col-sm-5">
					    <input type="text" class="form-control" id="birth" name="birth" placeholder="8자 ex)20220105" maxlength="8" required>
					  </div>
					</div>
					<div class="mb-3 row">
					  <label for="birth" class="text-light col-sm-2 col-form-label">성별</label>
					  <div class="col-sm-5">
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="sexCd" id="sexCd1" value="01" checked required>
						  <label class="form-check-label text-light" for="sexCd1">남성</label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="sexCd" id="sexCd2" value="02" required>
						  <label class="form-check-label text-light" for="sexCd2">여성</label>
						</div>
					  </div>
					</div>
					<div class="mb-3 row">
					  <label for="hpNumber" class="text-light col-sm-2 col-form-label">휴대폰번호</label>
					  <div class="col-sm-5">
					    <input type="text" class="form-control" id="hpNumber" name="hpNumber" placeholder="'-'를 빼고 입력해주세요." maxlength="11" required>
					  </div>
					  <div class="col-auto">
					    <button type="button" class="btn btn-outline-light" id="btn_hpNumber_chk">휴대폰인증</button>
					  </div>
					</div>
					<div class="mb-1 row">
					  <label for="zipcode" class="text-light col-sm-2 col-form-label">주소</label>
					  <div class="col-sm-2">
					    <input type="text" class="form-control" id="zipcode" name="zipcode" readonly="readonly" required>
					  </div>
					  <div class="col-auto">
					    <button type="button" class="btn btn-outline-light" id="btn_addr_search">주소찾기</button>
					  </div>
					</div>
					<div class="mb-1 row">
					  <label for="jibunAddr" class="text-light col-sm-2 col-form-label">지번주소</label>
					  <div class="col-sm-7">
					    <input type="text" class="form-control" id="jibunAddr" name="jibunAddr" readonly="readonly" required>
					  </div>
					</div>
					<div class="mb-1 row">
					  <label for="roadAddr" class="text-light col-sm-2 col-form-label">도로명주소</label>
					  <div class="col-sm-7">
					    <input type="text" class="form-control" id="roadAddr" name="roadAddr" readonly="readonly" required>
					  </div>
					</div>
					<div class="mb-3 row">
					  <label for="detailAddr" class="text-light col-sm-2 col-form-label">상세주소</label>
					  <div class="col-sm-7">
					    <input type="text" class="form-control" id="detailAddr" name="detailAddr" maxlength="250" required>
					  </div>
					</div>
					<div class="mb-5 row">
					  <label for="mail" class="text-light col-sm-2 col-form-label">이메일</label>
					  <div class="col-sm-5">
					  	<input type="email" class="form-control" id="mail" name="mail" placeholder="email@example.com" maxlength="100" required>
					  </div>
					  <!-- <div class="col-auto">
					    <button type="button" class="btn btn-outline-light" id="btn_email_chk">이메일인증</button>
					  </div> -->
					</div>
					<div class="d-grid gap-2 mb-5 col-6 mx-auto">
					  <button class="btn btn-outline-light btn-lg" type="button" id="btn_signUp">회원가입</button>
					</div>

				</form>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 30%!important;"></div>
		</div>
	</div>
	
	<%@ include file="./common/footer.jsp" %>

</body>
</html>
