<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>HWCommander - 회원가입</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<!-- 23.06.17 다음 카카오 주소 api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link rel="stylesheet" href="/resources/css/ver_02/signUp.css">

<%
	String enc_data = String.valueOf(request.getAttribute("enc_data"));
	String integrity_value = String.valueOf(request.getAttribute("integrity_value"));
	String token_version_id = String.valueOf(request.getAttribute("token_version_id"));
%>

<script>
	$(function() {
		alert("전체 약관을 확인 하신 후 동의가 가능합니다.");
		$('#terms-modal').modal({ backdrop: 'static', keyboard: false }); 
		$("#terms-modal").modal("show");
	})

	function refuseTerms(){
		alert("약관 미동의 시 이용하실 수 없습니다");
	}
	function agreeTerms(){
		$("#terms-modal").modal("hide");
	}
	function scrollTerms(elem){
		var scrollTop = $(elem).scrollTop();
		var innerHeight = window.innerHeight || $(elem).innerHeight();
		var scrollHeight = $(elem).prop('scrollHeight');
		if (scrollTop + innerHeight >= scrollHeight) {
			$("#agree-terms").removeClass("btn-outline-primary").addClass("btn-primary").attr("disabled",false);
		}
	}
	function checkId(){
		idDupliChk($('#id').val().trim());
	}

	function validationCheck() {
		const numberCheck = /^[0-9]+$/;
		
		if($('#di').val().trim() == "") {
			alert("본인인증을 완료해주세요.");
			return false;
		}
		
		if($('#id').val().trim() == "") {
			alert("아이디를 입력하세요.");
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
		
		if($('#pw').val().length < 8 || $('#pw').val().length > 16){
			alert("8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");
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
			$("#id").addClass("is-invalid").addClass("border-danger").val("").focus();
			setTimeout(() => {
				$("#id").removeClass("is-invalid").removeClass("border-danger");
			}, 2000);
			return false;
		}
		if(id.length <= 4 || id.length > 20){
			alert("5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
			$("#id").addClass("is-invalid").addClass("border-danger").val("").focus();
			setTimeout(() => {
				$("#id").removeClass("is-invalid").removeClass("border-danger");
			}, 2000);
			return false;
		}

		if(!/^[a-zA-Z0-9-_]+$/.test($("#id").val())){
			alert("5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
			$("#id").addClass("is-invalid").addClass("border-danger").val("").focus();
			setTimeout(() => {
				$("#id").removeClass("is-invalid").removeClass("border-danger");
			}, 2000);
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
				
				$("#zipcode").val(data.zonecode);
				$("#jibunAddr").val(data.jibunAddress);
				$("#roadAddr").val(data.roadAddress);
				
				$(".addr-container").removeClass("d-none");
				$("#detailAddr").val("").focus();
			}
		}).open();
	}
	function hpNumberAuthentication() {
	
		if($('#di').val().trim() != null && $('#di').val().trim() != "") {
			alert("이미 정상적으로 인증을 완료하였습니다.");
			return false;
		}
		
		window.name ="Parent_window";
		
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/service.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
	function goSignUp() {
		if(!validationCheck()) {
			return false;
		}else {
			var form = $("#signUp_form").serialize();
			
			$.ajax({
				type: "post",
				url: "/user/signUpLogic.do",
				data: form,
				dataType: 'json',
				success: function (data) {
					if(data == 1) {
						alert("회원가입이 완료되었습니다.\n이메일 인증 후 이용해주세요.");
					}else if(data == 2) {
						alert("본 사이트는 1인 1계정 원칙입니다.\n이미 가입 된 계정이 있습니다.");
					}else {
						alert("회원가입이 정상적으로 처리되지 않았습니다.\n고객센터로 문의해주세요.");
					}
					window.location = "/";
				},
				error: function(error){
					alert("error : " + error);
				}
			});
		}
	}
	
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="sign-up-container w-100 py-5">
		<form id="signUp_form">
			<input type="hidden" id="di" name="di" value="" />
			<div class="container mb-5">
				<div class="sign-up-box p-5 w-50 mx-auto">
					<div class="px-5 d-flex flex-column gap-3">
						<div class="d-flex flex-column text-center pb-4">
							<h3 class="text-white fw-bold">HWCommander의</h3>
							<h3 class="text-white fw-bold">회원이 되어주셔서 감사드립니다</h3>
						</div>
	
						<div class="d-flex flex-column gap-2">
							<h6 class="text-white">아이디</h6>
							<div class="d-flex gap-3">
								<input type="text" placeholder="아이디를 입력해주세요" minlength="5" maxlength="20" class="form-control sign-up-inputs p-3 w-75" id="id" name="id" autocomplete="off" required>
								<button type="button" class="btn btn-secondary btn-lg fw-bold flex-grow-1" onclick="javascript:checkId(this)">확인</button>
							</div>
						</div>
	
						<div class="d-flex flex-column gap-2">
							<h6 class="text-white">비밀번호</h6>
							<input type="password" id="pw" name="pw" placeholder="비밀번호를 입력해주세요" class="form-control sign-up-inputs p-3" required>
							<input type="password" id="pwConfirm" name="pwConfirm" placeholder="비밀번호를 다시 입력해주세요" class="form-control sign-up-inputs p-3" required>
						</div>
	
						<div class="sign-up-divider"></div>
	
						<div class="d-flex flex-column gap-2">
							<h6 class="text-white">본인인증</h6>
							<button type="button" class="btn btn-primary fw-bold mb-2 sign-up-small-btns" onclick="javascript:hpNumberAuthentication()">인증하기</button>
						</div>
	
						<div class="d-none d-flex flex-column gap-3 after-auth">
							<div class="d-flex flex-column gap-2">
								<h6 class="text-white">이름</h6>
								<input type="text" id="name" name="name" placeholder="이름을 입력해주세요" class="form-control sign-up-inputs p-3" required>
							</div>
		
							<div class="d-flex flex-column gap-2">
								<h6 class="text-white">생년월일</h6>
								<input type="text" id="birth" name="birth" placeholder="생년월일을 입력해주세요" class="form-control sign-up-inputs p-3" required>
							</div>
		
							<div class="d-flex flex-column gap-2">
								<h6 class="text-white">전화번호</h6>
								<input type="text" id="hpNumber" name="hpNumber" placeholder='"-"를 제외하고 입력해주세요' class="form-control sign-up-inputs p-3" required>
							</div>
	
							<div class="d-flex flex-column gap-2">
								<h6 class="text-white">성별</h6>
								<div class="d-flex gap-3 text-white">
									<div class="form-check">
										<input class="form-check-input sign-up-radios" type="radio" name="sexCd" id="sexCd1" value="01" required>
										<label class="form-check-label" for="sexCd1">
										  남자
										</label>
									</div>
									<div class="form-check">
										<input class="form-check-input sign-up-radios" type="radio" name="sexCd" id="sexCd2" value="02" required>
										<label class="form-check-label" for="sexCd2">
										  여자
										</label>
									</div>
								</div>
							</div>
							
	
							<div class="d-flex flex-column gap-2">
								<h6 class="text-white">이메일</h6>
								<input type="text" placeholder="이메일을 입력해주세요 (email@example.com)" id="mail" name="mail" class="form-control sign-up-inputs p-3" maxlength="100" autocomplete="off" required>
							</div>
							
							<div class="d-flex flex-column gap-2 mb-4">
								<h6 class="text-white">주소</h6>
								<button type="button" class="btn btn-primary fw-bold mb-2 sign-up-small-btns" onclick="findDaumAddr()">주소검색</button>
								<div class="d-none d-flex flex-column gap-2 addr-container">
									<input type="text" placeholder="지번주소" id="jibunAddr" name="jibunAddr" class="form-control sign-up-inputs p-3" required readonly>
									<input type="hidden" id="zipcode" name="zipcode" placeholder="우편번호" class="form-control sign-up-inputs p-3" required readonly>
									<input type="text" placeholder="도로명 주소" id="roadAddr" name="roadAddr" class="form-control sign-up-inputs p-3" required readonly>
									<input type="text" placeholder="상세 주소를 입력해주세요" id="detailAddr" name="detailAddr" class="form-control sign-up-inputs p-3" required>
								</div>
							</div>
	
							<button type="button" class="btn btn-lg btn-light w-100 fw-bold py-3 mb-2" onclick="javascript:goSignUp()">회원가입</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	
	<%@ include file="./common/footer.jsp" %>
	
<form name="form_chk" id="form_chk">
      <input type="hidden" id="m" name="m" value="service" />
      <input type="hidden" id="token_version_id" name="token_version_id" value="<%=token_version_id%>" />
      <input type="hidden" id="enc_data" name="enc_data" value="<%=enc_data%>" />
      <input type="hidden" id="integrity_value" name="integrity_value" value="<%=integrity_value%>" />
</form>

<div class="modal fade" tabindex="-1" id="terms-modal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">이용 약관</h5>
			</div>
			<div class="modal-body" onscroll="javascript:scrollTerms(this)">
				<p>제1조(목적) 이 약관은 HWCommander(전자상거래 사업자)가 운영하는 HWCommander(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.</p>
	<P>※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」</P>
	<P>제2조(정의)</P>
	<P>① “몰”이란 HWCommander가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.</P>
	<P>② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</P>
	<P>③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.</P>
	<P>제3조 (약관 등의 명시와 설명 및 개정)</P>
	<P>① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호.모사전송번호.전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 HWCommander의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.</P>
	<P>② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회.배송책임.환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.</P>
	<P>③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</P>
	<P>④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.</P>
	<P>⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.</P>
	<P>⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.</P>
	<P>제4조(서비스의 제공 및 변경)</P>
	<P>① “몰”은 다음과 같은 업무를 수행합니다.</P>
	
	<pre class="content_border_line_white">
1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
2. 구매계약이 체결된 재화 또는 용역의 배송
3. 기타 “몰”이 정하는 업무</pre>

	<p>② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.</P>
	<p>③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.</P>
	<p>④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</P>
	<p>제5조(서비스의 중단)</P>
	<p>① “몰”은 컴퓨터 등 정보통신설비의 보수점검.교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.</P>
	<p>② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</P>
	<p>제6조(회원가입)</P>
	<p>① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.</P>
	<p>② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.</P>

	<pre class="content_border_line_white">
1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우</pre>

	<p>③ 회원가입계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.</p>
	<p>④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.</p>
	<p>제7조(회원 탈퇴 및 자격 상실 등)</p>
	<p>① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.</p>
	<p>② 회원이 다음 각 호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.</p>
	
	<pre class="content_border_line_white">
1. 가입 신청 시에 허위 내용을 등록한 경우
2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우</pre>

	<p>③ “몰”이 회원 자격을 제한.정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.</p>
	<p>④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.</p>
	<p>제8조(회원에 대한 통지)</p>
	<p>① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.</p>
	<p>② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.</p>
	<p>제9조(구매신청 및 개인정보 제공 동의 등)</p>
	<p>① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다.<br>
	1. 재화 등의 검색 및 선택<br>
	2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력<br>
	3. 약관내용, 청약철회권이 제한되는 서비스, 배송료.설치비 등의 비용부담과 관련한 내용에 대한 확인<br>
	4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시<br>
	(예, 마우스 클릭)<br>
	5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의<br>
	6. 결제방법의 선택</p>
	<p>② “몰”이 제3자에게 구매자 개인정보를 제공할 필요가 있는 경우 1) 개인정보를 제공받는 자, 2)개인정보를 제공받는 자의 개인정보 이용목적, 3) 제공하는 개인정보의 항목, 4) 개인정보를 제공받는 자의 개인정보 보유 및 이용기간을 구매자에게 알리고 동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.)</p>
	<p>③ “몰”이 제3자에게 구매자의 개인정보를 취급할 수 있도록 업무를 위탁하는 경우에는 1) 개인정보 취급위탁을 받는 자, 2) 개인정보 취급위탁을 하는 업무의 내용을 구매자에게 알리고 동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.) 다만, 서비스제공에 관한 계약이행을 위해 필요하고 구매자의 편의증진과 관련된 경우에는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」에서 정하고 있는 방법으로 개인정보 취급방침을 통해 알림으로써 고지절차와 동의절차를 거치지 않아도 됩니다.</p>
	<p>제10조 (계약의 성립)</p>
<p>① “몰”은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.</p>

	<pre class="content_border_line_white">
1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
2. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우</pre>

	<p>② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.</p>
	<p>③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.</p>
	<p>제11조(지급방법) “몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.</p>
	
	<pre class="content_border_line_white">
1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체 
2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
3. 온라인무통장입금
4. 전자화폐에 의한 결제
5. 수령 시 대금지급
6. 기타 전자적 지급 방법에 의한 대금 지급 등</pre>

	<p>제12조(수신확인통지․구매신청 변경 및 취소)</p>
	<p>① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.</p>
	<p>② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.</p>
	<p>제13조(재화 등의 공급)</p>
	<p>① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 14일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 7영업일 이내에 조치를 취합니다. 이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.</p>
	<p>② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의․과실이 없음을 입증한 경우에는 그러하지 아니합니다.</p>
	<p>제14조(환급) “몰”은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.</p>
	<p>제15조(청약철회 등)</p>
	<p>① “몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.</p>
	<p>② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.<br>소비자는 주문 직후, 주문 후, 조립 후, 배송 후에 따라 부품에 대한 감가상각이 적용되어, 배송비/개봉/사용감에 대한 철회 위약금을 제한 금액만큼에 대해 청약 철회 받을 수 있다.</p>
	
	<ol>
		<li>이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우</li>
		<li>구매 당일<br>&nbsp;구매일 당일에 청약철회를 요청할 경우 타 사의 제품 출고일 기준 하 15시 이전의 철회 건에 대하여 위약금이 발생하지 않는다.</li>
		<li>구매 익일~구매일로부터 2일<br>&nbsp;구매일 익일 혹은 15시 이후의 철회 건에 대하여 종류와 무관한 부품 당 왕복 배송비인 5천원을 위약금으로 지불한다.</li>
		<li>구매일로부터 3일~출고일<br>&nbsp;구매일로부터 3일 이상 지났지만 출고일의 출고시각 15시 이전에 청약철회를 요청할 경우 개봉 및 조립간 사용감에 대한 감가상각을 적용하여 부품 총액의 15%를 위약금으로 지불한다.</li>
		<li>출고 이후<br>&nbsp;출고 이후의 경우 소비자의 사용감에 따라 감가상각이 적용되어 이상이 없는 부품 제한 하 첫날 35%의 위약금을 지불하며, 14일에 걸쳐 일일 5%의 추가 위약금이 발생하여 14일 후에는 청약철 회가 불가능하다.<br>다만, 소비자 과실을 제외한 불량의 경우 해당 부품 무상 교체 혹은 해당 제품 건에 대한 환불이 가능하다.</li>
		<li>서비스<br>&nbsp;시스템 최적화, 요구 프로그램 설치, 오버클럭 등 1회성 서비스재의 경우 교환/환불이 불가능하다. ③ 제2항제2호 내지 제5호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다. ④ 이용자는 제1항 및 제6항의 규정에 불구하고 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.</li>
	</ol>
	
	<p>제16조(청약철회 등의 효과)</p>
	<p>① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.</p>
	<p>② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.</p>
	<p>③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.</p>
	<p>④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.</p>
	<p>제17조(개인정보보호)</p>
	<p>① “몰”은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.</p>
	<p>② “몰”은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.</p>
	<p>③ “몰”은 이용자의 개인정보를 수집·이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다.</p>
	<p>④ “몰”은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용·제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.</p>
	<p>⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.</p>
	<p>⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.</p>
	<p>⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를 최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.</p>
	<p>⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.</p>
	<p>⑨ “몰”은 개인정보의 수집·이용·제공에 관한 동의 란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.</p>
	<p>제18조(“몰“의 의무)</p>
	<p>① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화.용역을 제공하는데 최선을 다하여야 합니다.</p>
	<p>② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.</p>
	<p>③ “몰”이 상품이나 용역에 대하여 「표시.광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시.광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.</p>
	<p>④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.</p>
	<p>제19조(회원의 ID 및 비밀번호에 대한 의무)</p>
	<p>① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.</p>
	<p>② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.</p>
	<p>③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.</p>
	<p>제20조(이용자의 의무) 이용자는 다음 행위를 하여서는 안 됩니다.</p>
	
	<pre class="content_border_line_white">
1. 신청 또는 변경시 허위 내용의 등록
2. 타인의 정보 도용
3. “몰”에 게시된 정보의 변경
4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위</pre>

	<p>제22조(저작권의 귀속 및 이용제한)</p>
	<p>① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.</p>
	<p>② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.</p>
	<p>③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.</p>
	<p>제23조(분쟁해결)</p>
	<p>① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치.운영합니다.</p>
	<p>② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.</p>
	<p>③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.</p>
	<p>제24조(재판권 및 준거법)</p>
	<p>① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.</p>
	<p class="mb-5">② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" onclick="javascript:refuseTerms()">닫기</button>
				<button type="button" class="btn btn-outline-primary" disabled id="agree-terms" onclick="javascript:agreeTerms()">약관 동의</button>
			</div>
		</div>
	</div>
</div>
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>
