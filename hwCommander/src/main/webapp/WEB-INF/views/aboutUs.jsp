<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>소개글 - 현우의 컴퓨터 공방</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<!-- 2022.12.06 basic 배경 -> image 변경 -->
	<!-- <div class="basic_background w-100"> -->
	<div class="termsOfService_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="content pt-5 px-5 mx-5" style="width: 70%!important;">
				<h1><b>현우의 컴퓨터 공방</b></h1>
				<p class="mt-5"></p>
				<h2><b>현우의 컴퓨터 공방이란?</b></h2>
				<p class="mt-5"></p>

				<p>가격을 보니 조립식이 좋고, 맡기자니 ‘호구’가 될까봐 두렵고<br>
				일체형은 또 너무 비싸고… 컴퓨터를 새로 사려니 머리가 아파오는 당신!</p>
				<p>우리 현우의 컴퓨터 공방은 컴퓨터 덕후 현우를 필두로<br>
				이 세가지의 장점을 모두 잡기 위해 노력하는 업체입니다.</p>
				<p>기업의 AS수준, 구매는 편리하게, 사용할 때에는 쾌적하게!</p>
				<p>AS수준을 지속적으로 향상시키기 위한 자체적으로 수리 커뮤니티를 구성하고<br>
				알고리즘에 따른 자동 견적추천 프로그램을 사용한 간편한 구매</p>
				<p>그리고 ‘새 것’이지만 받자마자 ‘내 것’처럼 쓸 수 있는.<br>
				저희는 이런 PC가 만들고 싶은 친구들입니다!</p>
				
				<p class="mt-5"></p>
				<img class="mx-5 mb-2" width="120" height="120" src="/resources/img/quality-free-img.png">
				<p class="mt-2"></p>
				<h5><b>최고의 상태</b></h5>
				<p class="mt-4"></p>
				<p>만들어지는 순간부터 도착하는 시간까지<br>
				최상의 상태를 유지할 수 있는</p>
				
				<p class="mt-5"></p>
				<img class="mx-5 mb-2" width="120" height="120" src="/resources/img/tag-free-img.png">
				<p class="mt-2"></p>
				<h5><b>최상의 효율</b></h5>
				<p class="mt-4"></p>
				<p>더도 말고 덜도 말고<br>
				나에게 딱 필요하고 알맞는 상품을</p>
				
				<p class="mt-5"></p>
				<img class="mx-5 mb-2" width="120" height="120" src="/resources/img/lock-free-img.png">
				<p class="mt-2"></p>
				<h5><b>안전배송</b></h5>
				<p class="mt-4"></p>
				<p>고객분이 집에서 만나볼 수 있을 그때까지<br>
				튼튼하고 안전하게 배송해드립니다.</p>
				
				<p class="mt-5"></p>
				
			
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		</div>
	</div>
	<%@ include file="./common/footer.jsp" %>
</body>
</html>
