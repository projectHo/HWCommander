<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
<%-- var loginUser = '<%=(String)session.getAttribute("loginUser")%>'; --%>
    $(function(){
    });
    
function goCartPage() {
	if(loginCheck()) {
		alert("장바구니로 이동");
	}
}

function goOrderListPage() {
	if(loginCheck()) {
		alert("주문내역으로 이동");
	}
}

function goServiceCenterPage() {
	if(loginCheck()) {
		alert("고객센터로 이동");
	}
}

function logout() {
	if(confirm("로그아웃 하시겠습니까?")) {
		location.href = "/user/logoutLogic.do";
	}
}

function goMyPage() {
	if(loginCheck()) {
		alert("마이페이지로 이동");
	}
}

function goAdminPage() {
	if(loginCheck()) {
		alert("관리자페이지로 이동");
	}
}

function loginCheck() {
	var check = false;
	if("${loginUser}" == "") {
		alert("로그인 후 이용해주세요.");
		location.href = "/user/login.do";
	}else {
		check = true;
	}
	return check;
}
    
</script>
</head>
<body>
	<div class="header_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 10%!important;"></div>
			<div class="mt-3" style="width: 80%!important;">
				<div class="w-100 row align-items-center mt-4 mb-4">
					<div class="col"></div>
					<div class="col mt-3">
						<div class="d-flex justify-content-center">
							<a href="/">
								<img width="300" height="167" src="/resources/img/cropped-cpLogo-300x167.png">
							</a>
						</div>
					</div>
					<div class="col mx-4 align-self-start">
						<div class="float-end">	
							<nav class="navbar navbar-expand-md">
							  <div class="container-fluid">
							    <div class="collapse navbar-collapse">
							      <div class="navbar-nav">
							      	
							      	<!-- 비 로그인 시 -->
									<c:if test="${loginUser == null}">
										<a class="nav-link" href="/user/login.do">로그인</a>
										<span class="navbar-text">|</span>
								        <a class="nav-link" href="javascript:goCartPage()">장바구니</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link" href="javascript:goOrderListPage()">주문내역</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link" href="javascript:goServiceCenterPage()">고객센터</a>
									</c:if>
									<!-- 고객 로그인 시 -->
									<c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
										<a class="nav-link" href="javascript:logout()">로그아웃</a>
										<span class="navbar-text">|</span>
										<a class="nav-link" href="javascript:goMyPage()">MyPage</a>
							        	<span class="navbar-text">|</span>
								        <a class="nav-link" href="javascript:goCartPage()">장바구니</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link" href="javascript:goOrderListPage()">주문내역</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link" href="javascript:goServiceCenterPage()">고객센터</a>
									</c:if>
									<!-- 관리자 로그인 시 -->
									<c:if test="${loginUser != null && loginUser.userTypeCd == '01'}">
										<a class="nav-link" href="javascript:logout()">로그아웃</a>
										<span class="navbar-text">|</span>
										<a class="nav-link" href="javascript:goAdminPage()">AdminPage</a>
									</c:if>
							      </div>
							    </div>
							  </div>
							</nav>
						</div>
					</div>
				</div>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 10%!important;"></div>
		</div>
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="mt-4" style="width: 70%!important;">
				<div class="w-100 row align-items-center">
					<div id="mainMenu" class="mt-2">
						<nav class="navbar navbar-dark navbar-expand-lg">
						  <div class="container-fluid">
						    <div class="collapse navbar-collapse justify-content-around">
						      <div class="navbar-nav">
						        <h3><a class="nav-link mx-5" href="javascript:alert('준비중')">Online</a></h3>
						        <h3><a class="nav-link mx-5" href="javascript:alert('준비중')">Computer List</a></h3>
						        <h3><a class="nav-link mx-5" href="javascript:alert('준비중')">Week Best</a></h3>
						        <h3><a class="nav-link mx-5" href="javascript:alert('준비중')">Event</a></h3>
						        <h3><a class="nav-link mx-5" href="javascript:alert('준비중')">Customer Service</a></h3>
						      </div>
						    </div>
						  </div>
						</nav>
					</div>
				</div>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		</div>
	</div>
</body>
</html>
