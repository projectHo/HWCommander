<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/ver_02/footer.css">
</head>
<script>
	<%-- var loginUser = '<%=(String)session.getAttribute("loginUser")%>'; --%>
	function myPageBtn() {
		if(loginCheck()) {
			location.href ="/user/myPage.do";
		}
	}
	function loginBtn(){
		location.href = "/user/login.do";
	}
	function logoutBtn() {
		if(confirm("로그아웃 하시겠습니까?")) {
			location.href = "/user/logoutLogic.do";
		}
	}
</script>
<body>
	<div class="container-fluid footer-container px-5 py-5">
		<div class="d-flex flex-column gap-5 container">
			<div class="d-flex justify-content-between align-items-center mb-2">
				<img src="/resources/img/ver_02/footer-logo.png" alt="회사로고" class="w-fit">
				<div class="d-flex gap-5">
					<div class="d-flex flex-column gap-4 text-start">
						<h4 class="fw-bold text-white">SHOPPING INFO</h4>
						<div class="d-flex flex-column gap-2">
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/aboutUs.do'">회사소개</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/termsOfService.do'">이용약관</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/personalInformationProcessingPolicy.do'">개인정보처리방침</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" href="https://www.kca.go.kr/" target="_blank">소비자보호원</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" href="https://usr.ecmc.or.kr/main.do" target="_blank">전자거래분쟁조정위원회</a></h6>
						</div>
					</div>
					<div class="d-flex flex-column gap-4 text-start">
						<h4 class="fw-bold text-white">QUICK MENU</h4>
						<div class="d-flex flex-column gap-2">
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('고객센터 전화를 통해 문의해주시기 바랍니다.\n\n전화번호 : 010-7625-0478')">1:1문의</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('고객센터 전화를 통해 문의해주시기 바랍니다.\n\n전화번호 : 010-7625-0478')">A/S안내</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:myPageBtn()">주문조회</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:myPageBtn()">배송안내</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('준비중')">컴퓨터 자가진단</a></h6>
						</div>
					</div>
					<div class="d-flex flex-column gap-4 text-start">
						<h4 class="fw-bold text-white">ALL MENU</h4>
						<div class="d-flex flex-column gap-2">
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/userBanpumMall.do'">이벤트몰</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/aboutUs.do'">회사소개</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:myPageBtn()">마이페이지</a></h6>
							<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('고객센터 전화를 통해 문의해주시기 바랍니다.\n\n전화번호 : 010-7625-0478');">고객센터</a></h6>
							<c:if test="${loginUser == null}">
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:loginBtn()">로그인</a></h6>
							</c:if>
							<c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:logoutBtn()">로그아웃</a></h6>
							</c:if>
						</div>
					</div>
				</div>
			</div>
	
			<div class="d-flex justify-content-between align-items-center">
				<div class="d-flex flex-column gap-4">
					<h6 class="fw-semibold text-white">통신판매업 신고번호 : 2023-서울용산-1054 호</h6>
					<h6 class="fw-semibold text-white">@ Copyright HW Commander 2019 - 2023</h6>
				</div>
				<div class="d-flex flex-column gap-4">
					<h6 class="fw-semibold text-white">E-mail : pcvirusson@hanmail.net</h6>
					<h6 class="fw-semibold text-white">대표 : 이해창 | tel. 010-7625-0478</h6>
				</div>
				<div class="d-flex flex-column gap-4 text-end">
					<h6 class="fw-semibold text-white">사업자등록번호: 829-36-00813</h6>
					<h6 class="fw-semibold text-white">서울시 용산구 보광로 110, 2층 HWCommander</h6>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
