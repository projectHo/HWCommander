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
<!-- mobile js 추가 -->
<script src="/resources/js/header.js"></script>
<script>
<%-- var loginUser = '<%=(String)session.getAttribute("loginUser")%>'; --%>
    $(function() {
    });
    
function goCartPage() {
	if(loginCheck()) {
		location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
	}
}

function goOrderListPage() {
	let width = window.outerWidth;
	if(width >=1440){
		if(loginCheck()) {
			location.href = "/user/orderList.do";
		}
	}else {
		if(loginCheck()) {
			location.href = '/user/infoM.do';
		}
	}
}

function goServiceCenterPage() {
	if(loginCheck()) {
		alert("준비중");
	}
}

function logout() {
	if(confirm("로그아웃 하시겠습니까?")) {
		location.href = "/user/logoutLogic.do";
	}
}

function goMyPage() {
	if(loginCheck()) {
		location.href ="/user/myPage.do";
	}
}

function goAdminPage() {
	if(loginCheck()) {
		location.href = "/admin/main.do";
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
							<!-- 2023.05.20 로고수정
								<img width="300" height="167" src="/resources/img/cropped-cpLogo-300x167.png">
							 -->	
								<img width="274" height="190" src="/resources/img/comlogo09-821x569.png">
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
										<a class="nav-link text-nowrap" href="/user/login.do">로그인</a>
										<span class="navbar-text">|</span>
								        <a class="nav-link text-nowrap" href="javascript:goCartPage()">견적저장소</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link text-nowrap" href="javascript:goOrderListPage()">주문내역</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link text-nowrap" href="javascript:goServiceCenterPage()">고객센터</a>
									</c:if>
									<!-- 고객 로그인 시 -->
									<c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
										<a class="nav-link text-nowrap" href="javascript:logout()">로그아웃</a>
										<span class="navbar-text">|</span>
										<a class="nav-link text-nowrap" href="javascript:goMyPage()">MyPage</a>
							        	<span class="navbar-text">|</span>
								        <a class="nav-link text-nowrap" href="javascript:goCartPage()">견적저장소</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link text-nowrap" href="javascript:goOrderListPage()">주문내역</a>
								        <span class="navbar-text">|</span>
								        <a class="nav-link text-nowrap" href="javascript:goServiceCenterPage()">고객센터</a>
									</c:if>
									<!-- 관리자 로그인 시 -->
									<c:if test="${loginUser != null && loginUser.userTypeCd == '01'}">
										<a class="nav-link text-nowrap" href="javascript:logout()">로그아웃</a>
										<span class="navbar-text">|</span>
										<a class="nav-link text-nowrap" href="javascript:goAdminPage()">AdminPage</a>
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
					<div id="mainMenu" class="mt-2" style="display: none;">
						<nav class="navbar navbar-dark navbar-expand-lg">
						  <div class="container-fluid">
						    <div class="collapse navbar-collapse justify-content-around">
						      <div class="navbar-nav">
						        <h3><a class="nav-link mx-5" href="/aboutUs.do">회사소개</a></h3>
								<!--
						        <h3><a class="nav-link mx-5" href="/productMall.do">완본체 몰(폐기예정)</a></h3>
						        -->
						        <h3><a class="nav-link mx-5" href="/userBanpumMall.do">이벤트몰</a></h3>
						        <!-- <h3><a class="nav-link mx-5" href="javascript:alert('준비중')">문의게시판</a></h3> -->
						        <h3><a class="nav-link mx-5" href="javascript:alert('준비중')">문의게시판</a></h3>
						        <h3><a class="nav-link mx-5" href="/ESCA/ESCASelect.do">견적산출</a></h3>
						      </div>
						    </div>
						  </div>
						</nav>
					</div>
					<div id="mainMenuMobile" style="display: none;">
						<nav class="navbar fixed-bottom navbar-expand-sm navbar-light bg-white rounded-top" style="font-size: 14px; padding-bottom: 0;">
							<div class="container-fluid">
							  <div class="navbar-collapse">
								<ul class="navbar-nav justify-content-between w-100 flex-row">
									<!-- 비로그인 시 -->
									<c:if test="${loginUser == null}">
										<li class="nav-item d-flex flex-column align-items-center border-end w-25 bordered-li">
											<svg width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M6 17C6 17.93 6 18.395 6.10222 18.7765C6.37962 19.8117 7.18827 20.6204 8.22354 20.8978C8.60504 21 9.07003 21 10 21H16.2C17.8802 21 18.7202 21 19.362 20.673C19.9265 20.3854 20.3854 19.9265 20.673 19.362C21 18.7202 21 17.8802 21 16.2V7.8C21 6.11984 21 5.27976 20.673 4.63803C20.3854 4.07354 19.9265 3.6146 19.362 3.32698C18.7202 3 17.8802 3 16.2 3H10C9.07003 3 8.60504 3 8.22354 3.10222C7.18827 3.37962 6.37962 4.18827 6.10222 5.22354C6 5.60504 6 6.07003 6 7M12 8L16 12M16 12L12 16M16 12H3" stroke="#000000" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
											<a class="nav-link" href="/user/login.do">로그인</a>
										</li>
										<li class="nav-item d-flex flex-column align-items-center border-end w-25 bordered-li">
											<svg width="32px" height="32px" viewBox="-0.24 -0.24 24.48 24.48" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M9.15316 5.40838C10.4198 3.13613 11.0531 2 12 2C12.9469 2 13.5802 3.13612 14.8468 5.40837L15.1745 5.99623C15.5345 6.64193 15.7144 6.96479 15.9951 7.17781C16.2757 7.39083 16.6251 7.4699 17.3241 7.62805L17.9605 7.77203C20.4201 8.32856 21.65 8.60682 21.9426 9.54773C22.2352 10.4886 21.3968 11.4691 19.7199 13.4299L19.2861 13.9372C18.8096 14.4944 18.5713 14.773 18.4641 15.1177C18.357 15.4624 18.393 15.8341 18.465 16.5776L18.5306 17.2544C18.7841 19.8706 18.9109 21.1787 18.1449 21.7602C17.3788 22.3417 16.2273 21.8115 13.9243 20.7512L13.3285 20.4768C12.6741 20.1755 12.3469 20.0248 12 20.0248C11.6531 20.0248 11.3259 20.1755 10.6715 20.4768L10.0757 20.7512C7.77268 21.8115 6.62118 22.3417 5.85515 21.7602C5.08912 21.1787 5.21588 19.8706 5.4694 17.2544L5.53498 16.5776C5.60703 15.8341 5.64305 15.4624 5.53586 15.1177C5.42868 14.773 5.19043 14.4944 4.71392 13.9372L4.2801 13.4299C2.60325 11.4691 1.76482 10.4886 2.05742 9.54773C2.35002 8.60682 3.57986 8.32856 6.03954 7.77203L6.67589 7.62805C7.37485 7.4699 7.72433 7.39083 8.00494 7.17781C8.28555 6.96479 8.46553 6.64194 8.82547 5.99623L9.15316 5.40838Z" stroke="#1C274C" stroke-width="1.128"></path> </g></svg>
											<a class="nav-link" href="/userBanpumMall.do">이벤트몰</a>
										</li>
										<li class="nav-item d-flex flex-column align-items-center border-end w-25 bordered-li">
											<svg width="32px" height="32px" viewBox="-1.44 -1.44 26.88 26.88" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.00024000000000000003"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M11.9426 1.25H12.0574C14.3658 1.24999 16.1748 1.24998 17.5863 1.43975C19.031 1.63399 20.1711 2.03933 21.0659 2.93414C21.9607 3.82895 22.366 4.96897 22.5603 6.41371C22.75 7.82519 22.75 9.63423 22.75 11.9426V12.0574C22.75 14.3658 22.75 16.1748 22.5603 17.5863C22.366 19.031 21.9607 20.1711 21.0659 21.0659C20.1711 21.9607 19.031 22.366 17.5863 22.5603C16.1748 22.75 14.3658 22.75 12.0574 22.75H11.9426C9.63423 22.75 7.82519 22.75 6.41371 22.5603C4.96897 22.366 3.82895 21.9607 2.93414 21.0659C2.03933 20.1711 1.63399 19.031 1.43975 17.5863C1.24998 16.1748 1.24999 14.3658 1.25 12.0574V11.9426C1.24999 9.63423 1.24998 7.82519 1.43975 6.41371C1.63399 4.96897 2.03933 3.82895 2.93414 2.93414C3.82895 2.03933 4.96897 1.63399 6.41371 1.43975C7.82519 1.24998 9.63423 1.24999 11.9426 1.25ZM6.61358 2.92637C5.33517 3.09825 4.56445 3.42514 3.9948 3.9948C3.42514 4.56445 3.09825 5.33517 2.92637 6.61358C2.75159 7.91356 2.75 9.62177 2.75 12C2.75 14.3782 2.75159 16.0864 2.92637 17.3864C3.09825 18.6648 3.42514 19.4355 3.9948 20.0052C4.56445 20.5749 5.33517 20.9018 6.61358 21.0736C7.91356 21.2484 9.62177 21.25 12 21.25C14.3782 21.25 16.0864 21.2484 17.3864 21.0736C18.6648 20.9018 19.4355 20.5749 20.0052 20.0052C20.5749 19.4355 20.9018 18.6648 21.0736 17.3864C21.2484 16.0864 21.25 14.3782 21.25 12C21.25 9.62177 21.2484 7.91356 21.0736 6.61358C20.9018 5.33517 20.5749 4.56445 20.0052 3.9948C19.4355 3.42514 18.6648 3.09825 17.3864 2.92637C16.0864 2.75159 14.3782 2.75 12 2.75C9.62177 2.75 7.91356 2.75159 6.61358 2.92637Z" fill="#000000"></path> <path fill-rule="evenodd" clip-rule="evenodd" d="M8 5.74998C8.41421 5.74998 8.75 6.08576 8.75 6.49998L8.75 7.74999H10C10.4142 7.74999 10.75 8.08578 10.75 8.49999C10.75 8.91421 10.4142 9.24999 10 9.24999H8.75V10.5C8.75 10.9142 8.41421 11.25 8 11.25C7.58579 11.25 7.25 10.9142 7.25 10.5V9.24999H6C5.58579 9.24999 5.25 8.91421 5.25 8.49999C5.25 8.08578 5.58579 7.74999 6 7.74999H7.25L7.25 6.49998C7.25 6.08576 7.58579 5.74998 8 5.74998ZM13.25 8.49998C13.25 8.08576 13.5858 7.74998 14 7.74998H18C18.4142 7.74998 18.75 8.08576 18.75 8.49998C18.75 8.91419 18.4142 9.24998 18 9.24998H14C13.5858 9.24998 13.25 8.91419 13.25 8.49998ZM13.25 14.5C13.25 14.0858 13.5858 13.75 14 13.75H18C18.4142 13.75 18.75 14.0858 18.75 14.5C18.75 14.9142 18.4142 15.25 18 15.25H14C13.5858 15.25 13.25 14.9142 13.25 14.5ZM5.96967 13.9697C6.26256 13.6768 6.73744 13.6768 7.03033 13.9697L8.00001 14.9393L8.96967 13.9697C9.26256 13.6768 9.73744 13.6768 10.0303 13.9697C10.3232 14.2626 10.3232 14.7374 10.0303 15.0303L9.06067 16L10.0303 16.9697C10.3232 17.2626 10.3232 17.7374 10.0303 18.0303C9.73742 18.3232 9.26255 18.3232 8.96966 18.0303L8.00001 17.0607L7.03034 18.0303C6.73745 18.3232 6.26258 18.3232 5.96968 18.0303C5.67679 17.7374 5.67679 17.2626 5.96968 16.9697L6.93935 16L5.96967 15.0303C5.67678 14.7374 5.67678 14.2626 5.96967 13.9697ZM13.25 17.5C13.25 17.0858 13.5858 16.75 14 16.75H18C18.4142 16.75 18.75 17.0858 18.75 17.5C18.75 17.9142 18.4142 18.25 18 18.25H14C13.5858 18.25 13.25 17.9142 13.25 17.5Z" fill="#000000"></path> </g></svg>
											<a class="nav-link" href="/ESCA/ESCASelect.do">견적산출</a>
										</li>
										<li class="nav-item d-flex flex-column align-items-center w-25">
											<svg width="32px" height="32px" viewBox="0 0 16 16" id="company-small-16px" xmlns="http://www.w3.org/2000/svg" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <rect id="Retângulo_223" data-name="Retângulo 223" width="16" height="16" fill="#ccc" opacity="0"></rect> <g id="Icone" transform="translate(0.648 -0.621)"> <g id="Retângulo_203" data-name="Retângulo 203" transform="translate(2.352 2.621)" fill="none" stroke="#000000" stroke-width="1"> <path d="M1,0H9a1,1,0,0,1,1,1V12a0,0,0,0,1,0,0H0a0,0,0,0,1,0,0V1A1,1,0,0,1,1,0Z" stroke="none"></path> <rect x="0.5" y="0.5" width="9" height="11" rx="0.5" fill="none"></rect> </g> <g id="Retângulo_227" data-name="Retângulo 227" transform="translate(5.352 9.621)" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"> <rect width="4" height="5" stroke="none"></rect> <rect x="0.5" y="0.5" width="3" height="4" fill="none"></rect> </g> <g id="Grupo_334" data-name="Grupo 334"> <g id="Retângulo_206" data-name="Retângulo 206" transform="translate(5.352 5.621)" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"> <rect width="1" height="1" stroke="none"></rect> <rect x="0.5" y="0.5" fill="none"></rect> </g> <g id="Retângulo_225" data-name="Retângulo 225" transform="translate(5.352 7.621)" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"> <rect width="1" height="1" stroke="none"></rect> <rect x="0.5" y="0.5" fill="none"></rect> </g> <g id="Retângulo_224" data-name="Retângulo 224" transform="translate(8.352 5.621)" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"> <rect width="1" height="1" stroke="none"></rect> <rect x="0.5" y="0.5" fill="none"></rect> </g> <g id="Retângulo_226" data-name="Retângulo 226" transform="translate(8.352 7.621)" fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="1"> <rect width="1" height="1" stroke="none"></rect> <rect x="0.5" y="0.5" fill="none"></rect> </g> </g> </g> </g></svg>
											<a class="nav-link" href="javascript:goCartPage()">회사소개</a>
										</li>
									</c:if>
									<!-- 고객 로그인 시 -->
									<c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
										<li class="nav-item d-flex flex-column align-items-center border-end w-25 bordered-li">
										  <svg width="32px" height="32px" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg" stroke-width="3" stroke="#000000" fill="none"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><circle cx="32" cy="18.14" r="11.14"></circle><path d="M54.55,56.85A22.55,22.55,0,0,0,32,34.3h0A22.55,22.55,0,0,0,9.45,56.85Z"></path></g></svg>
										  <a class="nav-link" href="javascript:goMyPage()">마이페이지</a>
										</li>
										<li class="nav-item d-flex flex-column align-items-center border-end w-25 bordered-li">
											<svg width="32px" height="32px" viewBox="-0.24 -0.24 24.48 24.48" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M9.15316 5.40838C10.4198 3.13613 11.0531 2 12 2C12.9469 2 13.5802 3.13612 14.8468 5.40837L15.1745 5.99623C15.5345 6.64193 15.7144 6.96479 15.9951 7.17781C16.2757 7.39083 16.6251 7.4699 17.3241 7.62805L17.9605 7.77203C20.4201 8.32856 21.65 8.60682 21.9426 9.54773C22.2352 10.4886 21.3968 11.4691 19.7199 13.4299L19.2861 13.9372C18.8096 14.4944 18.5713 14.773 18.4641 15.1177C18.357 15.4624 18.393 15.8341 18.465 16.5776L18.5306 17.2544C18.7841 19.8706 18.9109 21.1787 18.1449 21.7602C17.3788 22.3417 16.2273 21.8115 13.9243 20.7512L13.3285 20.4768C12.6741 20.1755 12.3469 20.0248 12 20.0248C11.6531 20.0248 11.3259 20.1755 10.6715 20.4768L10.0757 20.7512C7.77268 21.8115 6.62118 22.3417 5.85515 21.7602C5.08912 21.1787 5.21588 19.8706 5.4694 17.2544L5.53498 16.5776C5.60703 15.8341 5.64305 15.4624 5.53586 15.1177C5.42868 14.773 5.19043 14.4944 4.71392 13.9372L4.2801 13.4299C2.60325 11.4691 1.76482 10.4886 2.05742 9.54773C2.35002 8.60682 3.57986 8.32856 6.03954 7.77203L6.67589 7.62805C7.37485 7.4699 7.72433 7.39083 8.00494 7.17781C8.28555 6.96479 8.46553 6.64194 8.82547 5.99623L9.15316 5.40838Z" stroke="#1C274C" stroke-width="1.128"></path> </g></svg>
											<a class="nav-link" href="/userBanpumMall.do">이벤트몰</a>
										</li>
										<li class="nav-item d-flex flex-column align-items-center border-end w-25 bordered-li">
											<svg width="32px" height="32px" viewBox="-1.44 -1.44 26.88 26.88" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.00024000000000000003"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M11.9426 1.25H12.0574C14.3658 1.24999 16.1748 1.24998 17.5863 1.43975C19.031 1.63399 20.1711 2.03933 21.0659 2.93414C21.9607 3.82895 22.366 4.96897 22.5603 6.41371C22.75 7.82519 22.75 9.63423 22.75 11.9426V12.0574C22.75 14.3658 22.75 16.1748 22.5603 17.5863C22.366 19.031 21.9607 20.1711 21.0659 21.0659C20.1711 21.9607 19.031 22.366 17.5863 22.5603C16.1748 22.75 14.3658 22.75 12.0574 22.75H11.9426C9.63423 22.75 7.82519 22.75 6.41371 22.5603C4.96897 22.366 3.82895 21.9607 2.93414 21.0659C2.03933 20.1711 1.63399 19.031 1.43975 17.5863C1.24998 16.1748 1.24999 14.3658 1.25 12.0574V11.9426C1.24999 9.63423 1.24998 7.82519 1.43975 6.41371C1.63399 4.96897 2.03933 3.82895 2.93414 2.93414C3.82895 2.03933 4.96897 1.63399 6.41371 1.43975C7.82519 1.24998 9.63423 1.24999 11.9426 1.25ZM6.61358 2.92637C5.33517 3.09825 4.56445 3.42514 3.9948 3.9948C3.42514 4.56445 3.09825 5.33517 2.92637 6.61358C2.75159 7.91356 2.75 9.62177 2.75 12C2.75 14.3782 2.75159 16.0864 2.92637 17.3864C3.09825 18.6648 3.42514 19.4355 3.9948 20.0052C4.56445 20.5749 5.33517 20.9018 6.61358 21.0736C7.91356 21.2484 9.62177 21.25 12 21.25C14.3782 21.25 16.0864 21.2484 17.3864 21.0736C18.6648 20.9018 19.4355 20.5749 20.0052 20.0052C20.5749 19.4355 20.9018 18.6648 21.0736 17.3864C21.2484 16.0864 21.25 14.3782 21.25 12C21.25 9.62177 21.2484 7.91356 21.0736 6.61358C20.9018 5.33517 20.5749 4.56445 20.0052 3.9948C19.4355 3.42514 18.6648 3.09825 17.3864 2.92637C16.0864 2.75159 14.3782 2.75 12 2.75C9.62177 2.75 7.91356 2.75159 6.61358 2.92637Z" fill="#000000"></path> <path fill-rule="evenodd" clip-rule="evenodd" d="M8 5.74998C8.41421 5.74998 8.75 6.08576 8.75 6.49998L8.75 7.74999H10C10.4142 7.74999 10.75 8.08578 10.75 8.49999C10.75 8.91421 10.4142 9.24999 10 9.24999H8.75V10.5C8.75 10.9142 8.41421 11.25 8 11.25C7.58579 11.25 7.25 10.9142 7.25 10.5V9.24999H6C5.58579 9.24999 5.25 8.91421 5.25 8.49999C5.25 8.08578 5.58579 7.74999 6 7.74999H7.25L7.25 6.49998C7.25 6.08576 7.58579 5.74998 8 5.74998ZM13.25 8.49998C13.25 8.08576 13.5858 7.74998 14 7.74998H18C18.4142 7.74998 18.75 8.08576 18.75 8.49998C18.75 8.91419 18.4142 9.24998 18 9.24998H14C13.5858 9.24998 13.25 8.91419 13.25 8.49998ZM13.25 14.5C13.25 14.0858 13.5858 13.75 14 13.75H18C18.4142 13.75 18.75 14.0858 18.75 14.5C18.75 14.9142 18.4142 15.25 18 15.25H14C13.5858 15.25 13.25 14.9142 13.25 14.5ZM5.96967 13.9697C6.26256 13.6768 6.73744 13.6768 7.03033 13.9697L8.00001 14.9393L8.96967 13.9697C9.26256 13.6768 9.73744 13.6768 10.0303 13.9697C10.3232 14.2626 10.3232 14.7374 10.0303 15.0303L9.06067 16L10.0303 16.9697C10.3232 17.2626 10.3232 17.7374 10.0303 18.0303C9.73742 18.3232 9.26255 18.3232 8.96966 18.0303L8.00001 17.0607L7.03034 18.0303C6.73745 18.3232 6.26258 18.3232 5.96968 18.0303C5.67679 17.7374 5.67679 17.2626 5.96968 16.9697L6.93935 16L5.96967 15.0303C5.67678 14.7374 5.67678 14.2626 5.96967 13.9697ZM13.25 17.5C13.25 17.0858 13.5858 16.75 14 16.75H18C18.4142 16.75 18.75 17.0858 18.75 17.5C18.75 17.9142 18.4142 18.25 18 18.25H14C13.5858 18.25 13.25 17.9142 13.25 17.5Z" fill="#000000"></path> </g></svg>
											<a class="nav-link" href="/ESCA/ESCASelect.do">견적산출</a>
										</li>
										<li class="nav-item d-flex flex-column align-items-center w-25">
											<svg width="32px" height="32px" viewBox="0 0 24.00 24.00" fill="none" xmlns="http://www.w3.org/2000/svg" transform="rotate(90)matrix(1, 0, 0, -1, 0, 0)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M8 13V8M16 16V8M12 10V8M7.2 4H16.8C17.9201 4 18.4802 4 18.908 4.21799C19.2843 4.40973 19.5903 4.71569 19.782 5.09202C20 5.51984 20 6.0799 20 7.2V16.8C20 17.9201 20 18.4802 19.782 18.908C19.5903 19.2843 19.2843 19.5903 18.908 19.782C18.4802 20 17.9201 20 16.8 20H7.2C6.0799 20 5.51984 20 5.09202 19.782C4.71569 19.5903 4.40973 19.2843 4.21799 18.908C4 18.4802 4 17.9201 4 16.8V7.2C4 6.0799 4 5.51984 4.21799 5.09202C4.40973 4.71569 4.71569 4.40973 5.09202 4.21799C5.51984 4 6.0799 4 7.2 4Z" stroke="#000000" stroke-width="0.9600000000000002" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
											<a class="nav-link" href="javascript:goCartPage()">견적저장소</a>
										</li>
									</c:if>
									<!-- 관리자 로그인 시 -->
									<c:if test="${loginUser != null && loginUser.userTypeCd == '01'}">
										<li class="nav-item d-flex flex-column align-items-center border-end w-50 bordered-li">
											<svg width="32px" height="32px" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg" stroke-width="3" stroke="#000000" fill="none"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><circle cx="32" cy="18.14" r="11.14"></circle><path d="M54.55,56.85A22.55,22.55,0,0,0,32,34.3h0A22.55,22.55,0,0,0,9.45,56.85Z"></path></g></svg>
											<a class="nav-link" href="javascript:logout()">로그아웃</a>
										</li>
										<li class="nav-item d-flex flex-column align-items-center w-50">
											<svg width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M11.0175 19C10.6601 19 10.3552 18.7347 10.297 18.373C10.2434 18.0804 10.038 17.8413 9.76171 17.75C9.53658 17.6707 9.31645 17.5772 9.10261 17.47C8.84815 17.3365 8.54289 17.3565 8.30701 17.522C8.02156 17.7325 7.62943 17.6999 7.38076 17.445L6.41356 16.453C6.15326 16.186 6.11944 15.7651 6.33361 15.458C6.49878 15.2105 6.52257 14.8914 6.39601 14.621C6.31262 14.4332 6.23906 14.2409 6.17566 14.045C6.08485 13.7363 5.8342 13.5051 5.52533 13.445C5.15287 13.384 4.8779 13.0559 4.87501 12.669V11.428C4.87303 10.9821 5.18705 10.6007 5.61601 10.528C5.94143 10.4645 6.21316 10.2359 6.33751 9.921C6.37456 9.83233 6.41356 9.74433 6.45451 9.657C6.61989 9.33044 6.59705 8.93711 6.39503 8.633C6.1424 8.27288 6.18119 7.77809 6.48668 7.464L7.19746 6.735C7.54802 6.37532 8.1009 6.32877 8.50396 6.625L8.52638 6.641C8.82735 6.84876 9.21033 6.88639 9.54428 6.741C9.90155 6.60911 10.1649 6.29424 10.2375 5.912L10.2473 5.878C10.3275 5.37197 10.7536 5.00021 11.2535 5H12.1115C12.6248 4.99976 13.0629 5.38057 13.1469 5.9L13.1625 5.97C13.2314 6.33617 13.4811 6.63922 13.8216 6.77C14.1498 6.91447 14.5272 6.87674 14.822 6.67L14.8707 6.634C15.2842 6.32834 15.8528 6.37535 16.2133 6.745L16.8675 7.417C17.1954 7.75516 17.2366 8.28693 16.965 8.674C16.7522 8.99752 16.7251 9.41325 16.8938 9.763L16.9358 9.863C17.0724 10.2045 17.3681 10.452 17.7216 10.521C18.1837 10.5983 18.5235 11.0069 18.525 11.487V12.6C18.5249 13.0234 18.2263 13.3846 17.8191 13.454C17.4842 13.5199 17.2114 13.7686 17.1083 14.102C17.0628 14.2353 17.0121 14.3687 16.9562 14.502C16.8261 14.795 16.855 15.1364 17.0323 15.402C17.2662 15.7358 17.2299 16.1943 16.9465 16.485L16.0388 17.417C15.7792 17.6832 15.3698 17.7175 15.0716 17.498C14.8226 17.3235 14.5001 17.3043 14.2331 17.448C14.0428 17.5447 13.8475 17.6305 13.6481 17.705C13.3692 17.8037 13.1636 18.0485 13.1099 18.346C13.053 18.7203 12.7401 18.9972 12.3708 19H11.0175Z" stroke="#000000" stroke-width="0.9600000000000002" stroke-linecap="round" stroke-linejoin="round"></path> <path fill-rule="evenodd" clip-rule="evenodd" d="M13.9747 12C13.9747 13.2885 12.9563 14.333 11.7 14.333C10.4437 14.333 9.42533 13.2885 9.42533 12C9.42533 10.7115 10.4437 9.66699 11.7 9.66699C12.9563 9.66699 13.9747 10.7115 13.9747 12Z" stroke="#000000" stroke-width="0.9600000000000002" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
											<a class="nav-link" href="javascript:goAdminPage()">AdminPage</a>
										</li>
									</c:if>
								</ul>
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
